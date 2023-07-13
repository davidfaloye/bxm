enum QuestionExpertDifficulty { easy, medium, hard }

enum QuestionExpertType { boolean, multiple }

class QuestionExpertModel {
  QuestionExpertModel({this.question, this.correctAnswer, this.incorrectAnswers});

  factory QuestionExpertModel.fromJson(Map<String, dynamic> json) {
    return QuestionExpertModel(
        question: json['question'],
        correctAnswer: json['correct_answer'],
        incorrectAnswers: (json['incorrect_answers'] as List)
            .map((answer) => answer.toString())
            .toList());
  }

  String question;
  String correctAnswer;
  List<String> incorrectAnswers;
}

class QuestionExpert{
  QuestionExpert({this.question, this.answers, this.correctAnswerIndex});
  factory QuestionExpert.fromQuestionModel(QuestionExpertModel model) {
    final List<String> answers = []
      ..add(model.correctAnswer)
      ..addAll(model.incorrectAnswers)
      ..shuffle();

    final index = answers.indexOf(model.correctAnswer);

    return QuestionExpert(
        question: model.question, answers: answers, correctAnswerIndex: index);
  }

  String question;
  List<String> answers;
  int correctAnswerIndex;
  int chosenAnswerIndex;
  bool selected;

  bool isCorrect(String answer) {
    return answers.indexOf(answer) == correctAnswerIndex;
  }

  bool isChosen(String answer) {
    return answers.indexOf(answer) == chosenAnswerIndex;
  }
}
 