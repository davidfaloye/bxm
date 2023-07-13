import 'package:animator/animator.dart';
import 'package:xman/src/homepage.dart';
import 'package:xman/src/screens/main_page.dart';
import 'package:xman/src/screens/tip_screen.dart';
import 'package:xman/src/screens/trivia_page.dart';
import '../constance/constance.dart';
import '../constance/routes.dart';
import '../constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constance/global.dart' as globals;
import 'package:shimmer/shimmer.dart';

class UserSelectionScreen extends StatefulWidget {
  @override
  _UserSelectionScreenState createState() => _UserSelectionScreenState();
}

class _UserSelectionScreenState extends State<UserSelectionScreen>
    with TickerProviderStateMixin {
  bool _visible = false;

  bool _loading = false;

  bool _loadeduser = false;

  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    animationText();
    secoundAnimation();
    controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    // secoundAnimation();

    _loading = true;
    new Future.delayed(new Duration(seconds: 4), _login);

    _loadeduser = true;
    new Future.delayed(new Duration(seconds: 2), _userLoaded);
    controller.forward();
  }

  Future _login() async {
    setState(() {
      _loading = false;
    });
  }

  Future _userLoaded() async {
    setState(() {
      _loadeduser = false;
    });
  }

  animationText() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _visible = true;
    });
  }

  secoundAnimation() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1))
        .animate(controller);

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  ConstanceData.layer361,
                  alignment: Alignment.center,
                  fit: BoxFit.fill,
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 1 / 2.9,
                left: 70,
                // right: -10,
                // bottom: 30,
                // width: -5,
                child: Image.asset(
                  ConstanceData.identity,
                  fit: BoxFit.fitHeight,
                  height: MediaQuery.of(context).size.height * 1 / 8,
                  // width: MediaQuery.of(context).size.width * 1/2 - 140,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 1 / 2,
                left: 93,
                // right: -10,
                // bottom: 30,
                // width: -5,
                child: Image.asset(
                  ConstanceData.you,
                  fit: BoxFit.fitHeight,
                  height: MediaQuery.of(context).size.height * 1 / 50,
                  // width: 30,
                ),
              ),

              Stack(
                children: <Widget>[
                  _loadeduser
                      ? Positioned(
                          top: MediaQuery.of(context).size.height * 1 / 2.8,
                          left: MediaQuery.of(context).size.width * 1 / 2 + 40,
                          // right: -10,
                          // bottom: 30,
                          // width: -5,
                          child: RotationTransition(
                            turns: Tween(begin: 0.0, end: 1.0).animate(controller),
                            child: Image.asset(
                              ConstanceData.refresh,
                              fit: BoxFit.fitHeight,
                              height:
                                  MediaQuery.of(context).size.height * 1 / 10,
                              // width: 70,
                            ),
                          ),
                        )
                      : Positioned(
                          top: MediaQuery.of(context).size.height * 1 / 2.9,
                          left: MediaQuery.of(context).size.width * 1 / 2 + 30,
                          // right: -10,
                          // bottom: 30,
                          // width: -5,
                          child: Image.asset(
                            ConstanceData.profileGuest,
                            fit: BoxFit.fitHeight,
                            height:
                                MediaQuery.of(context).size.height * 1 / 6.6,
                            // width: 75,
                          ),
                        ),
                ],
              ),
              // Animator(
              //   tween: Tween<double>(begin: 1.3, end: 1.2),
              //   curve: Curves.decelerate,
              //   cycles: 0,
              //   builder: (anim) => Transform.scale(
              //       scale: anim.value,
              //       child: Stack(
              //         children: <Widget>[
              //           Positioned(
              //             top: -38,
              //             left: 210,
              //             // right: -10,
              //             // bottom: 30,
              //             // width: -5,
              //             child: Image.asset(
              //               ConstanceData.refresh,
              //               fit: BoxFit.fitWidth,
              //               height: MediaQuery.of(context).size.height,
              //               width: MediaQuery.of(context).size.width - 310,
              //             ),
              //           ),
              //         ],
              //       )),
              // ),

              _loadeduser
                  ? Positioned(
                      top: MediaQuery.of(context).size.height * 1 / 2,
                      left: MediaQuery.of(context).size.width * 1 / 2 + 40,
                      // right: -10,
                      // bottom: 30,
                      // width: -5,
                      child: Image.asset(
                        ConstanceData.sechingForGuest,
                        fit: BoxFit.fitHeight,
                        height: MediaQuery.of(context).size.height * 1 / 30,
                        // width: 100,
                      ),
                    )
                  : Positioned(
                      top: MediaQuery.of(context).size.height * 1 / 2,
                      left: MediaQuery.of(context).size.width * 1 / 2 + 30,
                      // right: -10,
                      // bottom: 30,
                      // width: -5,
                      child: Image.asset(
                        ConstanceData.guest6678,
                        fit: BoxFit.fitHeight,
                        height: MediaQuery.of(context).size.height * 1 / 60,
                        // width: 100,
                      ),
                    ),
              _loadeduser
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Image.asset(
                          ConstanceData.layer38,
                          // fit: BoxFit.fitHeight,
                          // height: MediaQuery.of(context).size.height * 1/60,
                          // width: 100,
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Image.asset(
                          ConstanceData.layer371,
                          // fit: BoxFit.fitHeight,
                          // height: MediaQuery.of(context).size.height * 1/60,
                          // width: 100,
                        ),
                      ],
                    ),

              Positioned(
                top: MediaQuery.of(context).size.height * 1 / 1.6,
                left: 10,
                right: 10,
                // bottom: 30,
                // width: -5,
                child: Image.asset(
                  ConstanceData.beatYourOpponent,
                  fit: BoxFit.fitHeight,
                  height: MediaQuery.of(context).size.height * 1 / 40,
                  // width: MediaQuery.of(context).size.width - 120,
                ),
              ),

              Animator(
                tween: Tween<double>(begin: 1.1, end: 1.2),
                curve: Curves.decelerate,
                cycles: 0,
                builder: (anim) => Transform.scale(
                    scale: anim.value,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top:
                              MediaQuery.of(context).size.height * 1 / 1.5 - 15,
                          left: 10,
                          right: 10,
                          // bottom: 30,
                          // width: -5,
                          child: Image.asset(
                            ConstanceData.vectorSmart,
                            fit: BoxFit.fitHeight,
                            height: MediaQuery.of(context).size.height * 1 / 11,
                            // width: 70,
                          ),
                        ),
                      ],
                    )),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 1 / 1.3 + 20,
                left: 10,
                right: 10,
                // bottom: 30,
                // width: -5,
                child: Image.asset(
                  ConstanceData.greeceVictory,
                  fit: BoxFit.fitHeight,
                  height: MediaQuery.of(context).size.height * 1 / 45,
                  // width: MediaQuery.of(context).size.width - 200,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 1 / 1.2,
                left: 1,
                right: 1,
                // bottom: 30,
                // width: -5,
                child: Image.asset(
                  ConstanceData.line3,
                  fit: BoxFit.fitWidth,
                  height: MediaQuery.of(context).size.height * 1 / 40,
                  // width: MediaQuery.of(context).size.width - 15,
                ),
              ),
            ],
          )
        : HomePage();

    // : GestureDetector(
    //     onTap: () {
    //       Navigator.pushReplacement(
    //           context, MaterialPageRoute(builder: (context) => HomePage()));
    //     },
    //     child: Stack(
    //       children: <Widget>[
    //         Container(
    //           height: MediaQuery.of(context).size.height,
    //           width: MediaQuery.of(context).size.width,
    //           child: Image.asset(
    //             ConstanceData.layer15,
    //             alignment: Alignment.center,
    //             fit: BoxFit.fill,
    //           ),
    //         ),
    //         SizedBox(
    //           height: 50,
    //         ),
    //         Container(
    //           height: MediaQuery.of(context).size.height - 70,
    //           width: MediaQuery.of(context).size.width,
    //           child: Image.asset(
    //             ConstanceData.questionSection,
    //             alignment: Alignment.center,
    //             fit: BoxFit.fill,
    //           ),
    //         ),
    //         Container(
    //           // height: 10,
    //           width: 100,
    //           child: Image.asset(
    //             ConstanceData.tapToCon,
    //             alignment: Alignment.center,
    //             fit: BoxFit.fill,
    //           ),
    //         ),
    //         Positioned(
    //             top: MediaQuery.of(context).size.height - 120,
    //             left: 5,
    //             width: 50,
    //             child: Image.asset(ConstanceData.profileYou,
    //                 alignment: Alignment.center, fit: BoxFit.fill)),
    //         Positioned(
    //             top: MediaQuery.of(context).size.height - 120,
    //             left: MediaQuery.of(context).size.width - 50,
    //             width: 50,
    //             child: Image.asset(ConstanceData.profileYou,
    //                 alignment: Alignment.center, fit: BoxFit.fill)),
    //         Column(
    //           mainAxisAlignment: MainAxisAlignment.end,
    //           children: <Widget>[
    //             Image.asset(ConstanceData.tapToCon,
    //                 alignment: Alignment.center, fit: BoxFit.fill)
    //           ],
    //         )
    //       ],
    //       //       child: Container(
    //       //   height: MediaQuery.of(context).size.height,
    //       //   width: MediaQuery.of(context).size.width,
    //       //   child: Image.asset(
    //       //     ConstanceData.questionSection,
    //       //     alignment: Alignment.center,
    //       //     fit: BoxFit.fill,
    //       //   ),
    //       // ),
    //     ),
    //   );
  }
}
