import 'dart:io';

import 'package:http/http.dart';

import '../constance/constance.dart';
import '../constance/routes.dart';
import '../constance/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import '../constance/global.dart' as globals;

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  bool isShowIndicator = false;

  AudioPlayer instance = AudioPlayer();
  AudioCache musicCache;
  String localFilePath;
  var musicPlaying = false;

  void playMusic() async {
    musicCache = new AudioCache(fixedPlayer: instance);

    musicCache = AudioCache(prefix: "audio/", fixedPlayer: instance);
//    instance = await musicCache.loop("welcome.mp3");
  }

  void switchMusic() {
    if (musicPlaying && instance != null) {
      instance.pause();
      musicPlaying = false;
    } else {
      playMusic();
      musicPlaying = true;
    }
  }

  @override
  void initState() {
    super.initState();

    _loadNextScreen();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      playMusic();
    });

    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = Tween<double>(begin: 0, end: 150).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
    animationController.forward();

    animation.addStatusListener((AnimationStatus status) async {
      if (status == AnimationStatus.completed) {
        isShowIndicator = true;
      }
    });
  }

  _loadNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacementNamed(context, Routes.Introdution);
  }

  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
                HexColor(globals.primaryColorString).withOpacity(0.6),
              ],
            ),
          ),
          // child: Container(
          //   height: MediaQuery.of(context).size.height,
          //   width: MediaQuery.of(context).size.width,
          //   child: Image.asset(
          //     ConstanceData.splashBackground,
          //     fit: BoxFit.fitHeight,
          //   ),
          // ),
        ),
        Scaffold(
          backgroundColor: HexColor("#600086"),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: animation.value,
                  height: animation.value,
                  child: Image.asset(ConstanceData.appIcon),
                ),
                SizedBox(
                  height: 150,
                ),
                SizedBox(
                  height: 16,
                  child: isShowIndicator
                      ? CupertinoActivityIndicator(
                          radius: 12,
                        )
                      : SizedBox(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
