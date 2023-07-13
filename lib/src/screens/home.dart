import 'package:flutter/material.dart';
import 'package:frideos/frideos.dart';
import 'package:xman/src/constance/constance.dart';
import 'package:xman/src/models/appstate.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);

    return Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            ConstanceData.chairSection,
            alignment: Alignment.center,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).size.height * 1 / 3.2,
            left: MediaQuery.of(context).size.width * 1 / 2.8,
            // right: 1,
            child: Image.asset(ConstanceData.profileGuest2,
                alignment: Alignment.center,
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width * 1 / 4)),
        Positioned(
            top: MediaQuery.of(context).size.height * 1 / 1.6,
            left: MediaQuery.of(context).size.width * 1 / 3.2,
            // right: 1,
            child: GestureDetector(
              onTap: appState.startTrivia,
              child: Image.asset(ConstanceData.playButton,
                  alignment: Alignment.center,
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width * 1 / 2.6),
            )),
        Positioned(
            top: MediaQuery.of(context).size.height * 1 / 1.4 - 5,
            left: 20,
            right: 20,
            // right: 1,
            child: GestureDetector(
              // onTap: appState.startTrivia,
              child: Image.asset(ConstanceData.playtoEarn,
                  alignment: Alignment.center,
                  fit: BoxFit.fitWidth,
                  width: MediaQuery.of(context).size.width),
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Image.asset(
              ConstanceData.baselines,
              // fit: BoxFit.fitHeight,
              // height: MediaQuery.of(context).size.height * 1 / 7 ,
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
                    width: 25,
                  ),
                  Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Positioned(
                                child: Column(
                                  children: <Widget>[
                                    Image.asset(
                                      ConstanceData.home1,
                                      fit: BoxFit.fitHeight,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              1 /
                                              12,
                                      // width: MediaQuery.of(context).size.width,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Positioned(
                                child: Image.asset(
                                  ConstanceData.coach1,
                                  fit: BoxFit.fitHeight,
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      12,
                                  // width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Positioned(
                                child: Image.asset(
                                  ConstanceData.box1,
                                  fit: BoxFit.fitHeight,
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      12,
                                  // width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Positioned(
                                child: Image.asset(
                                  ConstanceData.store1,
                                  fit: BoxFit.fitHeight,
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      12,
                                  // width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Stack(
                            children: <Widget>[
                              Positioned(
                                child: Image.asset(
                                  ConstanceData.gear1,
                                  fit: BoxFit.fitHeight,
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      12,
                                  // width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 6)
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
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
                      height: 57,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      ConstanceData.mrWho,
                      // fit: BoxFit.fitWidth,
                      height: 30,
                      // width: 150,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      ConstanceData.coins,
                      fit: BoxFit.fitHeight,
                      height: MediaQuery.of(context).size.height * 1 / 21,
                      // width: 150,
                    ),
                  ],
                ),
              ],
            ),
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
                      width: 135,
                    ),
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
