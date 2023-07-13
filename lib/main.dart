import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:frideos/frideos.dart';
// import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:xman/src/screens/introduction_screen.dart';
// import 'package:xman/src/screens/swipe_intro.dart';
import 'package:xman/src/screens/splash_screen.dart';
import './src/constance/routes.dart';
// import 'src/homepage.dart';
import 'src/models/appstate.dart';
import 'src/models/theme.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  final appState = AppState();

  @override
  Widget build(BuildContext context) {
    return AppStateProvider<AppState>(
      appState: appState,
      child: MaterialPage(),
    );
  }
}

class MaterialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = AppStateProvider.of<AppState>(context).currentTheme;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ValueBuilder<MyTheme>(
        streamed: theme,
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'BIBLE X-Man',
            color: Colors.white,
            theme: _buildThemeData(snapshot.data),
            // home: SplashScreen()
            routes: routes,
          );
        });
  }

  ThemeData _buildThemeData(MyTheme appTheme) {
    return ThemeData(
      brightness: appTheme.brightness,
      backgroundColor: Colors.purpleAccent,
      scaffoldBackgroundColor: appTheme.scaffoldBackgroundColor,
      primaryColor: Colors.purpleAccent,
      primaryColorBrightness: appTheme.primaryColorBrightness,
      accentColor: Colors.purpleAccent,
    );
  }

  var routes = <String, WidgetBuilder>{
    Routes.SPLASH: (BuildContext context) => SplashScreen(),
    Routes.Introdution: (BuildContext context) => IntroductionScreen(),
  };
}
