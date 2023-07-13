import 'dart:io';

import 'package:flutter/material.dart';
import 'package:animator/animator.dart';
// import 'package:food_delivery_app/generated/i18n.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:xman/src/constance/constance.dart';
import 'package:xman/src/controller/user_controller.dart';

// import '../controllers/user_controller.dart';
// import '../elements/BlockButtonWidget.dart';
// import '../helpers/app_config.dart' as config;
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'package:xman/src/reporsitory/user_reporsitory.dart';
import 'package:xman/src/reporsitory/user_service.dart';
import 'package:xman/src/screens/ror_bible_welcome.dart';
import 'package:xman/src/screens/tip_screen.dart';
import '../constance/app_config.dart' as config;

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends StateMVC<IntroductionScreen>
    with SingleTickerProviderStateMixin {
  UserController _con;

  _IntroductionScreenState() : super(UserController()) {
    _con = controller;
  }

  UserService userService = new UserService();
  @override
  void initState() {
    super.initState();
    initPlatformState();
    animationText();
    secoundAnimation();
    print('total score:' + userService.totalcoin.toString());
  }

  AnimationController controller1;
  Animation<Offset> offset;

  bool _visible = false;

  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceData;
    // AndroidDeviceInfo build;
    // build.version.incremental = _con.user.deviceToken;
    try {
      if (Platform.isAndroid) {
        _con.user.deviceType = 'andriod';
        var androidInfo = await DeviceInfoPlugin().androidInfo;
        _con.user.deviceToken = androidInfo.version.incremental;
        // deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        print('device incremental:' + androidInfo.version.incremental);
      } else if (Platform.isIOS) {
        var iosInfo = await DeviceInfoPlugin().iosInfo;
        _con.user.deviceToken = iosInfo.model;
        // deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        _con.user.deviceType = 'ios';
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    // setState(() {
    //   _deviceData = deviceData;
    // });
  }

  secoundAnimation() {
    controller1 =
        AnimationController(vsync: this, duration: Duration(seconds: 1));

    offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1))
        .animate(controller1);

    controller1.forward();
  }

  animationText() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _visible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Stack(
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
                          height:
                              MediaQuery.of(context).size.height * 1 / 6 + 30,
                          width: MediaQuery.of(context).size.width),
                    ),
                  ],
                )),
          ),
//          GestureDetector(
//            onTap: () {
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => WelcomePage()));
//            },
//            child: Stack(
//              children: <Widget>[
//                Positioned(
//                  top: MediaQuery.of(context).size.height * 1 / 2,
//                  // left: 30,
//                  // right: 30,
//                  child: Image.asset(
//                    ConstanceData.rConnectButton,
//                    fit: BoxFit.fitWidth,
//                    // height: 50,
//                    width: MediaQuery.of(context).size.width,
//                  ),
//                ),
//              ],
//            ),
//          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => TipScreen()));
            },
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: MediaQuery.of(context).size.height * 1 / 1.7 + 15,
                  // left: 52,
                  // right: 52,
                  child: Image.asset(
                    ConstanceData.mConnectButton,
                    fit: BoxFit.fitWidth,
                    // height: 50,
                    // width: 250,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TipScreen(
                            callback: _con.questRegister,
                          )));
            },
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: MediaQuery.of(context).size.height * 1 / 1.4,
                  // left: 50,
                  // right: 52,
                  child: Image.asset(
                    ConstanceData.playAsQuestButton,
                    fit: BoxFit.fitWidth,
                    // height: 50,
                    width: MediaQuery.of(context).size.width,

                    // width: 250,
                  ),
                ),
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Image.asset(
                        ConstanceData.policy,
                        fit: BoxFit.fitWidth,
                        height: 50,
                        width: MediaQuery.of(context).size.width - 150,
                      ),
                    ],
                    //
                  ),
                ],
                //
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// import 'dart:io';

// import 'package:animator/animator.dart';
// import 'package:device_info/device_info.dart';
// import 'package:xman/src/controller/user_controller.dart';
// import 'package:xman/src/models/user.dart';
// import 'package:xman/src/screens/main_page.dart';
// import 'package:xman/src/screens/ror_bible_welcome.dart';
// import 'package:xman/src/screens/tip_screen.dart';

// import 'package:xman/src/screens/try.dart';
// import '../constance/constance.dart';
// import '../constance/routes.dart';
// import '../constance/themes.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import '../constance/global.dart' as globals;
// import 'package:shimmer/shimmer.dart';
// import '../reporsitory/user_reporsitory.dart' as repository;

// class IntroductionScreen extends StatefulWidget {
//   @override
//   _IntroductionScreenState createState() => _IntroductionScreenState();
// }

// class _IntroductionScreenState extends State<IntroductionScreen>
//     with SingleTickerProviderStateMixin {
//   bool _visible = false;
//  UserController _con;

// _IntroductionScreenState() : super(UserController()) {
//     _con = controller;
//   }

//   AnimationController controller;
//   Animation<Offset> offset;

//   @override
//   void initState() {
//     super.initState();
//     animationText();
//     secoundAnimation();
//   }

//  User user = new User();

//   animationText() async {
//     await Future.delayed(const Duration(seconds: 1));
//     setState(() {
//       _visible = true;
//     });
//   }

//   void register() async {
//     // user.deviceToken = "aw44ffghh545asd5";

//       repository.questLogin(user).then((value) {
//         if (value != null ) {
//            print("S.current.welcome + value.name");

//            Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => TipScreen()));
//         } print("S.current.wrong_email_or_password");

//       });
//     }

//   secoundAnimation() {
//     controller =
//         AnimationController(vsync: this, duration: Duration(seconds: 1));

//     offset = Tween<Offset>(begin: Offset.zero, end: Offset(0.0, 1))
//         .animate(controller);

//     controller.forward();
//   }

//   Future<void> initPlatformState() async {
//     Map<String, dynamic> deviceData;
//     // AndroidDeviceInfo build;
//     // build.version.incremental = _con.user.deviceToken;
//     try {

//       if (Platform.isAndroid) {
//         _con.user.deviceType = 'andriod';
//         var androidInfo = await DeviceInfoPlugin().androidInfo;
//         _con.user.deviceToken = androidInfo.version.incremental;
//         // deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
//         print('device incremental:'+androidInfo.version.incremental);
//       } else if (Platform.isIOS) {
//         var iosInfo = await DeviceInfoPlugin().iosInfo;
//         _con.user.deviceToken = iosInfo.model;
//         // deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
//         _con.user.deviceType = 'ios';
//       }

//     } on PlatformException {
//       deviceData = <String, dynamic>{
//         'Error:': 'Failed to get platform version.'
//       };
//     }

//     if (!mounted) return;

//     // setState(() {
//     //   _deviceData = deviceData;
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {

//   }
// }
