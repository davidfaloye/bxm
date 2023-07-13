import 'package:flutter/material.dart';
import 'package:xman/src/blocs/trivia_bloc.dart';
import 'package:xman/src/constance/constance.dart';
import 'package:xman/src/screens/ladder_board/widget/level_bar_widget.dart';
import 'package:xman/src/screens/tip_screen.dart';
import 'package:xman/src/screens/trivia_page.dart';
import '../../models/question.dart';

class LadderBoard extends StatefulWidget {
  LadderBoard({Key key, this.bloc, this.question}) : super(key: key);

  final Question question;
  final TriviaBloc bloc;
  @override
  _LadderBoardState createState() => _LadderBoardState();
}

double y = 0.9;
var showCorrect = true;

class BarContent {
  String amount;
  String coinValue;
  QuestionState questionState;
  BarContent({this.questionState, this.amount, this.coinValue});
}

List<BarContent> barList = [
  BarContent(
      amount: '500,000',
      coinValue: '1.8k',
      questionState: QuestionState.isUnAnswered),
  BarContent(
      amount: '250,000',
      coinValue: '1.6k',
      questionState: QuestionState.isUnAnswered),
  BarContent(
      amount: '100,000',
      coinValue: '1.4k',
      questionState: QuestionState.isUnAnswered),
  BarContent(
      amount: '50,000',
      coinValue: '1.2k',
      questionState: QuestionState.isUnAnswered),
  BarContent(
      amount: '25,000',
      coinValue: '1k',
      questionState: QuestionState.isUnAnswered),
  BarContent(
      amount: '15,000',
      coinValue: '900',
      questionState: QuestionState.isUnAnswered),
  BarContent(
      amount: '12,500',
      coinValue: '800',
      questionState: QuestionState.isUnAnswered),
  BarContent(
      amount: '10,000',
      coinValue: '700',
      questionState: QuestionState.isUnAnswered),
  BarContent(
      amount: '7,500',
      coinValue: '600',
      questionState: QuestionState.isUnAnswered),
  BarContent(
      amount: '5,000',
      coinValue: '500',
      questionState: QuestionState.isUnAnswered),
  BarContent(
      amount: '3,000',
      coinValue: '400',
      questionState: QuestionState.isUnAnswered),
  BarContent(
      amount: '2,000',
      coinValue: '300',
      questionState: QuestionState.isUnAnswered),
  BarContent(
      amount: '1,000',
      coinValue: '200',
      questionState: QuestionState.isUnAnswered),
  BarContent(
      amount: '500',
      coinValue: '100',
      questionState: QuestionState.isUnAnswered),
];

class _LadderBoardState extends State<LadderBoard> {
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration(seconds: 2));
    showCorrect = false;
    // controller.forward();
  }

  animateQuestion() {
    if (!isLoaded) {
      isLoaded = true;
      Future.delayed(Duration(seconds: 2), _questionIndex);
    }
  }

  _questionIndex() {
    double deviceFullHeight = MediaQuery.of(context).size.height;
//    double topPadding = deviceFullHeight * 0.24;
//    double imageBarHeight = deviceFullHeight * 0.045;

    double position = ((deviceFullHeight * 0.01) * 2) +
        (((deviceFullHeight * 0.045) *
                widget.bloc.triviaState.value.questionIndex) -
            ((deviceFullHeight * 0.045) / 2));

//    double extremeBottom = bottomPadding;

    print(widget.bloc.triviaState.value.questionIndex);
//    if (widget.bloc.triviaState.value.questionIndex == 1) {
//      setState(() {
//        y = 0.9;
//      });
//    } else if (widget.bloc.triviaState.value.questionIndex == 2) {
//      setState(() {
//        y = position;
//      });
//    } else if (widget.bloc.triviaState.value.questionIndex == 3) {
//      setState(() {
//        y = 0.6 + 2;
//      });
//    } else if (widget.bloc.triviaState.value.questionIndex == 4) {
//      setState(() {
//        y = 0.3;
//      });
//      showDialog(
//        context: context,
//        builder: (BuildContext context) => CustomDialog3(),
//      );
//    } else if (widget.bloc.triviaState.value.questionIndex == 5) {
//      setState(() {
//        y = position;
//      });
//    }

    setState(() {
      y = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    _questionIndex();

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Stack(
          children: <Widget>[
            GestureDetector(
              // onTap: () {
              //   Navigator.pop(context);
              // },
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  ConstanceData.path,
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                ),
              ),
            ),

            Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Image.asset(
                      ConstanceData.goldBar1,
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.1,
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width,
                    ),

//                    Image.asset(
//                      ConstanceData.coin18,
//                      alignment: Alignment.center,
//                      height: MediaQuery.of(context).size.height * 0.045,
//                      fit: BoxFit.fill,
//                      width: MediaQuery.of(context).size.width,
//                    ),
//                    Image.asset(
//                      ConstanceData.coin16,
//                      alignment: Alignment.center,
//                      height: MediaQuery.of(context).size.height * 0.045,
//                      fit: BoxFit.fill,
//                      width: MediaQuery.of(context).size.width,
//                    ),
//                    Image.asset(
//                      ConstanceData.coin14,
//                      alignment: Alignment.center,
//                      height: MediaQuery.of(context).size.height * 0.045,
//                      fit: BoxFit.fill,
//                      width: MediaQuery.of(context).size.width,
//                    ),
//                    Image.asset(
//                      ConstanceData.coin12,
//                      alignment: Alignment.center,
//                      height: MediaQuery.of(context).size.height * 0.045,
//                      fit: BoxFit.fill,
//                      width: MediaQuery.of(context).size.width,
//                    ),
//                    Image.asset(
//                      ConstanceData.coin12,
//                      alignment: Alignment.center,
//                      height: MediaQuery.of(context).size.height * 0.045,
//                      fit: BoxFit.fill,
//                      width: MediaQuery.of(context).size.width,
//                    ),
//                  Image.asset(
//                    ConstanceData.coin11,
//                    alignment: Alignment.center,
//                    fit: BoxFit.fitWidth,
//                    width: MediaQuery.of(context).size.width,
//                  ),
//                    Image.asset(
//                      ConstanceData.coin800,
//                      alignment: Alignment.center,
//                      height: MediaQuery.of(context).size.height * 0.045,
//                      fit: BoxFit.fill,
//                      width: MediaQuery.of(context).size.width,
//                    ),
//                    Image.asset(
//                      ConstanceData.coin700,
//                      alignment: Alignment.center,
//                      height: MediaQuery.of(context).size.height * 0.045,
//                      fit: BoxFit.fill,
//                      width: MediaQuery.of(context).size.width,
//                    ),
//                    Image.asset(
//                      ConstanceData.coin600,
//                      alignment: Alignment.center,
//                      height: MediaQuery.of(context).size.height * 0.045,
//                      fit: BoxFit.fill,
//                      width: MediaQuery.of(context).size.width,
//                    ),
//                    Image.asset(
//                      ConstanceData.coin500,
//                      alignment: Alignment.center,
//                      height: MediaQuery.of(context).size.height * 0.045,
//                      fit: BoxFit.fill,
//                      width: MediaQuery.of(context).size.width,
//                    ),
//                    widget.bloc.triviaState.value.questionIndex >= 2
//                        ? Image.asset(
//                            ConstanceData.coin400,
//                            alignment: Alignment.center,
//                            height: MediaQuery.of(context).size.height * 0.045,
//                            fit: BoxFit.fill,
//                            width: MediaQuery.of(context).size.width,
//                          )
//                        : Image.asset(
//                            ConstanceData.coin400,
//                            alignment: Alignment.center,
//                            height: MediaQuery.of(context).size.height * 0.045,
//                            fit: BoxFit.fill,
//                            width: MediaQuery.of(context).size.width,
//                          ),
//                    widget.bloc.triviaState.value.questionIndex >= 2
//                        ? Image.asset(
//                            ConstanceData.coin300,
//                            alignment: Alignment.center,
//                            height: MediaQuery.of(context).size.height * 0.045,
//                            fit: BoxFit.fill,
//                            width: MediaQuery.of(context).size.width,
//                          )
//                        : Image.asset(
//                            ConstanceData.questionBar3,
//                            alignment: Alignment.center,
//                            height: MediaQuery.of(context).size.height * 0.045,
//                            fit: BoxFit.fill,
//                            width: MediaQuery.of(context).size.width,
//                          ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: barList.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          int pos = (barList.length) -
                              widget.bloc.triviaState.value.questionIndex;
                          print(pos);
                          if (index > pos) {
                            if (index == 4 || index == 9) {
                              barList.elementAt(index).questionState =
                                  QuestionState.isPassedCheckpoint;
                            } else {
                              barList.elementAt(index).questionState =
                                  QuestionState.isAnswered;
                            }
                          } else if (index == pos) {
                            barList.elementAt(index).questionState =
                                QuestionState.isCurrent;
                          } else {
                            if (index == 4 || index == 9) {
                              barList.elementAt(index).questionState =
                                  QuestionState.isCheckPoint;
                            } else {
                              barList.elementAt(index).questionState =
                                  QuestionState.isUnAnswered;
                            }
                          }

//                          if (index >= pos) {
//                            if (index == pos - 1) {
//                              _barList.elementAt(index).questionState =
//                                  QuestionState.isCurrent;
//                            } else if (index == 4 || index == 9) {
//                              if (index == pos - 1) {
//                                _barList.elementAt(index).questionState =
//                                    QuestionState.isCurrent;
//                              } else {
//                                _barList.elementAt(index).questionState =
//                                    QuestionState.isCheckPoint;
//                              }
//                            } else {
//                              _barList.elementAt(index).questionState =
//                                  QuestionState.isAnswered;
//                            }
//                          } else {
//                            if (index == 4 || index == 9) {
//                              if (index == pos - 1) {
//                                _barList.elementAt(index).questionState =
//                                    QuestionState.isCurrent;
//                              } else {
//                                _barList.elementAt(index).questionState =
//                                    QuestionState.isCheckPoint;
//                              }
//                            } else {
//                              _barList.elementAt(index).questionState =
//                                  QuestionState.isUnAnswered;
//                            }
//                          }

                          print(barList.elementAt(4).questionState);

                          return LevelBarWidget(
                            amount: barList.elementAt(index).amount,
                            coinValue: barList.elementAt(index).coinValue,
                            questionState:
                                barList.elementAt(index).questionState,
                          );
                        }),
//                  widget.bloc.triviaState.value.questionIndex >= 3
//                      ? Opacity(
//                          opacity: 0.5,
//                          child: Image.asset(
//                            ConstanceData.questionBar91,
//                            alignment: Alignment.center,
//                            height: MediaQuery.of(context).size.height * 0.045,
//                            fit: BoxFit.fill,
//                            width: MediaQuery.of(context).size.width,
//                          ),
//                        )
//                      : Image.asset(
//                          ConstanceData.questionBar91,
//                          alignment: Alignment.center,
//                          height: MediaQuery.of(context).size.height * 0.045,
//                          fit: BoxFit.fill,
//                          width: MediaQuery.of(context).size.width,
//                        ),
//                    widget.bloc.triviaState.value.questionIndex >= 2
//                        ? Image.asset(
//                            ConstanceData.trans100,
//                            alignment: Alignment.center,
//                            height: MediaQuery.of(context).size.height * 0.045,
//                            fit: BoxFit.fill,
//                            width: MediaQuery.of(context).size.width,
//                          )
//                        : Image.asset(
//                            ConstanceData.coin100,
//                            alignment: Alignment.center,
//                            height: MediaQuery.of(context).size.height * 0.045,
//                            fit: BoxFit.fill,
//                            width: MediaQuery.of(context).size.width,
//                          ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Image.asset(
                      ConstanceData.tapToCon,
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height * 0.045,
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                  ],
                ),
              ],
            ),

            // Column(mainAxisAlignment: MainAxisAlignment.end,
            //   children: <Widget>[
            //     Image.asset(
            //             ConstanceData.profileYou,
            //             alignment: Alignment.center,
            //             fit: BoxFit.fitWidth,
            //             width: MediaQuery.of(context).size.width * 1/8,
            //           ),
            //   ],
            // ),
            // Animator(
            //         tween: Tween<double>(begin: 1.1, end: 1.2),
            //         curve: Curves.linear,
            //         cycles: 0,
            //         builder: (anim) => Transform.scale(
            //             scale: anim.value,
            //             child: Stack(
            //               children: <Widget>[
            //                 Positioned(
            //                   top:
            //                       MediaQuery.of(context).size.height * 1 / 1.2,
            //                   left: 10,
            //                   // right: 1,
            //                   // bottom: 30,
            //                   // width: -5,
            //                   child: Image.asset(
            //                     ConstanceData.profileYou,
            //                     fit: BoxFit.fitHeight,
            //                     height: MediaQuery.of(context).size.height * 1 / 11,
            //                     // width: 70,
            //                   ),
            //                 ),
            //               ],
            //             )),
            //       ),
            AnimatedPositioned(
              duration: Duration(seconds: 2),
              left: 0,
              bottom: y,
              child: Column(
                children: <Widget>[
                  Image.asset(
                    ConstanceData.right,
                    fit: BoxFit.fitHeight,
                    width: MediaQuery.of(context).size.width * 1 / 5,
                    height: MediaQuery.of(context).size.height * 1 / 11,
                    // width: 70,
                  ),
                  Image.asset(
                    ConstanceData.profileYou,
                    fit: BoxFit.fitHeight,
                    width: MediaQuery.of(context).size.width * 1 / 5,
                    height: MediaQuery.of(context).size.height * 1 / 11,
                    // width: 70,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomDialog3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          // borderRadius: BorderRadius.circular(Consts.padding),
          ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent3(context),
    );
  }
}

dialogContent3(BuildContext context) {
  return GestureDetector(
    onDoubleTap: () {
      Navigator.of(context).pop();
    },
    child: Stack(
      children: <Widget>[
        Image.asset(
          ConstanceData.leapDialog,
          fit: BoxFit.fitWidth,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => TipScreen()));
          },
          child: Stack(
            children: <Widget>[
              Positioned(
                left: MediaQuery.of(context).size.width * 1 / 2.1,
                // right: 1,
                top: MediaQuery.of(context).size.height * 1 / 2,
                child: Image.asset(
                  ConstanceData.goldLeap,
                  fit: BoxFit.fitWidth,
                  // height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width * 1 / 4,
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 1 / 12,
                // right: 1,
                top: MediaQuery.of(context).size.height * 1 / 2,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => TriviaPage()));
                  },
                  child: Image.asset(
                    ConstanceData.continueDialog,
                    fit: BoxFit.fitWidth,
                    // height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * 1 / 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class BarPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
