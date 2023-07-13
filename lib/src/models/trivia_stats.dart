import 'package:xman/src/screens/ladder_board/ladder_board.dart';

import 'question.dart';

class TriviaStats {
  TriviaStats() {
    corrects = [];
    wrongs = [];
    noAnswered = [];
    score = 0;
    wrong = 0;
    coin = 0;
    diamond = 0;
    swap = 0;
    f5050 = 0;
    askAudience = 0;
    lifeCoach = 0;
    leafFaith = 0;
    squadronpack = 0;
    faithPack = 0;
    victoryPack = 0;
  }

  List<Question> corrects;
  List<Question> wrongs;
  List<Question> noAnswered;
  int score;
  int wrong;
  int coin;
  int diamond;
  int swap;
  int f5050;
  int askAudience;
  int lifeCoach;
  int leafFaith;
  int squadronpack;
  int faithPack;
  int victoryPack;

  void addCorrect(Question question) {
    corrects.add(question);
    print('corrects');
    print(corrects.length);

    print('barList');
    print(barList.length);
    score = int.parse(barList
        .elementAt(barList.length - corrects.length)
        .amount
        .replaceAll(',', ''));
    coin = int.parse(
        barList.elementAt(barList.length - corrects.length).coinValue);
    diamond += 1;
    swap += 1;
    f5050 += 1;
    askAudience += 1;
  }

  void addWrong(Question question) {
    wrongs.add(question);
    wrong += 1;
  }

  void addNoAnswer(Question question) {
    noAnswered.add(question);
    score -= 2;
  }

  void reset() {
    corrects = [];
    wrongs = [];
    noAnswered = [];
    score = 0;
    coin = 0;
    wrong = 0;
  }
}
