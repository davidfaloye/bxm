import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frideos_core/frideos_core.dart';
import 'package:xman/src/screens/summary_page.dart';

import '../models/models.dart';
import '../models/question.dart';
import '../models/trivia_stats.dart';

const refreshTime = 100;

class TriviaBloc {
//  TriviaBloc({this.countdownStream, this.questions, this.tabController}) {
//    // Getting the questions from the API
//    questions.onChange((data) {
//      if (data.isNotEmpty) {
//        final questions = data..shuffle();
//        _startTrivia(context,questions);
//      }
//    });
//
//    countdownStream.outTransformed.listen((data) {
//      countdown = 30 * 1000;
//    });
//  }

  // STREAMS
//  final StreamedValue<AppTab> tabController;
  final triviaState = StreamedValue<TriviaState>(initialData: TriviaState());
  final StreamedList<Question> questions;
  final currentQuestion = StreamedValue<Question>();
  final currentTime = StreamedValue<int>(initialData: 0);
  final countdownBar = StreamedValue<double>();
  final answersAnimation = StreamedValue<AnswerAnimation>(
      initialData: AnswerAnimation(chosenAnswerIndex: 0, startPlaying: false));

  // QUESTIONS, ANSWERS, STATS
  int index = 0;
  String chosenAnswer;
  final stats = TriviaStats();
  bool selected;

  // TIMER, COUNTDOWN
  final StreamedTransformed<String, String> countdownStream;
  int countdown; // Milliseconds
  Timer timer;

  void _startTrivia(BuildContext context, List<Question> data) {
    index = 0;
    triviaState.value.questionIndex = 1;

    // To show the main page and summary buttons
    triviaState.value.isTriviaEnd = false;

    // Reset the stats
    stats.reset();

    // To set the initial question (in this case the countdown
    // bar animation won't start).
    currentQuestion.value = data.first;

    Timer(Duration(milliseconds: 1000), () {
      // Setting this flag to true on changing the question
      // the countdown bar animation starts.
      triviaState.value.isTriviaPlaying = true;

      // Stream the first question again with the countdown bar
      // animation.
      currentQuestion.value = data[index];

      playTrivia(context);
    });
  }

  void playTrivia(BuildContext context) {
    timer = Timer.periodic(Duration(milliseconds: refreshTime), (Timer t) {
      currentTime.value = refreshTime * t.tick;

      if (currentTime.value > countdown) {
        currentTime.value = 0;
        timer.cancel();
        notAnswered(context, currentQuestion.value);
        _nextQuestion(context);
      }
    });
  }

  void _endTrivia(BuildContext context) {
    // RESET

    print('timer: ${timer.tick}');
    timer.cancel();
    currentTime.value = 0;
    triviaState.value.isTriviaEnd = true;
    triviaState.refresh();
    stopTimer();

    Timer(Duration(milliseconds: 1500), () {
//      // this is reset here to not trigger the start of the
//      // countdown animation while waiting for the summary page.
      triviaState.value.isAnswerChosen = false;
//      // Show the summary page after 1.5s
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SummaryPage()));
//
//      // Clear the last question so that it doesn't appear
//      // in the next game
      currentQuestion.value = null;
    });
  }

  void notAnswered(BuildContext context, Question question) {
    stats.addNoAnswer(question);
    timer.cancel();
    _endTrivia(context);
  }

  void checkAnswer(BuildContext context, Question question, String answer) {
    if (!triviaState.value.isTriviaEnd) {
      question.chosenAnswerIndex = question.answers.indexOf(answer);
      if (question.isCorrect(answer)) {
        stats.addCorrect(question);
        timer.cancel();
        currentTime.value = 0;
        _nextQuestion(context);
      } else {
        triviaState.value.isTriviaEnd = true;
        _endTrivia(context);
        timer.cancel();
        currentTime.value = 0;
      }
    }
  }

  void _nextQuestion(BuildContext context) {
    index++;

    if (index < questions.length) {
      triviaState.value.questionIndex++;
      currentQuestion.value = questions.value[index];
      playTrivia(context);
      selected = false;
    } else {
      print('next question');
      print(index);
      print(questions.length);
      _endTrivia(context);
      selected = false;
    }
  }

  void stopTimer() {
    // Stop the timer
    timer.cancel();
    // By setting this flag to true the countdown animation will stop
    triviaState.value.isAnswerChosen = true;
    triviaState.refresh();
  }

  void onChosenAnswer(String answer) {
    chosenAnswer = answer;

    stopTimer();

    // Set the chosenAnswer so that the answer widget can put it last on the
    // stack.
    answersAnimation.value.chosenAnswerIndex =
        currentQuestion.value.answers.indexOf(answer);
    answersAnimation.refresh();
  }

  void onChosenAnwserAnimationEnd(BuildContext context) {
    // Reset the flag so that the countdown animation can start
    triviaState.value.isAnswerChosen = false;
    triviaState.refresh();

    checkAnswer(context, currentQuestion.value, chosenAnswer);
  }

  void dispose() {
    answersAnimation.dispose();
    countdownBar.dispose();
    countdownStream.dispose();
    currentQuestion.dispose();
    currentTime.dispose();
    questions.dispose();
    tabController.dispose();
    triviaState.dispose();
  }
}
