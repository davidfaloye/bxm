import 'package:flutter/material.dart';
import 'package:xman/src/constance/constance.dart';

enum QuestionState {
  isUnAnswered,
  isCheckPoint,
  isPassedCheckpoint,
  isAnswered,
  isCurrent
}

class LevelBarWidget extends StatelessWidget {
  final QuestionState questionState;
  final String amount;
  final String coinValue;

  const LevelBarWidget({this.questionState, this.amount, this.coinValue});
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: questionState == QuestionState.isAnswered ||
              questionState == QuestionState.isPassedCheckpoint
          ? 0.45
          : 1,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.045,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(ConstanceData.question_bar_line))),
        child: SizedBox(
          width: MediaQuery.of(context).size.width -
              ((MediaQuery.of(context).size.width * 1 / 5) * 2),
          child: Stack(
            children: <Widget>[
              Center(
                child: questionState == QuestionState.isCheckPoint ||
                        questionState == QuestionState.isPassedCheckpoint
                    ? Image.asset(
                        ConstanceData.checkpoint_bar,
                        alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height * 0.045,
                        fit: BoxFit.fill,
                      )
                    : questionState == QuestionState.isCurrent
                        ? Image.asset(
                            ConstanceData.green_bar,
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.045,
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width -
                                ((MediaQuery.of(context).size.width * 1 / 5) *
                                    2),
                          )
                        : Image.asset(
                            ConstanceData.un_answered_bar,
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.045,
                            fit: BoxFit.fill,
//                        width: MediaQuery.of(context).size.width -
//                            ((MediaQuery.of(context).size.width * 1 / 5) * 2),
                          ),
              ),
              content(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget content(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.045,
        width: MediaQuery.of(context).size.width -
            ((MediaQuery.of(context).size.width * 1 / 5) * 2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 24,
            ),
            SizedBox(
              width: 85,
              child: Text(
                '\$$amount',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(
              width: 36,
            ),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(ConstanceData.coin)),
              ),
              padding: const EdgeInsets.all(6.2),
              margin: const EdgeInsets.all(8),
              child: Image.asset(
                ConstanceData.b,
                fit: BoxFit.fill,
//                          height: MediaQuery.of(context).size.height * 0.002,
              ),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              '$coinValue',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
