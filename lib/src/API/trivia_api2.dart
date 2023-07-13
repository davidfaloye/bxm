import 'dart:async';

import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

import 'package:frideos_core/frideos_core.dart';

import '../models/category.dart';
import '../models/question.dart';

import 'api_interface.dart';

class TriviaAPIExpert implements QuestionsAPI {
  @override
  Future<bool> getCategories(StreamedList<Category> categories) async {
    const categoriesURL = 'http://http://xman.rorbible.plus/api/get_categories';
    final response = await http.get(categoriesURL);

    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final result = (jsonResponse['trivia_categories'] as List)
          .map((category) => Category.fromJson(category));

      categories.value = [];
      categories
        ..addAll(result)
        ..addElement(Category(id: 0, name: 'Any category'));
      return true;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
  }

  @override
  Future<bool> getQuestions(
      {StreamedList<Question> questions,
      int number,
      Category category,
      QuestionDifficulty difficulty,
      QuestionType type}) async {
    var qdifficulty;
    var qtype;
    switch (difficulty) {
      case QuestionDifficulty.easy:
        qdifficulty = 'easy';
        break;
      case QuestionDifficulty.medium:
        qdifficulty = 'medium';
        break;
      case QuestionDifficulty.hard:
        qdifficulty = 'hard';
        break;
      default:
        qdifficulty = 'medium';
        break;
    }
    // switch(){

    // }

    switch (type) {
      case QuestionType.boolean:
        qtype = 'boolean';
        break;
      case QuestionType.multiple:
        qtype = 'multiple';
        break;
      default:
        qtype = 'multiple';
        break;
    }

    final url = 'http://xman.rorbible.plus/api/api/leaf-question';

    final response = await http.get(url);

    print(response);
    if (response.statusCode == 200) {
      final jsonResponse = convert.jsonDecode(response.body);
      final result = (jsonResponse['result'] as List)
          .map((question) => QuestionModel.fromJson(question));

      questions.value = result
          .map((question) => Question.fromQuestionModel(question))
          .toList();

      return true;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
  }
}
