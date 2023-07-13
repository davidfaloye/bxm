import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:frideos_core/frideos_core.dart';

import 'package:frideos/frideos.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xman/src/API/api_interface_expert.dart';
import 'package:xman/src/API/trivia_api2.dart';
import 'package:xman/src/models/question_expert.dart';
import 'package:xman/src/models/user.dart';

import '../API/api_interface.dart';
import '../API/mock_api.dart';
import '../API/trivia_api.dart';
import '../blocs/trivia_bloc.dart';
import '../models/category.dart';
import '../models/models.dart';
import '../models/question.dart';
import '../reporsitory/user_reporsitory.dart' as repository;
import '../reporsitory/user_service.dart' as userService;

import '../models/theme.dart';

class AppState extends AppStateModel {
  String guestionType;
  factory AppState() => _singletonAppState;
  bool _isShowTriviaIndicator = false;

  ValueNotifier<User> currentUser = new ValueNotifier(User());

  AppState._internal() {
    print('-------APP STATE INIT--------');
    _createThemes(themes);
    _loadCategories();
    // loadScore();

    countdown.value = 30.toString();
    countdown.setTransformer(validateCountdown);

    questionsAmount.value = 14.toString();
    questionsAmount.setTransformer(validateAmount);

    triviaBloc = TriviaBloc(
        countdownStream: countdown,
        questions: questions,
        tabController: tabController);
  }

  static final AppState _singletonAppState = AppState._internal();

  // THEMES
  final themes = List<MyTheme>();
  final currentTheme = StreamedValue<MyTheme>();

  // API
  QuestionsAPI api = MockAPI();
  QuestionsAPI api2 = TriviaAPIExpert();
  final apiType = StreamedValue<ApiType>(initialData: ApiType.remote);

  // TABS
  final tabController = StreamedValue<AppTab>(initialData: AppTab.main);

  // TRIVIA
  final categoriesStream = StreamedList<Category>();
  final categoryChosen = StreamedValue<Category>();
  final questions = StreamedList<Question>();
  final questionsExpert = StreamedList<Question>();
  final questionsDifficulty =
      StreamedValue<QuestionDifficulty>(initialData: QuestionDifficulty.medium);

  final questionsExpertDifficulty = StreamedValue<QuestionExpertDifficulty>(
      initialData: QuestionExpertDifficulty.medium);
  final questionsAmount = StreamedTransformed<String, String>();

  final validateAmount =
      StreamTransformer<String, String>.fromHandlers(handleData: (str, sink) {
    if (str.isNotEmpty) {
      final amount = int.tryParse(str);
      if (amount > 1 && amount <= 15) {
        sink.add(str);
      } else {
        sink.addError('Insert a value from 2 to 15..');
      }
    } else {
      sink.addError('Insert a value.');
    }
  });

  // BLOC
  TriviaBloc triviaBloc;

  // COUNTDOWN
  final countdown = StreamedTransformed<String, String>();

  final validateCountdown =
      StreamTransformer<String, String>.fromHandlers(handleData: (str, sink) {
    if (str.isNotEmpty) {
      final time = int.tryParse(str);
      if (time >= 3 && time <= 90) {
        sink.add(str);
      } else {
        sink.addError('Insert a value from 3 to 90 seconds.');
      }
    } else {
      sink.addError('Insert a value.');
    }
  });

  @override
  Future<void> init() async {
    final String lastTheme = await Prefs.getPref('apptheme');
    if (lastTheme != null) {
      currentTheme.value = themes.firstWhere((theme) => theme.name == lastTheme,
          orElse: () => themes[0]);
    } else {
      currentTheme.value = themes[0];
    }
  }

  Future _loadCategories() async {
    final isLoaded = await api.getCategories(categoriesStream);
    if (isLoaded) {
      categoryChosen.value = categoriesStream.value.last;
    }
  }

  Future _loadQuestions() async {
    await api.getQuestions(
        questions: questions,
        number: int.parse(questionsAmount.value),
        category: categoryChosen.value,
        difficulty: questionsDifficulty.value,
        type: QuestionType.multiple);
    setIsShowTriviaIndicator(false);
  }

  Future _loadQuestionsExpert() async {
    await api2.getQuestions(
        questions: questionsExpert,
        number: int.parse(questionsAmount.value),
        category: categoryChosen.value,
        difficulty: questionsDifficulty.value,
        type: QuestionType.multiple);
    setIsShowTriviaIndicator(false);
  }

  void setCategory(Category category) => categoryChosen.value = category;

  void setDifficulty(QuestionDifficulty difficulty) =>
      questionsDifficulty.value = difficulty;

  void setApiType(ApiType type) {
    if (apiType.value != type) {
      apiType.value = type;
      if (type == ApiType.remote) {
        api = TriviaAPI();
      } else {
        api = TriviaAPI();
      }
      _loadCategories();
    }
  }

  void _createThemes(List<MyTheme> themes) {
    themes.addAll([
      MyTheme(
        name: 'Default',
        brightness: Brightness.dark,
        backgroundColor: const Color(0xFF4D0953),
        scaffoldBackgroundColor: const Color(0xFF4D0953),
        primaryColor: const Color(0xFF4D0953),
        primaryColorBrightness: Brightness.dark,
        accentColor: Colors.blue[300],
      ),
      MyTheme(
        name: 'Dark',
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        primaryColor: Colors.blueGrey[900],
        primaryColorBrightness: Brightness.dark,
        accentColor: Colors.blue[900],
      ),
    ]);
  }

  final isShowTriviaIndicator = StreamedValue<bool>(initialData: false);
  setIsShowTriviaIndicator(bool value) {
    isShowTriviaIndicator.value = value;
  }

  void setTheme(MyTheme theme) {
    currentTheme.value = theme;
    Prefs.savePref<String>('apptheme', theme.name);
  }

  set _changeTab(AppTab appTab) => tabController.value = appTab;

  void startTrivia() {
    // userService.loadScore();

    setIsShowTriviaIndicator(true);
    _loadQuestions();
    triviaBloc.stats.reset();
    //  _loadQuestionsExpert();
    _changeTab = AppTab.trivia;
  }

  void startTriviaExpert() {
    setIsShowTriviaIndicator(true);
    _loadQuestionsExpert();
    _changeTab = AppTab.trivia;
  }

  void longQuestion() {
    guestionType = "experts";
    setIsShowTriviaIndicator(true);
    _loadQuestions();
    _changeTab = AppTab.trivia;
  }

  Future<void> loadScore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (currentUser.value.auth == null && prefs.containsKey('current_user')) {
      currentUser.value =
          User.fromJSON(json.decode(await prefs.get('current_user')));
      currentUser.value.auth = true;

      print(currentUser.value.apiToken);
    } else {
      currentUser.value.auth = false;
    }
    currentUser.notifyListeners();
    return currentUser.value;
  }

  void endTrivia() => tabController.value = AppTab.main;

  void showSummary() => tabController.value = AppTab.summary;

  @override
  void dispose() {
    print('---------APP STATE DISPOSE-----------');
    apiType.dispose();
    categoryChosen.dispose();
    countdown.dispose();
    currentTheme.dispose();
    questionsExpert.dispose();
    questions.dispose();
    questionsAmount.dispose();
    questionsDifficulty.dispose();
    tabController.dispose();
    triviaBloc.dispose();
  }
}
