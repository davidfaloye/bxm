import 'dart:async';

import 'package:flutter/material.dart';
import 'package:xman/src/constance/constance.dart';
import 'package:xman/src/screens/ladder_board/ladder_board.dart';

import '../styles.dart';
import '../blocs/trivia_bloc.dart';
import '../models/models.dart';
import '../models/question.dart';

const questionLeadings = ['A', 'B', 'C', 'D'];
const boxHeight = 65.0;
// bool selected;

class AnswersWidget extends StatefulWidget {
  const AnswersWidget(
      {this.bloc, this.question, this.answerAnimation, this.isTriviaEnd});

  final Question question;
  final TriviaBloc bloc;
  final AnswerAnimation answerAnimation;
  final bool isTriviaEnd;

  @override
  _AnswersWidgetState createState() => _AnswersWidgetState();
}

class _AnswersWidgetState extends State<AnswersWidget>
    with TickerProviderStateMixin {
  bool isCorrect;
  var newColor = Image.asset(ConstanceData.answerButton, fit: BoxFit.fitHeight);

  final Map<int, Animation<double>> animations = {};
  AnimationController controller;
  // Animation colorAnimation;
  // Color color;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    // selected = false;

    widget.question.selected = false;

    // setState(() {
    //   newColor = Image.asset(ConstanceData.answerButton,
    //       width: MediaQuery.of(context).size.width, fit: BoxFit.fitHeight);
    // });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initAnimation();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _checkCorrectAnswer() {
    // Check if the answer chosen is correct or false
    isCorrect = widget.question.correctAnswerIndex ==
            widget.answerAnimation.chosenAnswerIndex
        ? true
        : false;

    print(widget.question.correctAnswerIndex);
  }

  void buttonType() async {
    _checkCorrectAnswer();

    print(isCorrect);
    print(widget.question.correctAnswerIndex);
    if (isCorrect) {
      setState(() {
        newColor = Image.asset(ConstanceData.correctAnswer,
            width: MediaQuery.of(context).size.width, fit: BoxFit.fitHeight);
      });
      _startAnimation();
    } else if (!isCorrect) {
      setState(() {
        newColor = Image.asset(ConstanceData.wrongAnswer,
            width: MediaQuery.of(context).size.width, fit: BoxFit.fitHeight);

        //  Timer(Duration(seconds: 3),
        //             () => setState(() => widget.question.selected  = false));
        //             newColor = Image.asset(ConstanceData.answerButton, fit: BoxFit.fitHeight);
      });
      _startAnimation();
    } else if (widget.bloc.selected = false) {
      setState(() {
        newColor = Image.asset(ConstanceData.answerButton,
            width: MediaQuery.of(context).size.width, fit: BoxFit.fitHeight);
      });
    }
  }

  void waiting() {
    setState(() {
      newColor = Image.asset(ConstanceData.answerButton,
          width: MediaQuery.of(context).size.width, fit: BoxFit.fitHeight);
    });
  }

  Future _initAnimation() async {
    for (int i = 0; i < 4; i++) {
      animations[i] = Tween<double>(begin: boxHeight * i, end: boxHeight * i)
          .animate(controller);
    }

    // colorAnimation = ColorTween(
    //   begin: answerBoxColor,
    //   end: answerBoxColor,
    // ).animate(controller);
  }

  Future _startAnimation() async {
    final index = widget.answerAnimation.chosenAnswerIndex;

    // for (int i = 0; i < 4; i++) {
    //   // Set the animations for the answer but the one chosen
    //   if (i != index) {
    //     // From the answer original position to the chosen one
    //     animations[i] =
    //         Tween<double>(begin: boxHeight * i, end: boxHeight * index)
    //             .animate(controller)
    //               ..addListener(() {
    //                 setState(() {});
    //                 if (controller.status == AnimationStatus.completed) {
    //                   widget.bloc.onChosenAnwserAnimationEnd();
    //                   controller.reset();
    //                 }
    //               });
    //   }

    // }

    await Future.delayed(const Duration(seconds: 3));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LadderBoard(
                  bloc: widget.bloc,
                  question: widget.question,
                )));

    setState(() {
      newColor = Image.asset(ConstanceData.answerButton, fit: BoxFit.fitHeight);
    });

    widget.bloc.onChosenAnwserAnimationEnd();
    controller.reset();

    // colorAnimation = ColorTween(
    //   begin: answerBoxColor,
    //   end: newColor,
    // ).animate(controller);

    // colorAnimation = newColor;

    // await controller.forward();
  }

  @override
  void didUpdateWidget(AnswersWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Future _playAnimation(String answer) async {
    widget.bloc.onChosenAnswer(answer);

//  await Future.delayed(const Duration(seconds: 3));
//      Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => LadderBoard(bloc: widget.bloc, question: widget.question,)));

    // await _startAnimation();
  }

  bool _condition = true;

  @override
  Widget build(BuildContext context) {
    final widgets = widget.question.answers.map((answer) {
      final index = widget.question.answers.indexOf(answer);

      return Positioned(
        // width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height * 1/2,
        // If the answer isn't the chosen one to the top parameter
        // is passed the value of the animation, while for the chosen
        // answer it is passed a fixed position.
        top: (index != widget.answerAnimation.chosenAnswerIndex
            ? animations[index].value
            : boxHeight * index),
        left: 1,
        right: 1,
        child: GestureDetector(
          onTap: _condition
              ? () {
                  setState(() {
                    widget.question.selected = true;
                    //  Timer(Duration(seconds: 3),
                    //     () => setState(() => widget.question.selected  = false));
                    //     newColor = Image.asset(ConstanceData.answerButton, fit: BoxFit.fitHeight);
                  });

                  if (!widget.isTriviaEnd) {
                    _playAnimation(answer);
                  }

                  setState(() {
                    _condition = false;
                    Timer(Duration(seconds: 3),
                        () => setState(() => _condition = true));
                  });

                  buttonType();
                  // waiting();
                }
              : null,
          child: Stack(
            children: <Widget>[
              Positioned(
                  // height: MediaQuery.of(context).size.height,
                  // height: MediaQuery.of(context).size.height * 1 / 1,
                  child: (index == widget.answerAnimation.chosenAnswerIndex)
                      ? newColor
                      : Image.asset(
                          ConstanceData.answerButton,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fitHeight,
                        )),
              Positioned(
                // width: MediaQuery.of(context).size.width * 1/2,
                left: 70,
                right: MediaQuery.of(context).size.width * 1 / 3 - 5,
                child: ListTile(
                  leading: CircleAvatar(
                      radius: questionCircleAvatarRadius,
                      backgroundColor: questionCircleAvatarBackground,
                      child: Stack(
                        children: <Widget>[
                          Text(
                            questionLeadings[index],
                            style: answersLeadingStyle,
                          ),
                        ],
                      )),
                  title: Stack(
                    children: <Widget>[
                      Center(
                        child: Text(
                          answer,
                          style: answersStyle,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
            //
          ),
        ),

        //  GestureDetector(
        //     child: FadeInWidget(
        //       duration: 750,
        //       child: Container(
        //         decoration: BoxDecoration(
        //             color: (index == widget.answerAnimation.chosenAnswerIndex)
        //                 ? colorAnimation.value
        //                 : const Color(0xff283593),
        //             borderRadius: const BorderRadius.only(
        //               topLeft: Radius.circular(35),
        //               topRight: Radius.circular(15),
        //               bottomLeft: Radius.circular(35),
        //               bottomRight: Radius.circular(15),
        //             ),
        //             boxShadow: [
        //               BoxShadow(
        //                   color:
        //                       (colorAnimation.status == AnimationStatus.forward)
        //                           ? colorAnimation.value
        //                           : Colors.blue[500],
        //                   blurRadius:
        //                       (colorAnimation.status == AnimationStatus.forward)
        //                           ? 19.0
        //                           : 3.0,
        //                   spreadRadius:
        //                       (colorAnimation.status == AnimationStatus.forward)
        //                           ? 2.5
        //                           : 1.5),
        //             ]),
        //         child: ListTile(
        //           leading: CircleAvatar(
        //               radius: questionCircleAvatarRadius,
        //               backgroundColor: questionCircleAvatarBackground,
        //               child: Text(
        //                 questionLeadings[index],
        //                 style: answersLeadingStyle,
        //               )),
        //           title: Text(answer, style: answersStyle),
        //         ),
        //       ),
        //     ),
        //     onTap: () {
        //       if (!widget.isTriviaEnd) {
        //         _playAnimation(answer);
        //       }
        //     }),
      );
    }).toList();

    // Swap the last item with the chosen anwser so that it can
    // be shown as the last on the stack.
    final last = widgets.last;
    final chosen = widgets[widget.answerAnimation.chosenAnswerIndex];
    final chosenIndex = widgets.indexOf(chosen);

    widgets.last = chosen;
    widgets[chosenIndex] = last;

    return Container(
      child: Stack(
        children: widgets,
      ),
    );
  }
}
