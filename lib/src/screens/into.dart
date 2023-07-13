import 'package:flutter/material.dart';
import 'package:xman/src/constance/constance.dart';

class IntroScreen extends StatefulWidget {
  IntroScreen({Key key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: MediaQuery.of(context).size.height - 350,
          // left: -22,
          // right: -40,
          // bottom: 90,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(
            ConstanceData.effectsImage,
            fit: BoxFit.fitWidth,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ],
    );
  }
}
