import 'package:animator/animator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xman/src/screens/main_page.dart';
import 'package:xman/src/screens/tip_screen.dart';
import '../constance/constance.dart';
import '../constance/routes.dart';
import '../constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constance/global.dart' as globals;
import 'package:shimmer/shimmer.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  bool _visible = false;
  bool _selectedMustKnow = false;
  bool _selectedNewtestament = false;
  bool _selectedOldtestament = false;
  bool _selectedActivist = false;
  bool _selectedLifeStyle = false;
  bool _selectedRealities = false;

  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    animationText();
    secoundAnimation();
  }

  animationText() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _visible = true;
    });
  }
int selectedCategory = 0;
  secoundAnimation() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1))
        .animate(controller);

    controller.forward();
  }

 static Future<bool> saveBooleanValue(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setBool(key, value);
  }
  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Stack(
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

        Animator(
          tween: Tween<double>(begin: 1.3, end: 1.2),
          curve: Curves.decelerate,
          cycles: 0,
          builder: (anim) => Transform.scale(
              scale: anim.value,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -250,
                    left: 2,
                    right: -10,
                    bottom: 30,
                    // width: -5,
                    child: Image.asset(
                      ConstanceData.effectsImage,
                      fit: BoxFit.contain,
                      height: 40,
                      // width: ,
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 10,
                    child: Image.asset(
                      ConstanceData.appIcon,
                      fit: BoxFit.fitHeight,
                      height: 150,
                      width: 300,
                    ),
                  ),
                ],
              )),
        ),
        Positioned(
          top: 300,
          // left: -1,
          // right: -1,
          child: Image.asset(
            ConstanceData.line,
            fit: BoxFit.fitWidth,
            height: 5,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          },
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 278,
                left: 28,
                // right: -1,
                child: Image.asset(
                  ConstanceData.layer4,
                  fit: BoxFit.fitWidth,
                  height: 50,
                ),
              ),
              Positioned(
                top: 278,
                left: 150,
                // right: -1,
                child: Image.asset(
                  ConstanceData.connect,
                  fit: BoxFit.fitWidth,
                  height: 50,
                  width: 100,
                ),
              ),
              Positioned(
                top: 278,
                left: 95,
                // right: -1,
                child: Image.asset(
                  ConstanceData.recon,
                  fit: BoxFit.fitWidth,
                  height: 50,
                  width: 40,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MainPage()));
          },
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 373,
                // left: -1,
                // right: -1,
                child: Image.asset(
                  ConstanceData.line,
                  fit: BoxFit.fitWidth,
                  height: 5,
                ),
              ),
              Positioned(
                top: 350,
                left: 41,
                // right: -1,
                child: Image.asset(
                  ConstanceData.layer4,
                  fit: BoxFit.fitWidth,
                  height: 50,
                  width: 250,
                ),
              ),
              Positioned(
                top: 350,
                left: 150,
                // right: -1,
                child: Image.asset(
                  ConstanceData.connect,
                  fit: BoxFit.fitWidth,
                  height: 50,
                  width: 100,
                ),
              ),
              Positioned(
                top: 350,
                left: 100,
                // right: -1,
                child: Image.asset(
                  ConstanceData.layer13,
                  fit: BoxFit.fitWidth,
                  height: 50,
                  width: 35,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => TipScreen()));
          },
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 440,
                // left: -1,
                // right: -1,
                child: Image.asset(
                  ConstanceData.line,
                  fit: BoxFit.fitWidth,
                  height: 5,
                ),
              ),
              Positioned(
                top: 418,
                left: 41,
                // right: -1,
                child: Image.asset(
                  ConstanceData.layer5,
                  fit: BoxFit.fitWidth,
                  height: 50,
                  width: 250,
                ),
              ),
              Positioned(
                top: 418,
                left: 110,
                // right: -1,
                child: Image.asset(
                  ConstanceData.guest,
                  fit: BoxFit.fitWidth,
                  height: 50,
                  width: 120,
                ),
              ),
            ],
          ),
        ),

        Positioned(
          top: 530,
          left: 40,
          // right: -1,
          child: Text(' C 2020, ROR Bible+. All Rights Reserved'),
        ),

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
