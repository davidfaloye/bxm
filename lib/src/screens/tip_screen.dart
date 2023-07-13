import 'package:animator/animator.dart';
import 'package:xman/src/controller/user_controller.dart';
import 'package:xman/src/homepage.dart';
import 'package:xman/src/reporsitory/user_service.dart';
import 'package:xman/src/screens/main_page.dart';
import 'package:xman/src/screens/userSelection.dart';
import 'package:xman/src/controller/user_controller.dart';
import '../constance/constance.dart';
import '../constance/routes.dart';
import '../constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import '../constance/global.dart' as globals;
import 'package:shimmer/shimmer.dart';
import 'package:xman/src/utils.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

typedef OnLoadCallback(Function() function);

class TipScreen extends StatefulWidget {
  OnLoadCallback callback;
  TipScreen({this.callback});

  @override
  _TipScreenState createState() => _TipScreenState();
}

class _TipScreenState extends StateMVC<TipScreen>
    with SingleTickerProviderStateMixin {
  bool _visible = false;

  bool _loading = false;
  bool _rorBibleSelected = false;
  bool _newTestamentSelected = false;
  bool _lifeStyleSelected = false;
  bool _oldTestamentSelected = false;
  bool _activistSelected = false;
  bool _newCreationSelected = false;
  int _selectedCategory = 0;
  AnimationController animationController;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    if (widget.callback != null) {
      widget.callback(_login);
    }

    animationText();
    secoundAnimation();

    _rorBibleSelected = false;
    _newTestamentSelected = false;
    _oldTestamentSelected = false;
    _lifeStyleSelected = false;
    _activistSelected = false;
    _newCreationSelected = false;
    _selectedCategory = 0;
    // print(_selectedCategory);

    _loading = true;
//    new Future.delayed(new Duration(seconds: 3), _login);
    // _loading = true;
  }

// var selectedCategory = 2;
  animationText() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _visible = true;
    });
  }

  // void _onLoading() {
  //   setState(() {
  //     _loading = true;
  //     new Future.delayed(new Duration(seconds: 5), _login);
  //   });
  // }

  Future _login() async {
    setState(() {
      _loading = false;
    });
  }

  secoundAnimation() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1))
        .animate(animationController);

    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    //  var _selectedCategory = 2;

    //     void _selectedCategory = _selectedCategory+1 {
    //     setState(() {
    //       _selectedCategory++;
    //     });
    //   }

    //   void _selectedCategory = _selectedCategory-1 {
    //     setState(() {
    //       _selectedCategory--;
    //     });
    //   }

    return Stack(
      children: <Widget>[
        _loading
            ? Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      ConstanceData.authImage,
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                    // top: -300,
                    // left: 2,
                    // right: -10,
                    // bottom: 30,
                    // width: -5,
                    child: Image.asset(
                      ConstanceData.effectsImage,
                      fit: BoxFit.fitWidth,
                      height: MediaQuery.of(context).size.height * 1 / 2,
                      width: MediaQuery.of(context).size.width + 100,
                    ),
                  ),
                  Animator(
                    tween: Tween<double>(begin: 1.3, end: 1.2),
                    curve: Curves.decelerate,
                    cycles: 0,
                    builder: (anim) => Transform.scale(
                        scale: anim.value,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: MediaQuery.of(context).size.height * 1 / 5,
                              // left: 10,
                              child: Image.asset(ConstanceData.appIcon,
                                  fit: BoxFit.fitHeight,
                                  height: MediaQuery.of(context).size.height *
                                          1 /
                                          6 +
                                      30,
                                  width: MediaQuery.of(context).size.width),
                            ),
                          ],
                        )),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 1 / 2,
                    left: 20,
                    right: 20,
                    child: Image.asset(
                      ConstanceData.tips,
                      fit: BoxFit.fitWidth,
                      height: 130,
                      width: 320,
                    ),
                  ),
                  // Positioned(
                  //   top: 325,
                  //   left: 60,
                  //   right: 60,
                  //   child: Image.asset(
                  //     ConstanceData.layer7,
                  //     fit: BoxFit.fitWidth,
                  //     height: 10,
                  //   ),
                  // ),
                  // Positioned(
                  //   top: 324,
                  //   left: 100,
                  //   right: 100,
                  //   child: Image.asset(
                  //     ConstanceData.tip2,
                  //     fit: BoxFit.fitHeight,
                  //     height: 10,
                  //   ),
                  // ),
                  // Positioned(
                  //   top: 340,
                  //   left: 40,
                  //   right: 40,
                  //   child: Text(
                  //       'Expeerts are always sorted from most \n knowledgable to least in the question \n category at hand.'),
                  // ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 1 / 1.2,
                    left: 50,
                    right: 50,
                    // padding: EdgeInsets.all(15.0),
                    child: Image.asset(
                      ConstanceData.strip,
                      fit: BoxFit.fitWidth,
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 1 / 1.2,
                    left: 50,
                    right: 50,
                    // padding: EdgeInsets.all(15.0),
                    child: new LinearPercentIndicator(
                      // width: MediaQuery.of(context).size.width,
                      animation: true,
                      lineHeight: 30.0,
                      animationDuration: 2500,
                      percent: 1,
                      center: Text("Diming the light..."),
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      linearGradient: LinearGradient(
                          colors: [Color(0xff12cfd6), Color(0xff051769)],
                          stops: [0, 1]),
                      backgroundColor: Color(0x360861),
                    ),
                  ),
                ],
              )
            : Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      ConstanceData.background4,
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Animator(
                    tween: Tween<double>(begin: 1.3, end: 1.2),
                    curve: Curves.decelerate,
                    cycles: 0,
                    builder: (anim) => Transform.scale(
                        scale: anim.value,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: MediaQuery.of(context).size.height * 1 / 7.6,
                              left: 30,
                              right: 30,
                              child: Image.asset(
                                ConstanceData.topSection,
                                fit: BoxFit.fitHeight,
                                height:
                                    MediaQuery.of(context).size.height * 1 / 5,
                                // width: 300,
                              ),
                            ),
                          ],
                        )),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 1 / 6,
                    left: 0,
                    right: 0,
                    child: Image.asset(
                      ConstanceData.dash,
                      fit: BoxFit.fitHeight,
                      height: MediaQuery.of(context).size.height * 1 / 1.5 + 1,
                      // width: 320,
                    ),
                  ),
                  // Positioned(
                  //   top: MediaQuery.of(context).size.height * 1/2,
                  //   left: 1,
                  //   right: 1,
                  //   child: Image.asset(
                  //     ConstanceData.tobBar,
                  //     fit: BoxFit.fitHeight,
                  //     height: MediaQuery.of(context).size.height * 1/16 +1,
                  //     // width: 320,
                  //   ),
                  // ),
                  // Positioned(
                  //   top: 120,
                  //   left: 50,
                  //   right: 50,
                  //   child: Image.asset(
                  //     ConstanceData.favoriteCategory,
                  //     fit: BoxFit.fitWidth,
                  //     height: 100,
                  //     width: 250,
                  //   ),
                  // ),
                  // Positioned(
                  //   top: 160,
                  //   left: 50,
                  //   right: 50,
                  //   child: Image.asset(
                  //     ConstanceData.makeSure,
                  //     fit: BoxFit.fitWidth,
                  //     height: 100,
                  //     width: 250,
                  //   ),
                  // ),
                  // Positioned(
                  //   top: 200,
                  //   left: 50,
                  //   right: 50,
                  //   child: Image.asset(
                  //     ConstanceData.justTap,
                  //     fit: BoxFit.fitWidth,
                  //     height: 100,
                  //     width: 250,
                  //   ),
                  // ),
                  // Positioned(
                  //   top: 416,
                  //   left: 50,
                  //   right: 50,
                  //   child: Image.asset(
                  //     ConstanceData.layer10,
                  //     fit: BoxFit.fitWidth,
                  //     height: 100,
                  //     width: 250,
                  //   ),
                  // ),
                  GestureDetector(
                    onTap: () {
                      // UserService().loadScore();
                      if (_selectedCategory >= 3) {
                        Utils.saveStringValue("category", "category");
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserSelectionScreen()));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialog(
                            title: "Success",
                            description:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                            buttonText: "Okay",
                          ),
                        );
                      }
                      // if(_selectedCategory >= 3) {
                      //    CustomDialog();
                      // }else{
                      //   CustomDialog();
                      // }
                    },
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: MediaQuery.of(context).size.height * 1 / 1.2 -
                              17 +
                              1,
                          left: 1,
                          right: 1,
                          child: Image.asset(
                            ConstanceData.okayButton,
                            fit: BoxFit.fitHeight,
                            height:
                                MediaQuery.of(context).size.height * 1 / 20 + 1,
                            // width: 140,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// left side buttons
                  !_rorBibleSelected
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _rorBibleSelected = true;
                              _selectedCategory = _selectedCategory + 1;
                              print(_selectedCategory);
                            });
                          },
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: MediaQuery.of(context).size.height *
                                    1 /
                                    2.3,
                                left: 35,
                                // right: 230,
                                child: Image.asset(
                                  ConstanceData.boxRorBible1,
                                  fit: BoxFit.fitHeight,
                                  // height: 50,
                                  height: MediaQuery.of(context).size.width *
                                          1 /
                                          9 +
                                      3,
                                ),
                              ),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            // _selectedCategory = _selectedCategory-1;
                            setState(() {
                              _rorBibleSelected = false;
                              _selectedCategory = _selectedCategory - 1;
                              print(_selectedCategory);
                            });
                          },
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: MediaQuery.of(context).size.height *
                                        1 /
                                        2.3 -
                                    6,
                                left: 31,
                                // right: 230,
                                child: Image.asset(
                                  ConstanceData.boxRorBible,
                                  fit: BoxFit.fitHeight,
                                  // height: 50,
                                  height: MediaQuery.of(context).size.width *
                                          1 /
                                          7 +
                                      1,
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height *
                                        1 /
                                        2.3 -
                                    6,
                                left: 40,
                                // right: 230,
                                child: Image.asset(
                                  ConstanceData.checker,
                                  fit: BoxFit.fitWidth,
                                  // height: 50,
                                  width: MediaQuery.of(context).size.width *
                                          1 /
                                          2 -
                                      33,
                                ),
                              ),
                            ],
                          ),
                        ),
                  !_newTestamentSelected
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _newTestamentSelected = true;
                              _selectedCategory = _selectedCategory + 1;
                              print(_selectedCategory);
                            });
                          },
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: MediaQuery.of(context).size.height *
                                        1 /
                                        1.9 +
                                    8,
                                left: 35,
                                // right: -1,
                                child: Image.asset(
                                  ConstanceData.boxNewtestament1,
                                  fit: BoxFit.fitHeight,
                                  // height: 41,
                                  height: MediaQuery.of(context).size.width *
                                          1 /
                                          9 +
                                      3,
                                ),
                              ),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = _selectedCategory - 1;
                              _newTestamentSelected = false;
                              print(_selectedCategory);
                            });
                          },
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: MediaQuery.of(context).size.height *
                                        1 /
                                        1.9 +
                                    4,
                                left: 32,
                                // right: -1,
                                child: Image.asset(
                                    ConstanceData.boxNewtestament,
                                    fit: BoxFit.fitWidth,
                                    // height: 50,
                                    height: MediaQuery.of(context).size.width *
                                            1 /
                                            7 +
                                        1),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height *
                                        1 /
                                        1.9 +
                                    2,
                                left: 36,
                                // right: -1,
                                child: Image.asset(
                                  ConstanceData.checker,
                                  fit: BoxFit.fitWidth,
                                  // height: 50,
                                  width: MediaQuery.of(context).size.width *
                                          1 /
                                          2 -
                                      30,
                                ),
                              ),
                            ],
                          ),
                        ),
                  !_lifeStyleSelected
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = _selectedCategory + 1;

                              _lifeStyleSelected = true;
                              print(_selectedCategory);
                            });
                          },
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: MediaQuery.of(context).size.height *
                                        1 /
                                        1.6 +
                                    13,
                                left: 36,
                                // right: -1,
                                child: Image.asset(
                                  ConstanceData.boxLifeStyle1,
                                  fit: BoxFit.fitHeight,
                                  // height: 41,
                                  height: MediaQuery.of(context).size.width *
                                          1 /
                                          9 +
                                      3,
                                ),
                              ),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              _lifeStyleSelected = false;
                              print(_selectedCategory);
                              _selectedCategory = _selectedCategory - 1;
                            });
                          },
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: MediaQuery.of(context).size.height *
                                        1 /
                                        1.6 +
                                    10,
                                left: 31,
                                // right: -1,
                                child: Image.asset(
                                  ConstanceData.boxLifeStyle,
                                  fit: BoxFit.fitWidth,
                                  // height: 50,
                                  height: MediaQuery.of(context).size.width *
                                          1 /
                                          7 +
                                      2,
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height *
                                        1 /
                                        1.6 +
                                    10,
                                left: 36,
                                // right: -1,
                                child: Image.asset(
                                  ConstanceData.checker,
                                  fit: BoxFit.fitWidth,
                                  // height: 50,
                                  width: MediaQuery.of(context).size.width *
                                          1 /
                                          2 -
                                      30,
                                ),
                              ),
                            ],
                          ),
                        ),

                  // right side buttons

                  !_oldTestamentSelected
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _oldTestamentSelected = true;
                              _selectedCategory = _selectedCategory + 1;
                            });
                            print(_selectedCategory);
                          },
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: MediaQuery.of(context).size.height *
                                    1 /
                                    2.3,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 2 +
                                        10,
                                // right: 40,
                                child: Image.asset(
                                  ConstanceData.boxOldTestamenty1,
                                  fit: BoxFit.fitWidth,
                                  // height: 41,
                                  width: MediaQuery.of(context).size.width *
                                          1 /
                                          2 -
                                      40,
                                ),
                              ),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              _oldTestamentSelected = false;
                              _selectedCategory = _selectedCategory - 1;

                              print(_selectedCategory);
                            });
                          },
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: MediaQuery.of(context).size.height *
                                        1 /
                                        2.3 -
                                    5,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 2 +
                                        3,
                                // right: 40,
                                child: Image.asset(
                                  ConstanceData.boxOldTestamenty,
                                  fit: BoxFit.fitWidth,
                                  // height: 41,
                                  width: MediaQuery.of(context).size.width *
                                          1 /
                                          2 -
                                      30,
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height *
                                        1 /
                                        2.3 -
                                    5,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 2 +
                                        10,
                                // right: 40,
                                child: Image.asset(
                                  ConstanceData.checker,
                                  fit: BoxFit.fitWidth,
                                  // height: 41,
                                  width: MediaQuery.of(context).size.width *
                                          1 /
                                          2 -
                                      35,
                                ),
                              ),
                            ],
                          ),
                        ),
                  !_activistSelected
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _activistSelected = true;
                              _selectedCategory = _selectedCategory + 1;

                              print(_selectedCategory);
                            });
                          },
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: MediaQuery.of(context).size.height *
                                        1 /
                                        1.9 +
                                    8,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 2 +
                                        10,
                                // right: -1,
                                child: Image.asset(
                                  ConstanceData.boxActivist1,
                                  fit: BoxFit.fitWidth,
                                  // height: 150,
                                  width: MediaQuery.of(context).size.width *
                                          1 /
                                          2 -
                                      40,
                                ),
                              ),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              _activistSelected = false;
                              _selectedCategory = _selectedCategory - 1;

                              print(_selectedCategory);
                            });
                          },
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: MediaQuery.of(context).size.height *
                                        1 /
                                        1.9 +
                                    8 -
                                    5,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 2 +
                                        5,
                                // right: -1,
                                child: Image.asset(
                                  ConstanceData.boxActivist,
                                  fit: BoxFit.fitWidth,
                                  // height: 150,
                                  width: MediaQuery.of(context).size.width *
                                          1 /
                                          2 -
                                      30,
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height *
                                        1 /
                                        1.9 +
                                    8 -
                                    5,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 2 +
                                        10,
                                // right: -1,
                                child: Image.asset(
                                  ConstanceData.checker,
                                  fit: BoxFit.fitWidth,
                                  // height: 150,
                                  width: MediaQuery.of(context).size.width *
                                          1 /
                                          2 -
                                      35,
                                ),
                              ),
                            ],
                          ),
                        ),
                  !_newCreationSelected
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              _newCreationSelected = true;
                              _selectedCategory = _selectedCategory + 1;

                              print(_selectedCategory);
                            });
                          },
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: MediaQuery.of(context).size.height *
                                        1 /
                                        1.6 +
                                    13,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 2 +
                                        10,
                                // right: -1,
                                child: Image.asset(
                                  ConstanceData.boxNewCreation1,
                                  fit: BoxFit.fitWidth,
                                  // height: 150,
                                  width: MediaQuery.of(context).size.width *
                                          1 /
                                          2 -
                                      40,
                                ),
                              ),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              _newCreationSelected = false;
                              _selectedCategory = _selectedCategory - 1;

                              print(_selectedCategory);
                            });
                          },
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: MediaQuery.of(context).size.height *
                                        1 /
                                        1.6 +
                                    13 -
                                    5,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 2 +
                                        5,
                                // right: -1,
                                child: Image.asset(
                                  ConstanceData.boxNewCreation,
                                  fit: BoxFit.fitWidth,
                                  // height: 150,
                                  width: MediaQuery.of(context).size.width *
                                          1 /
                                          2 -
                                      30,
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height *
                                        1 /
                                        1.6 +
                                    13 -
                                    5,
                                left:
                                    MediaQuery.of(context).size.width * 1 / 2 +
                                        10,
                                // right: -1,
                                child: Image.asset(
                                  ConstanceData.checker,
                                  fit: BoxFit.fitWidth,
                                  // height: 150,
                                  width: MediaQuery.of(context).size.width *
                                          1 /
                                          2 -
                                      35,
                                ),
                              ),
                            ],
                          ),
                        ),

                  // Positioned(
                  //   top: 325,
                  //   left: 40,
                  //   // right: -1,
                  //   child: Image.asset(
                  //     ConstanceData.layer7,
                  //     fit: BoxFit.fitWidth,
                  //     height: 10,
                  //   ),
                  // ),
                  // Positioned(
                  //   top: 324,
                  //   left: 150,
                  //   // right: -1,
                  //   child: Image.asset(
                  //     ConstanceData.tip2,
                  //     fit: BoxFit.fitWidth,
                  //     height: 10,
                  //   ),
                  // ),
                  // Positioned(
                  //   top: 340,
                  //   left: 40,
                  //   // right: -1,
                  //   child: Text(
                  //       'Expeerts are always sorted from most \n knowledgable to least in the question \n category at hand.'),
                  // ),
                  // Positioned(
                  //   top: 500,
                  //   left: 1,
                  //   // padding: EdgeInsets.all(15.0),
                  //   child: Image.asset(
                  //     ConstanceData.layer8,
                  //     fit: BoxFit.fitWidth,
                  //     height: 30,
                  //     width: MediaQuery.of(context).size.width,
                  //   ),
                  // ),
                  // Positioned(
                  //   top: 500,
                  //   left: 1,
                  //   // padding: EdgeInsets.all(15.0),
                  //   child: new LinearPercentIndicator(
                  //     width: MediaQuery.of(context).size.width - 50,
                  //     animation: true,
                  //     lineHeight: 30.0,
                  //     animationDuration: 2500,
                  //     percent: 1,
                  //     center: Text("Diming the light..."),
                  //     linearStrokeCap: LinearStrokeCap.roundAll,
                  //     linearGradient: LinearGradient(
                  //         colors: [Color(0xff12cfd6), Color(0xff051769)],
                  //         stops: [0, 1]),
                  //     backgroundColor: Color(0x360861),
                  //   ),
                  // ),
                ],
              ),
        // ),

        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: <Widget>[
        //     Image.asset(
        //       ConstanceData.layer8,
        //       fit: BoxFit.fitWidth,
        //       height: 30,
        //       width: MediaQuery.of(context).size.width,
        //     ),
        //   ],
        // )
      ],
    );
  }

  bool isClickButton = false;

  goToNextScreen() async {
    setState(() {
      isClickButton = true;
    });
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isClickButton = false;
    });
    Navigator.pushReplacementNamed(
      context,
      Routes.SwipeIntrodution,
    );
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

dialogContent(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).pop();
    },
    child: Stack(
      children: <Widget>[
        Image.asset(
          ConstanceData.layer20,
          fit: BoxFit.fitWidth,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 1 / 2,
          child: Image.asset(
            ConstanceData.iconNav,
            fit: BoxFit.fitWidth,
            height: MediaQuery.of(context).size.height,
            width: 50,
          ),
        )
      ],
    ),
  );
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
