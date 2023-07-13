import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';
import 'package:xman/src/constance/constance.dart';
import 'package:xman/src/screens/tip_screen.dart';
import 'dart:math' as math;

import '../models/appstate.dart';
import '../models/models.dart';
import '../models/question.dart';
import '../widgets/answers_widget.dart';
import '../widgets/question_widget.dart';

class TriviaPage extends StatefulWidget {
  @override
  _TriviaPageState createState() => _TriviaPageState();
}

String coin;

class _TriviaPageState extends State<TriviaPage> {
  @override
  Widget build(BuildContext context) {
    final bloc = AppStateProvider.of<AppState>(context).triviaBloc;
    bool loading = false;

    return ValueBuilder<TriviaState>(
        streamed: bloc.triviaState,
        builder: (context, snapshotTrivia) {
          return ValueBuilder<Question>(
              streamed: bloc.currentQuestion,
              builder: (context, snapshotQuestion) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  padding: const EdgeInsets.only(top: 22),
                  child: TriviaMain(
                      triviaState: snapshotTrivia.data,
                      question: snapshotQuestion.data),
                );
              });
        });
  }
}

class TriviaMain extends StatefulWidget {
  const TriviaMain({this.triviaState, this.question});

  final TriviaState triviaState;
  final Question question;

  @override
  _TriviaMainState createState() => _TriviaMainState();
}

class _TriviaMainState extends State<TriviaMain> with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${(-duration.inSeconds % 30).toString().padLeft(2, '0')}';

    TriviaState();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    super.initState();
    controller = AnimationController(
        // vsync: this,

        duration: Duration(milliseconds: 30000),
        vsync: this)
      ..addListener(() {
        // Stop the animation if an anwser is chosen
        if (widget.triviaState.isAnswerChosen) {
          controller.stop();
        }
      });
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    // Stop the animation if an anwser is chosen
    // if (widget.triviaState.isAnswerChosen) {
    //   controller.stop();
  }

  @override
  void didUpdateWidget(TriviaMain oldWidget) {
    super.didUpdateWidget(oldWidget);
    // color = Colors.green;

    // If the user click on an anwser the countdown animation
    // will stop.
    if (widget.triviaState.isAnswerChosen) {
      controller.stop();
    }
    // Otherwise, when a new question appears on the screen and
    // the widget rebuilds, then reset and play the countdown bar
    // animation.
    else {
      controller
        ..reset()
        ..forward();
    }
  }

  // @override
  // void dispose() {
  //   controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final bloc = AppStateProvider.of<AppState>(context).triviaBloc;
    ThemeData themeData = Theme.of(context);

    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            ConstanceData.background3,
            alignment: Alignment.center,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.width * 1 / 25,
          left: 1,
          right: 1,
          // bottom: 30,
          // width: MediaQuery.of(context).size.width * 1 / 2,
          height: MediaQuery.of(context).size.width * 1 / 5,
          child: Align(
            alignment: FractionalOffset.center,
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: controller,
                      builder: (BuildContext context, Widget child) {
                        return CustomPaint(
                            painter: TimerPainter(
                          animation: controller,
                          backgroundColor: const Color.fromRGBO(150, 5, 0, 0.5),
                          color: themeData.indicatorColor,
                        ));
                      },
                    ),
                  ),
                  Align(
                    alignment: FractionalOffset.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:
                              ExactAssetImage('assets/layer_19.png'),
                          maxRadius: 35,
                          minRadius: 30,
                          child: AnimatedBuilder(
                              animation: controller,
                              builder: (BuildContext context, Widget child) {
                                return Text(
                                  timerString,
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold),
                                  // style: themeData.textTheme.display4,
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        QuestionWidget(
          bloc: bloc,
          question: widget.question,
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Image.asset(
              ConstanceData.layer17,
              fit: BoxFit.fitHeight,
              height: MediaQuery.of(context).size.height * 1 / 7 + 5,
              // width: MediaQuery.of(context).size.width,
            ),
          ],
        ),
        Positioned(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Positioned(
                                child: Image.asset(
                                  ConstanceData.layer5050,
                                  fit: BoxFit.fitHeight,
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      11,
                                  // width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 47, top: 18),
                                child: Image.asset(
                                  ConstanceData.circle,
                                  fit: BoxFit.fitHeight,
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      13,
                                  // width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 69, top: 35),
                                child: Text("6"),
                              ),
                            ],
                          ),
                          Stack(
                            children: <Widget>[
                              Positioned(
                                child: Image.asset(
                                  ConstanceData.diamondObject,
                                  fit: BoxFit.fitHeight,
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      35,
                                  // width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text("90"))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CustomDialog2(
                                  title: "Success",
                                  description:
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                  buttonText: "Okay",
                                ),
                              );
                            },
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  child: Image.asset(
                                    ConstanceData.audience,
                                    fit: BoxFit.fitHeight,
                                    height: MediaQuery.of(context).size.height *
                                        1 /
                                        10,
                                    // width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 47, top: 18),
                                  child: Image.asset(
                                    ConstanceData.circle,
                                    fit: BoxFit.fitHeight,
                                    height: MediaQuery.of(context).size.height *
                                        1 /
                                        13,
                                    // width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 69, top: 35),
                                  child: Text("3"),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Positioned(
                                child: Image.asset(
                                  ConstanceData.diamondObject,
                                  fit: BoxFit.fitHeight,
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      35,
                                  // width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text("20"))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Positioned(
                                child: Image.asset(
                                  ConstanceData.reloadQuestion,
                                  fit: BoxFit.fitHeight,
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      10,
                                  // width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ],
                          ),
                          Stack(
                            children: <Widget>[
                              Positioned(
                                child: Image.asset(
                                  ConstanceData.diamondObject,
                                  fit: BoxFit.fitHeight,
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      35,
                                  // width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text("60"))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    CustomDialog3(
                                  title: "Success",
                                  description:
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                  buttonText: "Okay",
                                ),
                              );
                            },
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  child: Image.asset(
                                    ConstanceData.lifeCoach,
                                    fit: BoxFit.fitHeight,
                                    height: MediaQuery.of(context).size.height *
                                        1 /
                                        10,
                                    // width: MediaQuery.of(context).size.width,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Stack(
                            children: <Widget>[
                              Positioned(
                                child: Image.asset(
                                  ConstanceData.diamondObject1,
                                  fit: BoxFit.fitHeight,
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      35,
                                  // width: MediaQuery.of(context).size.width,
                                ),
                              ),
                              // Padding(padding: EdgeInsets.only(left:30),child: Text("90"))
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              // Stack(children: <Widget>[
              //   Positioned(bottom: MediaQuery.of(context).size.height *1/30,
              //                                 child: Image.asset(
              //             ConstanceData.diamondObject,
              //             fit: BoxFit.fitHeight,
              //             height: 1 ,
              //             // width: MediaQuery.of(context).size.width,
              //           ),
              //         ),
              // ],)
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      height: 56,
                    ),
                    SizedBox(
                      height: 56,
                    ),
                    Image.asset(
                      ConstanceData.diamond,
                      // fit: BoxFit.fitHeight,
                      // height: 140,
                      width: MediaQuery.of(context).size.width * 1 / 2.9,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 56,
                    ),
                    SizedBox(
                      height: 56,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialog(
                            title: "Success",
                            description:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                            buttonText: "Okay",
                          ),
                        );
                      },
                      child: Image.asset(
                        ConstanceData.homeButton,
                        // fit: BoxFit.fitHeight,
                        // height: 140,
                        width: 55,
                      ),
                    ),
                    SizedBox(
                      width: 35,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
        // Positioned( height: MediaQuery.of(context).size.height * 1/1,
        //     child: Image.asset(
        //   ConstanceData.answerButton,
        //   width: MediaQuery.of(context).size.width,
        // )),
        GestureDetector(
          child: Stack(
            children: <Widget>[
              Positioned(
                top: MediaQuery.of(context).size.height * 1 / 2.5,
                bottom: 0,
                left: 0,
                right: 0,
                child: ValueBuilder<AnswerAnimation>(
                    streamed: bloc.answersAnimation,
                    builder: (context, snapshot) {
                      return AnswersWidget(
                        bloc: bloc,
                        question: widget.question,
                        answerAnimation: snapshot.data,
                        isTriviaEnd: widget.triviaState.isTriviaEnd,
                      );
                    }),
              ),
            ],
          ),
        ),

        // Container(
        //   padding: const EdgeInsets.all(8),
        //   child: QuestionWidget(
        //     bloc: bloc,
        //     question: question,
        //   ),
        // ),
      ],
    );
  }
}

class TimerPainter extends CustomPainter {
  TimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = Colors.purple;
    double progress = (1 - animation.value) * 2 * math.pi;
    canvas.drawArc(
      Offset.zero & size,
      math.pi * 5.5,
      -progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(TimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
}

class CustomDialog2 extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;

  CustomDialog2({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent2(context),
    );
  }
}

class CustomDialog3 extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;

  CustomDialog3({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent3(context),
    );
  }
}

dialogContent(BuildContext context) {
  return GestureDetector(
    onDoubleTap: () {
      Navigator.of(context).pop();
    },
    child: Stack(
      children: <Widget>[
        Image.asset(
          ConstanceData.goHome,
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
                left: MediaQuery.of(context).size.width * 1 / 9,
                // right: 1,
                top: MediaQuery.of(context).size.height * 1 / 2,
                child: Image.asset(
                  ConstanceData.yesButton,
                  fit: BoxFit.fitHeight,
                  height: MediaQuery.of(context).size.height * 1 / 20,
                  // width: 100,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Stack(
            children: <Widget>[
              Positioned(
                // left:1,
                right: MediaQuery.of(context).size.width * 1 / 9,
                top: MediaQuery.of(context).size.height * 1 / 2,
                child: Image.asset(
                  ConstanceData.noButton,
                  fit: BoxFit.fitHeight,
                  height: MediaQuery.of(context).size.height * 1 / 20,
                  // width: 100,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

dialogContent2(BuildContext context) {
  return GestureDetector(
    onDoubleTap: () {
      Navigator.of(context).pop();
    },
    child: Stack(
      children: <Widget>[
        Image.asset(
          ConstanceData.audienceSec1,
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
                left: MediaQuery.of(context).size.width * 1 / 9,
                // right: 1,
                top: MediaQuery.of(context).size.height * 1 / 3,
                child: Image.asset(
                  ConstanceData.pipeA,
                  // fit: BoxFit.fitHeight,
                  height: 130,
                  width: 30,
                  // width: 100,
                ),
              ),
              Positioned(
                  left: MediaQuery.of(context).size.width * 1 / 9,
                  // right: 1,
                  top: MediaQuery.of(context).size.height * 1 / 1.7 - 3,
                  child: Text("100%")),
              Positioned(
                left: MediaQuery.of(context).size.width * 1 / 3.7,
                // right: 1,
                top: MediaQuery.of(context).size.height * 1 / 3,
                child: Image.asset(
                  ConstanceData.pipeB,
                  // fit: BoxFit.fitHeight,
                  height: 130,
                  width: 30,
                  // width: 100,
                ),
              ),
              Positioned(
                  left: MediaQuery.of(context).size.width * 1 / 3.7,
                  // right: 1,
                  top: MediaQuery.of(context).size.height * 1 / 1.7 - 3,
                  child: Text("100%")),
              Positioned(
                left: MediaQuery.of(context).size.width * 1 / 2.3,
                // right: 1,
                top: MediaQuery.of(context).size.height * 1 / 3,
                child: Image.asset(
                  ConstanceData.pipeC,
                  // fit: BoxFit.fitHeight,
                  height: 130,
                  width: 30,
                  // width: 100,
                ),
              ),
              Positioned(
                  left: MediaQuery.of(context).size.width * 1 / 2.3,
                  // right: 1,
                  top: MediaQuery.of(context).size.height * 1 / 1.7 - 3,
                  child: Text("100%")),
              Positioned(
                left: MediaQuery.of(context).size.width * 1 / 1.7,
                // right: 1,
                top: MediaQuery.of(context).size.height * 1 / 3,
                child: Image.asset(
                  ConstanceData.pipeD,
                  // fit: BoxFit.fitHeight,
                  height: 130,
                  width: 30,
                  // width: 100,
                ),
              ),
              Positioned(
                  left: MediaQuery.of(context).size.width * 1 / 1.7,
                  // right: 1,
                  top: MediaQuery.of(context).size.height * 1 / 1.7 - 3,
                  child: Text("100%")),
            ],
          ),
        ),
      ],
    ),
  );
}

dialogContent3(BuildContext context) {
  return GestureDetector(
    onDoubleTap: () {
      Navigator.of(context).pop();
    },
    child: Stack(
      children: <Widget>[
        Image.asset(
          ConstanceData.philipSec,
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
                  left: MediaQuery.of(context).size.width * 1 / 2.4 + 2,
                  // right: 1,
                  top: MediaQuery.of(context).size.height * 1 / 2.5 + 2,
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ],
    ),
  );
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

// Container(
//   padding: const EdgeInsets.symmetric(horizontal: 22),
//   decoration: BoxDecoration(
//     color: const Color(0xff283593),
//     borderRadius: const BorderRadius.only(
//         bottomLeft: Radius.circular(25),
//         bottomRight: Radius.circular(25)),
//     boxShadow: [
//       BoxShadow(color: Colors.blue, blurRadius: 3.0, spreadRadius: 1.5),
//     ],
//   ),
//       child: Column(
//         children: <Widget>[
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Text(
//                   'SCORE: ${bloc.stats.score}',
//                   style: scoreHeaderStyle,
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: <Widget>[
//               Text(
//                 'Corrects: ${bloc.stats.corrects.length}',
//                 style: questionsHeaderStyle,
//               ),
//               Text(
//                 'Wrongs: ${bloc.stats.wrongs.length}',
//                 style: questionsHeaderStyle,
//               ),
//               Text(
//                 'Not answered: ${bloc.stats.noAnswered.length}',
//                 style: questionsHeaderStyle,
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 12,
//           )
//         ],
//       ),
//     ),
//     Container(
//       height: 12,
//     ),
//     Container(
//       padding: const EdgeInsets.all(8),
//       child: QuestionWidget(
//         bloc: bloc,
//         question: question,
//       ),
//     ),
//     Container(
//       height: 32,
//     ),
//     Expanded(
//       child: ValueBuilder<AnswerAnimation>(
//           streamed: bloc.answersAnimation,
//           builder: (context, snapshot) {
//             return Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 22),
//                 child: AnswersWidget(
//                   bloc: bloc,
//                   question: question,
//                   answerAnimation: snapshot.data,
//                   isTriviaEnd: triviaState.isTriviaEnd,
//                 ));
//           }),
//     ),
//     ValueBuilder<int>(
//         streamed: bloc.currentTime,
//         builder: (context, snapshot) {
//           return Column(
//             children: <Widget>[
//               Container(
//                 height: 24,
//                 padding: const EdgeInsets.all(22),
//                 child: Text(
//                   'Time left: ${((bloc.countdown - snapshot.data) / 1000)}',
//                   style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 12,
//                       fontStyle: FontStyle.italic),
//                 ),
//               ),
//             ],
//           );
//         }),
//     Container(
//       height: 18,
//     ),
//     CountdownWidget(
//       width: MediaQuery.of(context).size.width,
//       duration: bloc.countdown,
//       triviaState: triviaState,
//     ),
//   ],
// );
// }
// }
