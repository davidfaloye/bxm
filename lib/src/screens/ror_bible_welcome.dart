  import 'package:flutter/material.dart';
// import 'package:flutter_login_signup/src/loginPage.dart';
// import 'package:flutter_login_signup/src/signup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xman/src/constance/constance.dart';
import 'package:xman/src/screens/ror_login.dart';
import 'package:xman/src/screens/ror_signup.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xFF611550).withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Color(0xFF861677)),
        ),
      ),
    );
  }

  Widget _signUpButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          'Register now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _label() {
    return Container(
        margin: EdgeInsets.only(top: 40, bottom: 20),
        child: Column(
          children: <Widget>[
            // Text(
            //   'Quick login with Touch ID',
            //   style: TextStyle(color: Colors.white, fontSize: 17),
            // ),
            // SizedBox(
            //   height: 20,
            // ),
            // Icon(Icons.fingerprint, size: 90, color: Colors.white),
            // SizedBox(
            //   height: 20,
            // ),
            // Text(
            //   'Touch ID',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 15,
            //     decoration: TextDecoration.underline,
            //   ),
            // ),
          ],
        ));
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'R',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
          children: [
            TextSpan(
              text: 'OR',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: ' Bible',
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ]),
    );
  }

 Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child:Stack(children: <Widget>[
           Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      ConstanceData.background4,
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                    ),
                  ),
               Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  // boxShadow: <BoxShadow>[
                  //   BoxShadow(
                  //       color: Colors.grey.shade200,
                  //       offset: Offset(2, 4),
                  //       blurRadius: 5,
                  //       spreadRadius: 2)
                  // ],
                  // gradient: LinearGradient(
                  //     begin: Alignment.topCenter,
                  //     end: Alignment.bottomCenter,
                  //     colors: [Color(0xFF550E45), Color(0xFF310628)])
                      ),
              child: Stack(children: <Widget>[
                
    Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    _title(),
                    SizedBox(
                      height: 80,
                    ),
                    _submitButton(),
                    SizedBox(
                      height: 20,
                    ),
                    _signUpButton(),
                    SizedBox(
                      height: 20,
                    ),
                    _label(),
                    
                  ],
                ),
                Positioned(top: 40, left: 0, child: _backButton()),
              ],
                         
              ),
            ),
        ],
             
        ),
      ),
    );
  }
}
