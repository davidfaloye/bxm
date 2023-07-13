import 'package:flutter/material.dart';

import 'package:frideos/frideos.dart';
import 'package:xman/src/constance/constance.dart';
import 'package:xman/src/homepage.dart';

import '../models/appstate.dart';
import '../models/category.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = AppStateProvider.of<AppState>(context);

    return
        // Center(child: Text('data'),);
        GestureDetector(
      onTap: appState.startTrivia,
      onLongPress: appState.longQuestion,
      child: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              ConstanceData.path2,
              alignment: Alignment.center,
              fit: BoxFit.fill,
            ),
          ),
        ],
     
      ),
    );
   
  }
}
