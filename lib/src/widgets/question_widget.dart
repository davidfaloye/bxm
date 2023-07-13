import 'package:flutter/material.dart';
import 'package:xman/src/constance/constance.dart';

import '../blocs/trivia_bloc.dart';
import '../models/question.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget({this.bloc, this.question});

  final Question question;
  final TriviaBloc bloc;

  @override
  Widget build(BuildContext context) {
 var questionBar;

    if (bloc.triviaState.value.questionIndex == 1) {
      questionBar = ConstanceData.q1;
    } else if(bloc.triviaState.value.questionIndex == 2){
      questionBar = ConstanceData.q2;
    }  else if(bloc.triviaState.value.questionIndex == 3){
      questionBar = ConstanceData.q3;
    }else if(bloc.triviaState.value.questionIndex == 4){
      questionBar = ConstanceData.q4;
    }else if(bloc.triviaState.value.questionIndex == 5){
      questionBar = ConstanceData.q5;
    }else if(bloc.triviaState.value.questionIndex == 6){
      questionBar = ConstanceData.q6;
    }else if(bloc.triviaState.value.questionIndex == 7){
      questionBar = ConstanceData.q7;
    }else if(bloc.triviaState.value.questionIndex == 8){
      questionBar = ConstanceData.q8;
    }else if(bloc.triviaState.value.questionIndex == 9){
      questionBar = ConstanceData.q9;
    }else if(bloc.triviaState.value.questionIndex == 10){
      questionBar = ConstanceData.q10;
    }else if(bloc.triviaState.value.questionIndex == 11){
      questionBar = ConstanceData.q11;
    }else if(bloc.triviaState.value.questionIndex == 12){
      questionBar = ConstanceData.q12;
    }else if(bloc.triviaState.value.questionIndex == 13){
      questionBar = ConstanceData.q13;
    }else if(bloc.triviaState.value.questionIndex == 14){
      questionBar = ConstanceData.q14;
    }
    return Stack(
      children: <Widget>[
        Positioned(
          top: MediaQuery.of(context).size.width * 1 / 3.2,
          // left: 10,
          // right: -10,
          // bottom: 30,
          // width: -5,
          child: Image.asset(
            questionBar,
            fit: BoxFit.fitHeight,
            height: MediaQuery.of(context).size.height * 1/5 -5,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.width * 1 / 2.8,
          left: MediaQuery.of(context).size.width * 1 / 4.3,
          // right: 5,
          // bottom: 30,
          width: MediaQuery.of(context).size.width * 1/1.5,
          child: Container(
            padding: const EdgeInsets.all(14.0),
            alignment: Alignment.center,
            height: 30 * 4.0,
            child: Text(
              '${question.question}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w500,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 2.0,
                    color: Colors.lightBlueAccent,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
