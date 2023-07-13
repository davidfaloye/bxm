//import 'package:flutter/material.dart';
//import 'package:firebase_admob/firebase_admob.dart';
//
//FirebaseAdmobDemoState pageState;
//
//class FirebaseAdmobDemo extends StatefulWidget {
//  @override
//  State<StatefulWidget> createState() {
//    pageState = FirebaseAdmobDemoState();
//    return pageState;
//  }
//}
//
//class FirebaseAdmobDemoState extends State<FirebaseAdmobDemo> {
//  FirebaseAdmobManager fMan = FirebaseAdmobManager();
//  bool loadInterstitialAd = false;
//  bool loadRewardedVideoAd = false;
//  int rewardCount = 0;
//
//  @override
//  void initState() {
//    super.initState();
//    fMan.init(
//        interstitialAdListener: interstitialAdListener,
//        rewardedVideoListner: rewardedVideoListner);
//  }
//
//  void interstitialAdListener(MobileAdEvent event) {
//    print("************ event: $event");
//    switch (event) {
//      case MobileAdEvent.loaded:
//        setState(() {
//          loadInterstitialAd = true;
//        });
//        break;
//      case MobileAdEvent.failedToLoad:
//        break;
//      case MobileAdEvent.clicked:
//        break;
//      case MobileAdEvent.impression:
//        break;
//      case MobileAdEvent.opened:
//        setState(() {
//          loadInterstitialAd = false;
//        });
//        break;
//      case MobileAdEvent.leftApplication:
//        break;
//      case MobileAdEvent.closed:
//        break;
//    }
//  }
//
//  void rewardedVideoListner(RewardedVideoAdEvent event,
//      {String rewardType, int rewardAmount}) {
//    print("************ event: $event");
//    switch (event) {
//      case RewardedVideoAdEvent.loaded:
//        setState(() {
//          loadRewardedVideoAd = true;
//        });
//        break;
//      case RewardedVideoAdEvent.failedToLoad:
//        break;
//      case RewardedVideoAdEvent.opened:
//        setState(() {
//          loadRewardedVideoAd = false;
//        });
//        break;
//      case RewardedVideoAdEvent.leftApplication:
//        break;
//      case RewardedVideoAdEvent.closed:
//        break;
//      case RewardedVideoAdEvent.rewarded:
//        setState(() {
//          rewardCount += rewardAmount;
//        });
//        break;
//      case RewardedVideoAdEvent.started:
//        break;
//      case RewardedVideoAdEvent.completed:
//        break;
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      home: Scaffold(
//        appBar: AppBar(
//          title: const Text('AdMob Plugin example app'),
//        ),
//        body: ListView(
//          children: <Widget>[
//            _customTitle("Bottom Banner Advertisement"),
//            Row(
//              children: <Widget>[
//                _customButton("Show", onPressed: () {
//                  fMan.showBannerAd();
//                }),
//                _customButton("Move to\nOther Page", onPressed: () {
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => TestPage()));
//                }),
//                _customButton("Remove", onPressed: () {
//                  fMan.removeBannerAd();
//                })
//              ],
//            ),
//            _customTitle("Interstitial Advertisement"),
//            Row(
//              children: <Widget>[
//                _customButton(("Load"), onPressed: () {
//                  fMan.loadInterstitialAd();
//                }),
//                _customButton("Show",
//                    onPressed: (loadInterstitialAd == true)
//                        ? () {
//                            fMan.showInterstitialAd();
//                          }
//                        : null),
//              ],
//            ),
//            _customTitle("Rewarded Video Advertisement"),
//            Row(
//              children: <Widget>[
//                _customButton(("Load"), onPressed: () {
//                  fMan.loadRewardedVideoAd();
//                }),
//                _customButton("Show",
//                    onPressed: (loadRewardedVideoAd == true)
//                        ? () {
//                            fMan.showRewardedVideoAd();
//                          }
//                        : null),
//              ],
//            ),
//            Container(
//              alignment: Alignment(0, 0),
//              padding: const EdgeInsets.symmetric(vertical: 10),
//              child: Text("You have $rewardCount coins."),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//  _customTitle(String title) {
//    return Container(
//      margin: const EdgeInsets.symmetric(horizontal: 10),
//      padding: const EdgeInsets.only(top: 20),
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.start,
//        children: <Widget>[
//          Text(
//            title,
//            style: TextStyle(
//                fontSize: 16,
//                fontWeight: FontWeight.bold,
//                color: Colors.blueGrey),
//          ),
//          Divider(
//            color: Colors.grey,
//            height: 1,
//          )
//        ],
//      ),
//    );
//  }
//
//  _customButton(String text, {Null Function() onPressed}) {
//    return Expanded(
//      child: Container(
//        margin: const EdgeInsets.symmetric(horizontal: 5),
//        child: RaisedButton(
//          padding: const EdgeInsets.symmetric(horizontal: 10),
//          color: Colors.blueAccent,
//          textColor: Colors.white,
//          child: Text(text),
//          onPressed: onPressed,
//        ),
//      ),
//    );
//  }
//}
//
//class FirebaseAdmobManager {
//  bool _isInit = false;
//  BannerAd _bottomBannerAd;
//  InterstitialAd interstitialAd;
//
//  //Modify the following for the actual Admob advertisement.
//  String appID = FirebaseAdMob.testAppId;
//  String bannerID = BannerAd.testAdUnitId;
//  String interstitialID = InterstitialAd.testAdUnitId;
//  String rewardedVideoAdID = RewardedVideoAd.testAdUnitId;
//
//  Function(MobileAdEvent) _interstitialAdListener;
//
//  init({
//    MobileAdListener interstitialAdListener = null,
//    RewardedVideoAdListener rewardedVideoListner = null,
//  }) async {
//    _isInit = await FirebaseAdMob.instance.initialize(appId: appID);
//
//    _bottomBannerAd = createBannerAd();
//
//    _interstitialAdListener = interstitialAdListener;
//    RewardedVideoAd.instance.listener = rewardedVideoListner;
//  }
//
//  dispose() {
//    _bottomBannerAd.dispose();
//    interstitialAd.dispose();
//    _isInit = false;
//  }
//
//  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
//    //testDevices: testDevice != null ? <String>[testDevice] : null,
//    keywords: <String>['foo', 'bar'],
//    contentUrl: 'http://foo.com/bar.html',
//    childDirected: true,
//    nonPersonalizedAds: true,
//  );
//
//  /*** Banner AD ***/
//  BannerAd createBannerAd() {
//    return BannerAd(
//      adUnitId: BannerAd.testAdUnitId,
//      size: AdSize.banner,
//      //targetingInfo: targetingInfo,
//      listener: (MobileAdEvent event) {
//        print("BannerAd event $event");
//      },
//    );
//  }
//
//  showBannerAd() {
//    _bottomBannerAd ??= createBannerAd();
//    _bottomBannerAd
//      ..load()
//      ..show();
//  }
//
//  removeBannerAd() {
//    _bottomBannerAd?.dispose();
//    _bottomBannerAd = null;
//  }
//
//  /*** Interstitial AD ***/
//  InterstitialAd createInterstitialAd() {
//    return InterstitialAd(
//      adUnitId: InterstitialAd.testAdUnitId,
//      listener: _interstitialAdListener,
//    );
//  }
//
//  loadInterstitialAd() async {
//    interstitialAd?.dispose();
//    interstitialAd = createInterstitialAd()..load();
//  }
//
//  showInterstitialAd() {
//    interstitialAd.show();
//  }
//
//  /*** RewardedVideo AD ***/
//  loadRewardedVideoAd() {
//    RewardedVideoAd.instance
//        .load(adUnitId: rewardedVideoAdID, targetingInfo: targetingInfo);
//  }
//
//  showRewardedVideoAd() {
//    RewardedVideoAd.instance.show();
//  }
//}
//
//class TestPage extends StatefulWidget {
//  @override
//  TestPageState createState() => TestPageState();
//}
//
//class TestPageState extends State<TestPage> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text("Test")),
//      body: Center(
//        child: Text("Test"),
//      ),
//    );
//  }
//}
