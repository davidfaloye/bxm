import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:xman/src/constance/constance.dart';
import 'package:xman/src/controller/user_controller.dart';
import 'package:xman/src/models/user.dart';
import 'package:xman/src/reporsitory/user_reporsitory.dart' as reporsitory;
import 'package:xman/src/reporsitory/user_reporsitory.dart';
import 'package:xman/src/reporsitory/user_service.dart';
// import 'package:xman/src/reporsitory/user_reporsitory.dart';
import 'package:http/http.dart' as http;
import 'package:xman/src/screens/ladder_board/ladder_board.dart';

import '../models/appstate.dart';
import '../models/models.dart';
import '../models/trivia_stats.dart';
import '../widgets/summaryanswer_widget.dart';
import '../styles.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({this.stats});

  final TriviaStats stats;

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends StateMVC<SummaryPage> {
  UserController _con;
  TriviaStats stat;
  _SummaryPageState() : super(UserController()) {
    _con = controller;
  }
  User user = new User();
  ValueNotifier<User> currentUser = new ValueNotifier(User());

  int coinScore = 0;
  int diamondScore = 0;

  Map<String, String> mapRewards;

  @override
  void initState() {
    super.initState();
    mapRewards = {
      ConstanceData.greece_chest: '0',
      ConstanceData.leap_chest: widget.stats.leafFaith.toString(),
      ConstanceData.silver_chest: '0',
      ConstanceData.big_coin: widget.stats.coin.toString(),
      ConstanceData.xp: '0'
    };

    mapRewards.removeWhere((key, value) => value == '0');
    _con.userScore();
    loadScore();
  }

  @override
  void setState(fn) {
    super.setState(fn);
  }

  fromScore(Map<String, dynamic> jsonMap) {
    coinScore = jsonMap['coin'];
    diamondScore = jsonMap['diamond'];
    // diamond = jsonMap['diamond'];
    // swap = jsonMap['swap'];
    // f5050 = jsonMap['f5050'];
    // lifeCoach = jsonMap['lifeCoach'];
    // leafFaith = jsonMap['leafFaith'];
    // squadronPack = jsonMap['squadronPack'];
    // faithPack = jsonMap['faithPack'];
    // victoryBox = jsonMap['victoryPack'];

    print('my score :' + coinScore.toString());
    print('my diamond :' + diamondScore.toString());
  }

  int coin1;

  rewardBanner(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 17, color: Colors.black);
//    if (reporsitory.questionLevel != null) {
//      if (reporsitory.questionLevel > 0) {
//        return Text(
//          '\$' + barList.elementAt(reporsitory.questionLevel - 1).amount,
//          style: textStyle,
//        );
//      }
//    }

    return Text(
      '\$${widget.stats.score.toString()}',
      style: textStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final appState = AppStateProvider.of<AppState>(context);
    print(reporsitory.questionLevel);
//    Future<User> loadScore() async {
//      // setState(() {coinScore = 10;});
//      User user = new User();
//      final String url = 'http://xman.rorbible.plus/api/api/total-scores';
//      final response = await http.get(
//        url,
//        headers: {
//          HttpHeaders.contentTypeHeader: "application/json", // or whatever
//          HttpHeaders.authorizationHeader: "Bearer $token",
//        },
//      );
//      if (response.statusCode == 200) {
//        //var totalScores = jsonDecode(response.body);
//        Map<String, dynamic> totalScores = json.decode(response.body);
//        print('===================');
//        print(totalScores['data']);
//        print(totalScores['data']['coin']);
//        setState(() {
//          coinScore = totalScores['data']['coin'];
//        });
//        print('my coin=========' + totalScores['data'].coin.toString());
//        return totalScores['data'];
//      } else {
//        print("error fetching data");
//        print(token);
//      }
//    }

    return Stack(
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              ConstanceData.background5,
              alignment: Alignment.center,
              fit: BoxFit.fill,
            )),
        widget.stats.score == 0
            ? Positioned(
                top: MediaQuery.of(context).size.height * 1 / 5.6,
                left: MediaQuery.of(context).size.width * 1 / 2.7,
                child: Image.asset(
                  ConstanceData.topRibbon2,
                  fit: BoxFit.fitWidth,
                  // height: MediaQuery.of(context).size.height * 1 / 7 ,
                  width: MediaQuery.of(context).size.width * 1 / 3.5,
                ),
              )
            : Positioned(
                top: MediaQuery.of(context).size.height * 1 / 5.6,
                left: MediaQuery.of(context).size.width * 1 / 6,
                child: Image.asset(
                  ConstanceData.topRibbon,
                  fit: BoxFit.fitWidth,
                  // height: MediaQuery.of(context).size.height * 1 / 7 ,
                  width: MediaQuery.of(context).size.width * 1 / 1.5,
                ),
              ),
        widget.stats.score == 0
            ? Positioned(
                top: MediaQuery.of(context).size.height * 1 / 5.5,
                left: MediaQuery.of(context).size.width * 1 / 3.5,
                child: Image.asset(
                  ConstanceData.identities2,
                  fit: BoxFit.fitWidth,
                  // height: MediaQuery.of(context).size.height * 1 / 7 ,
                  width: MediaQuery.of(context).size.width * 1 / 1.8,
                ),
              )
            : Positioned(
                top: MediaQuery.of(context).size.height * 1 / 5.5,
                left: MediaQuery.of(context).size.width * 1 / 6,
                child: Image.asset(
                  ConstanceData.identities,
                  fit: BoxFit.fitWidth,
                  // height: MediaQuery.of(context).size.height * 1 / 7 ,
                  width: MediaQuery.of(context).size.width * 1 / 1.8,
                ),
              ),
        Container(
          height: mediaQuery.size.height * 0.21,
          alignment: Alignment(0, 0.44),
          margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 1 / 2.3,
          ),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned.fill(
                left: 30,
//                top: mediaQuery.size.height * 0.00,
                right: 30,
                child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          ConstanceData.reward_bg,
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
//                    constraints: BoxConstraints(minHeight: 160),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            mapRewards.length,
                            (index) => Flexible(
                                  child: Container(
                                      padding: EdgeInsets.only(
                                          left: 5,
                                          right: 5,
                                          bottom:
                                              mediaQuery.size.height * 0.04),
                                      constraints: BoxConstraints(
                                        maxWidth: 80,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Spacer(
                                            flex: 5,
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: Image.asset(mapRewards.keys
                                                .elementAt(index)),
                                          ),
                                          Spacer(),
                                          Text(mapRewards.values
                                              .elementAt(index)),
                                        ],
                                      )),
                                )))),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(
                      ConstanceData.reward_bg_title,
                    ),
                    fit: BoxFit.fitWidth,
                  )),
                  height: mediaQuery.size.height * 0.045,
                  width: mediaQuery.size.width * 0.55,
                  alignment: Alignment.center,
                  child: rewardBanner(context),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 1 / 1.4,
          left: 30,
          right: 30,
          child: Image.asset(
            ConstanceData.playtoEarn,
            fit: BoxFit.fitWidth,
            // height: MediaQuery.of(context).size.height * 1 / 7 ,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              onTap: () => appState.tabController.value = AppTab.home,
              child: Image.asset(
                ConstanceData.returnHome,
                // fit: BoxFit.fitHeight,
                // height: MediaQuery.of(context).size.height * 1 / 7 ,
                // width: MediaQuery.of(context).size.width,
              ),
            ),
            SizedBox(height: 30)
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      height: 57,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Image.asset(
                      ConstanceData.coins,
                      fit: BoxFit.fitHeight,
                      height: MediaQuery.of(context).size.height * 1 / 20,
                      // width: 150,
                    ),
                    // Positioned(
                    //   top: MediaQuery.of(context).size.height * 1 / 2,
                    //   child: Text(user.coin.toString()),
                    // )
                  ],
                ),
              ],
            ),

            //  Stack(
            //   children: <Widget>[
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: <Widget>[
            //         SizedBox(
            //           height: 56,
            //         ),
            //         SizedBox(
            //           height: 56,
            //         ),
            //         Image.asset(
            //           ConstanceData.coins,
            //           fit: BoxFit.fitWidth,
            //           height: 70,
            //           width: 150,
            //         ),
            //         SizedBox(
            //           width: 15,
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
          ],
        ),
        Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
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
                      width: 145,
                    ),
                    Text(coinScore.toString()),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

// import 'package:flutter/material.dart';

// import 'package:frideos/frideos.dart';
// import 'package:xman/src/blocs/trivia_bloc.dart';
// import 'package:xman/src/constance/constance.dart';

// import '../models/appstate.dart';
// import '../models/models.dart';
// import '../models/trivia_stats.dart';
// import '../widgets/summaryanswer_widget.dart';
// import '../styles.dart';
// import '../models/question.dart';

// class SummaryPage extends StatefulWidget {
//   const SummaryPage({this.stats});

//   final TriviaStats stats;

//   @override

//   _SummaryPageState createState() => _SummaryPageState();
// }

// class _SummaryPageState extends State<SummaryPage> {

//   @override

//   Widget build(BuildContext context) {

//     //  var questionBar;

//     // if (widget.bloc.triviaState.value.questionIndex == 1) {
//     //   questionBar = ConstanceData.q1;
//     // } else if(widget.bloc.triviaState.value.questionIndex == 2){
//     //   questionBar = ConstanceData.q2;
//     // }  else if(widget.bloc.triviaState.value.questionIndex == 3){
//     //   questionBar = ConstanceData.q3;
//     // }else if(widget.bloc.triviaState.value.questionIndex == 4){
//     //   questionBar = ConstanceData.q4;
//     // }else if(widget.bloc.triviaState.value.questionIndex == 5){
//     //   questionBar = ConstanceData.q5;
//     // }else if(widget.bloc.triviaState.value.questionIndex == 6){
//     //   questionBar = ConstanceData.q6;
//     // }else if(widget.bloc.triviaState.value.questionIndex == 7){
//     //   questionBar = ConstanceData.q7;
//     // }else if(widget.bloc.triviaState.value.questionIndex == 8){
//     //   questionBar = ConstanceData.q8;
//     // }else if(widget.bloc.triviaState.value.questionIndex == 9){
//     //   questionBar = ConstanceData.q9;
//     // }else if(widget.bloc.triviaState.value.questionIndex == 10){
//     //   questionBar = ConstanceData.q10;
//     // }else if(widget.bloc.triviaState.value.questionIndex == 11){
//     //   questionBar = ConstanceData.q11;
//     // }else if(widget.bloc.triviaState.value.questionIndex == 12){
//     //   questionBar = ConstanceData.q12;
//     // }else if(widget.bloc.triviaState.value.questionIndex == 13){
//     //   questionBar = ConstanceData.q13;
//     // }else if(widget.bloc.triviaState.value.questionIndex == 14){
//     //   questionBar = ConstanceData.q14;
//     // }

//     final appState = AppStateProvider.of<AppState>(context);
//     return Stack(
//       children: <Widget>[
//         Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: Image.asset(
//               ConstanceData.background5,
//               alignment: Alignment.center,
//               fit: BoxFit.fill,
//             )),

//         Positioned(
//           top: MediaQuery.of(context).size.height * 1/5.6,
//           left: MediaQuery.of(context).size.width * 1/6,
//           child: Image.asset(
//             ConstanceData.topRibbon,
//             fit: BoxFit.fitWidth,
//             // height: MediaQuery.of(context).size.height * 1 / 7 ,
//             width: MediaQuery.of(context).size.width * 1/1.5,
//           ),
//         ),
//         Positioned(
//           top: MediaQuery.of(context).size.height * 1/5.5,
//           left: MediaQuery.of(context).size.width * 1/6,
//           child: Image.asset(
//             ConstanceData.identities,
//             fit: BoxFit.fitWidth,
//             // height: MediaQuery.of(context).size.height * 1 / 7 ,
//             width: MediaQuery.of(context).size.width * 1/1.8,
//           ),
//         ),
//          Positioned(
//           top: MediaQuery.of(context).size.height * 1/2.3,
//           left: 30,
//           right: 30,
//           child: Image.asset(
//             ConstanceData.rewards10500,
//             fit: BoxFit.fitWidth,
//             // height: MediaQuery.of(context).size.height * 1 / 7 ,
//             width: MediaQuery.of(context).size.width,
//           ),
//         ),
//         Positioned(
//           top: MediaQuery.of(context).size.height * 1/1.4,
//           left:30,
//           right: 30,
//           child: Image.asset(
//             ConstanceData.playtoEarn,
//             fit: BoxFit.fitWidth,
//             // height: MediaQuery.of(context).size.height * 1 / 7 ,
//             width: MediaQuery.of(context).size.width,
//           ),
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: <Widget>[
//             GestureDetector(
//               onTap:() => appState.tabController.value = AppTab.home,
//                           child: Image.asset(
//                 ConstanceData.returnHome,
//                 // fit: BoxFit.fitHeight,
//                 // height: MediaQuery.of(context).size.height * 1 / 7 ,
//                 // width: MediaQuery.of(context).size.width,
//               ),
//             ),
//             SizedBox(height: 30)
//           ],
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(
//               height: 30,
//             ),
//             Stack(
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     SizedBox(
//                       width: 20,
//                     ),
//                     SizedBox(
//                       height: 57,
//                     ),
//                     SizedBox(
//                       width: 15,
//                     ),
//                     Image.asset(
//                       ConstanceData.coins,
//                       fit: BoxFit.fitHeight,
//                       height: MediaQuery.of(context).size.height * 1 / 20,
//                       // width: 150,
//                     ),
//                   ],
//                 ),
//               ],
//             ),

//             //  Stack(
//             //   children: <Widget>[
//             //     Row(
//             //       mainAxisAlignment: MainAxisAlignment.start,
//             //       children: <Widget>[
//             //         SizedBox(
//             //           height: 56,
//             //         ),
//             //         SizedBox(
//             //           height: 56,
//             //         ),
//             //         Image.asset(
//             //           ConstanceData.coins,
//             //           fit: BoxFit.fitWidth,
//             //           height: 70,
//             //           width: 150,
//             //         ),
//             //         SizedBox(
//             //           width: 15,
//             //         ),
//             //       ],
//             //     ),
//             //   ],
//             // ),
//           ],
//         ),
//         Column(
//           children: <Widget>[
//             SizedBox(
//               height: 30,
//             ),
//             Stack(
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     SizedBox(
//                       height: 56,
//                     ),
//                     SizedBox(
//                       height: 56,
//                     ),
//                     Image.asset(
//                       ConstanceData.diamond,
//                       // fit: BoxFit.fitHeight,
//                       // height: 140,
//                       width: 145,
//                     ),
//                     SizedBox(
//                       width: 15,
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// //  onPressed: () => appState.tabController.value = AppTab.home,
