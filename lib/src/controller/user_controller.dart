import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:xman/src/screens/tip_screen.dart';

// import '../../generated/i18n.dart';
import '../models/user.dart';
// import '/repository/user_repository.dart' as repository;
import '../reporsitory/user_reporsitory.dart' as repository;

class UserController extends ControllerMVC {
  User user = new User();
  bool hidePassword = true;
  GlobalKey<FormState> loginFormKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  FirebaseMessaging _firebaseMessaging;

  UserController() {
    loginFormKey = new GlobalKey<FormState>();
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    _firebaseMessaging = FirebaseMessaging();

    _firebaseMessaging.getToken().then((String _deviceToken) {
      user.deviceToken = _deviceToken;
    });
  }

  void login() async {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      repository.login(user).then((value) {
        //print(value.apiToken);
        if (value != null && value.apiToken != null) {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("S.current.welcome + value.name"),
          ));
          Navigator.of(scaffoldKey.currentContext)
              .pushReplacementNamed('/Pages', arguments: 2);
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("S.current.wrong_email_or_password"),
          ));
        }
      });
    }
  }

  void register() async {
    // user.deviceToken = "aw44ffghh545asd5";
    user.country = '3';
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      repository.register(user).then((value) {
        if (value != null) {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("S.current.welcome + value.name"),
          ));
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => TipScreen()));
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("S.current.wrong_email_or_password"),
          ));
        }
      });
    }
  }

  void userScore() async {
    repository.score(user).then((value) {
//      if (value != null) {
//        scaffoldKey.currentState.showSnackBar(SnackBar(
//          content: Text("S.current.welcome + value.name"),
//        ));
//      } else {
//        scaffoldKey.currentState.showSnackBar(SnackBar(
//          content: Text("S.current.wrong_email_or_password"),
//        ));
//      }
    });
    // }
  }

  void questRegister(Function() callback) async {
    // user.deviceToken = "aw44ffghh545asd5";
    // repository.getCurrentUser();
    // if(repository.currentUser.value != Null){

    // }

    repository.questLogin(user).then((value) {
      if (value != null) {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("S.current.welcome + value.name"),
        ));
        if (callback != null) {
          callback();
        }
      } else {
        scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("S.current.wrong_email_or_password"),
        ));
      }
    });
  }

  void resetPassword() {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      repository.resetPassword(user).then((value) {
        if (value != null && value == true) {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content:
                Text("S.current.your_reset_link_has_been_sent_to_your_email"),
            action: SnackBarAction(
              label: "S.current.login",
              onPressed: () {
                Navigator.of(scaffoldKey.currentContext)
                    .pushReplacementNamed('/Login');
              },
            ),
            duration: Duration(seconds: 10),
          ));
        } else {
          scaffoldKey.currentState.showSnackBar(SnackBar(
            content: Text("S.current.error_verify_email_settings"),
          ));
        }
      });
    }
  }
}
