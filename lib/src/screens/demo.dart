//import 'package:firebase_admob/firebase_admob.dart';
//import 'package:flutter/material.dart';
//import 'package:xman/src/screens/ror_signup.dart';
//
//class Demo extends StatefulWidget {
//  Demo({Key key}) : super(key: key);
//
//  @override
//  _DemoState createState() => _DemoState();
//}
//
//const testDevices = "Your Device ID";
//
//class _DemoState extends State<Demo> {
//  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//    testDevices: testDevices != null ? <String>['testDevices'] : null,
//    keywords: <String>['Book', 'Game'],
//    nonPersonalizedAds: true,
//  );
//
//  int _coins = 50;
//  RewardedVideoAd videoAd = RewardedVideoAd.instance;
//  @override
//  void initState() {
//    super.initState();
//    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
//
//    videoAd.listener =
//        (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
//      print("REWARDED VIDEO AD $event");
//      if (event == RewardedVideoAdEvent.rewarded) {
//        setState(() {
//          _coins += rewardAmount;
//           Navigator.push(
//            context, MaterialPageRoute(builder: (context) => SignUpPage()));
//        });
//      }
//    };
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: Column(
//        mainAxisSize: MainAxisSize.min,
//        children: <Widget>[
//          Text('LOAD REWARDED VIDEO AD'),
//          RaisedButton(
//            child: Text("LOAD REWARDED AD"),
//            onPressed: () {
//              videoAd.load(
//                  adUnitId: RewardedVideoAd.testAdUnitId,
//                  targetingInfo: targetingInfo);
//            },
//          ),
//          RaisedButton(
//            child: Text("SHOW REWARDED VIDEOAD"),
//            onPressed: () {
//              videoAd.show();
//            },
//          ),
//          Text("YOU HAVE $_coins coins"),
//        ],
//      ),
//    );
//  }
//}
