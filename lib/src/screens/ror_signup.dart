
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:food_delivery_app/generated/i18n.dart';
  import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:xman/src/controller/user_controller.dart';

// import '../controllers/user_controller.dart';
// import '../elements/BlockButtonWidget.dart';
// import '../helpers/app_config.dart' as config;
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import '../constance/app_config.dart' as config;

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends StateMVC<SignUpPage> {
  UserController _con;

  _SignUpPageState() : super(UserController()) {
    _con = controller;
  } 
  
   @override
  void initState() {
    super.initState();
    initPlatformState();
  }
  
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
        print('device incremental:'+androidInfo.version.incremental);
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
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _con.scaffoldKey,
        resizeToAvoidBottomPadding: false,
        body: Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Positioned(
              top: 0,
              child: Container(
                width: config.App(context).appWidth(100),
                height: config.App(context).appHeight(29.5),
                decoration: BoxDecoration(color:Colors.white),
              ),
            ),
            Positioned(
              top: config.App(context).appHeight(29.5) - 120,
              child: Container(
                width: config.App(context).appWidth(84),
                height: config.App(context).appHeight(29.5),
                child: Text(
                  "lets start registration",
                  style: (TextStyle(color: Colors.black)),
                ),
              ),
            ),
            Positioned(
              top: config.App(context).appHeight(29.5) - 50,
              child: Container(
                decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.all(Radius.circular(10)), boxShadow: [
                  BoxShadow(
                    blurRadius: 50,
                    color: Theme.of(context).hintColor.withOpacity(0.2),
                  )
                ]),
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding: EdgeInsets.symmetric(vertical: 50, horizontal: 27),
                width: config.App(context).appWidth(88),
//              height: config.App(context).appHeight(55),
                child: Form(
                  key: _con.loginFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => _con.user.firstName = input,
                        validator: (input) => input.length < 3 ? "S.of(context).should_be_more_than_3_letters" : null,
                        decoration: InputDecoration(
                          labelText: 'first name',
                          labelStyle: TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'John',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.person_outline, color: Colors.white),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
                        ),
                      ),
                       TextFormField(
                        keyboardType: TextInputType.text,
                        onSaved: (input) => _con.user.firstName = input,
                        validator: (input) => input.length < 3 ? "S.of(context).should_be_more_than_3_letters" : null,
                        decoration: InputDecoration(
                          labelText: 'last name',
                          labelStyle: TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Doe',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.person_outline, color: Colors.white),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (input) => _con.user.email = input,
                        validator: (input) => !input.contains('@') ? "S.of(context).should_be_a_valid_email" : null,
                        decoration: InputDecoration(
                          labelText: "email",
                          labelStyle: TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'johndoe@gmail.com',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.alternate_email, color:Colors.white),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 30),
                      TextFormField(
                        obscureText: _con.hidePassword,
                        onSaved: (input) => _con.user.password = input,
                        validator: (input) => input.length < 6 ? "S.of(context).should_be_more_than_6_letters" : null,
                        decoration: InputDecoration(
                          labelText: "password",
                          labelStyle: TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.all(12),
                          hintText: '••••••••••••',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _con.hidePassword = !_con.hidePassword;
                              });
                            },
                            color: Theme.of(context).focusColor,
                            icon: Icon(_con.hidePassword ? Icons.visibility : Icons.visibility_off),
                          ),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
                        ),
                      ),
                       TextFormField(
                        obscureText: _con.hidePassword,
                        onSaved: (input) => _con.user.password2 = input,
                        validator: (input) => input.length < 6 ? "S.of(context).should_be_more_than_6_letters" : null,
                        decoration: InputDecoration(
                          labelText: "confirm passowd",
                          labelStyle: TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.all(12),
                          hintText: '••••••••••••',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.white),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _con.hidePassword = !_con.hidePassword;
                              });
                            },
                            color: Theme.of(context).focusColor,
                            icon: Icon(_con.hidePassword ? Icons.visibility : Icons.visibility_off),
                          ),
                          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.5))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white.withOpacity(0.2))),
                        ),
                      ),
                      SizedBox(height: 30),
                      RaisedButton(
                        child: Text(
                          "register",
                          style: TextStyle(color:Colors.white),
                        ),
                        color: Colors.blue,
                        onPressed: () {
                          _con.register();
                        },
                      ),
                      SizedBox(height: 25),
//                      FlatButton(
//                        onPressed: () {
//                          Navigator.of(context).pushNamed('/MobileVerification');
//                        },
//                        padding: EdgeInsets.symmetric(vertical: 14),
//                        color: Theme.of(context).accentColor.withOpacity(0.1),
//                        shape: StadiumBorder(),
//                        child: Text(
//                          'Register with Google',
//                          textAlign: TextAlign.start,
//                          style: TextStyle(
//                            color: Theme.of(context).accentColor,
//                          ),
//                        ),
//                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/Login');
                },
                textColor: Theme.of(context).hintColor,
                child: Text("have an account or login"),
              ),
            )
          ],
        ),
      ),
    );
  }
}


























// import 'dart:convert';

// import 'package:flutter/material.dart';
// // import 'package:flutter_login_signup/src/Widget/bezierContainer.dart';
// // import 'package:flutter_login_signup/src/loginPage.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:xman/src/constance/constance.dart';
// import 'package:xman/src/controller/user_controller.dart';
// import 'package:xman/src/models/user.dart';
// import 'package:xman/src/screens/ror_login.dart';
// import 'package:xman/src/screens/tip_screen.dart';
// import 'package:xman/src/widgets/bezierContainer.dart';
// import 'dart:convert' as convert;
// import 'package:http/http.dart' as http;
// import 'package:dropdownfield/dropdownfield.dart';
// import 'package:dropdown_formfield/dropdown_formfield.dart';
// import '../reporsitory/user_reporsitory.dart' as repository;
// import 'package:firebase_messaging/firebase_messaging.dart';

// class SignUpPage extends StatefulWidget {
//   SignUpPage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _SignUpPageState createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
// // const json =  [{"id":""},{"id":1,"country_name":"Afghanistan"},{"id":""},{"id":2,"country_name":"Albania"},{"id":""},{"id":3,"country_name":"Algeria"},{"id":""},{"id":4,"country_name":"Andorra"},{"id":""},{"id":5,"country_name":"Angola"},{"id":""},{"id":6,"country_name":"Antigua and Barbuda"},{"id":""},{"id":7,"country_name":"Argentina"},{"id":""},{"id":8,"country_name":"Armenia"},{"id":""},{"id":9,"country_name":"Australia"},{"id":""},{"id":10,"country_name":"Austria"},{"id":""},{"id":11,"country_name":"Azerbaijan"},{"id":""},{"id":12,"country_name":"Bahamas"},{"id":""},{"id":13,"country_name":"Bahrain"},{"id":""},{"id":14,"country_name":"Bangladesh"},{"id":""},{"id":15,"country_name":"Barbados"},{"id":""},{"id":16,"country_name":"Belarus"},{"id":""},{"id":17,"country_name":"Belgium"},{"id":""},{"id":18,"country_name":"Belize"},{"id":""},{"id":19,"country_name":"Benin"},{"id":""},{"id":20,"country_name":"Bhutan"},{"id":""},{"id":21,"country_name":"Bolivia"},{"id":""},{"id":22,"country_name":"Bosnia and Herzegovina"},{"id":""},{"id":23,"country_name":"Botswana"},{"id":""},{"id":24,"country_name":"Brazil"},{"id":""},{"id":25,"country_name":"Brunei"},{"id":""},{"id":26,"country_name":"Bulgaria"},{"id":""},{"id":27,"country_name":"Burkina Faso"},{"id":""},{"id":28,"country_name":"Burma"},{"id":""},{"id":29,"country_name":"Burundi"},{"id":""},{"id":30,"country_name":"Cambodia"},{"id":""},{"id":31,"country_name":"Cameroon"},{"id":""},{"id":32,"country_name":"Canada"},{"id":""},{"id":33,"country_name":"Cape Verde"},{"id":""},{"id":34,"country_name":"Central African Republic"},{"id":""},{"id":35,"country_name":"Chad"},{"id":""},{"id":36,"country_name":"Chile"},{"id":""},{"id":37,"country_name":"China"},{"id":""},{"id":38,"country_name":"Colombia"},{"id":""},{"id":39,"country_name":"Comoros"},{"id":""},{"id":40,"country_name":"Costa Rica"},{"id":""},{"id":41,"country_name":"Cote d'Ivoire"},{"id":""},{"id":42,"country_name":"Croatia"},{"id":""},{"id":43,"country_name":"Cuba"},{"id":""},{"id":44,"country_name":"Cyprus"},{"id":""},{"id":45,"country_name":"Czech Republic"},{"id":""},{"id":46,"country_name":"Democratic Republic of the Congo"},{"id":""},{"id":47,"country_name":"Denmark"},{"id":""},{"id":48,"country_name":"Djibouti"},{"id":""},{"id":49,"country_name":"Dominica"},{"id":""},{"id":50,"country_name":"Dominican Republic"},{"id":""},{"id":218,"country_name":"European Union"},{"id":""},{"id":52,"country_name":"Ecuador"},{"id":""},{"id":53,"country_name":"Egypt"},{"id":""},{"id":54,"country_name":"El Salvador"},{"id":""},{"id":55,"country_name":"Equatorial Guinea"},{"id":""},{"id":56,"country_name":"Eritrea"},{"id":""},{"id":57,"country_name":"Estonia"},{"id":""},{"id":58,"country_name":"Ethiopia"},{"id":""},{"id":59,"country_name":"Fiji"},{"id":""},{"id":60,"country_name":"Finland"},{"id":""},{"id":61,"country_name":"France"},{"id":""},{"id":62,"country_name":"Gabon"},{"id":""},{"id":63,"country_name":"Gambia"},{"id":""},{"id":64,"country_name":"Georgia"},{"id":""},{"id":65,"country_name":"Germany"},{"id":""},{"id":66,"country_name":"Ghana"},{"id":""},{"id":67,"country_name":"Greece"},{"id":""},{"id":68,"country_name":"Grenada"},{"id":""},{"id":69,"country_name":"Guatemala"},{"id":""},{"id":70,"country_name":"Guinea"},{"id":""},{"id":71,"country_name":"Guinea-Bissau"},{"id":""},{"id":72,"country_name":"Guyana"},{"id":""},{"id":73,"country_name":"Haiti"},{"id":""},{"id":74,"country_name":"Holy See"},{"id":""},{"id":75,"country_name":"Honduras"},{"id":""},{"id":76,"country_name":"Hong Kong"},{"id":""},{"id":77,"country_name":"Hungary"},{"id":""},{"id":78,"country_name":"Iceland"},{"id":""},{"id":79,"country_name":"India"},{"id":""},{"id":80,"country_name":"Indonesia"},{"id":""},{"id":81,"country_name":"Iran"},{"id":""},{"id":82,"country_name":"Iraq"},{"id":""},{"id":83,"country_name":"Ireland"},{"id":""},{"id":84,"country_name":"Israel"},{"id":""},{"id":85,"country_name":"Italy"},{"id":""},{"id":86,"country_name":"Jamaica"},{"id":""},{"id":87,"country_name":"Japan"},{"id":""},{"id":88,"country_name":"Jordan"},{"id":""},{"id":89,"country_name":"Kazakhstan"},{"id":""},{"id":90,"country_name":"Kenya"},{"id":""},{"id":91,"country_name":"Kiribati"},{"id":""},{"id":92,"country_name":"Kosovo"},{"id":""},{"id":93,"country_name":"Kuwait"},{"id":""},{"id":94,"country_name":"Kyrgyzstan"},{"id":""},{"id":95,"country_name":"Laos"},{"id":""},{"id":96,"country_name":"Latvia"},{"id":""},{"id":97,"country_name":"Lebanon"},{"id":""},{"id":98,"country_name":"Lesotho"},{"id":""},{"id":99,"country_name":"Liberia"},{"id":""},{"id":100,"country_name":"Libya"},{"id":""},{"id":101,"country_name":"Liechtenstein"},{"id":""},{"id":102,"country_name":"Lithuania"},{"id":""},{"id":103,"country_name":"Luxembourg"},{"id":""},{"id":104,"country_name":"Macau"},{"id":""},{"id":105,"country_name":"Macedonia"},{"id":""},{"id":106,"country_name":"Madagascar"},{"id":""},{"id":107,"country_name":"Malaysia"},{"id":""},{"id":108,"country_name":"Maldives"},{"id":""},{"id":109,"country_name":"Mali"},{"id":""},{"id":110,"country_name":"Malta"},{"id":""},{"id":111,"country_name":"Marshall Islands"},{"id":""},{"id":112,"country_name":"Mauritania"},{"id":""},{"id":113,"country_name":"Mauritius"},{"id":""},{"id":114,"country_name":"Mexico"},{"id":""},{"id":115,"country_name":"Micronesia"},{"id":""},{"id":116,"country_name":"Monaco"},{"id":""},{"id":117,"country_name":"Mongolia"},{"id":""},{"id":118,"country_name":"Montenegro"},{"id":""},{"id":119,"country_name":"Morocco"},{"id":""},{"id":120,"country_name":"Mozambique"},{"id":""},{"id":121,"country_name":"Namibia"},{"id":""},{"id":122,"country_name":"Nauru"},{"id":""},{"id":123,"country_name":"Nepal"},{"id":""},{"id":124,"country_name":"Netherlands"},{"id":""},{"id":125,"country_name":"Netherlands Antilles"},{"id":""},{"id":126,"country_name":"New Zealand"},{"id":""},{"id":127,"country_name":"Nicaragua"},{"id":""},{"id":128,"country_name":"Niger"},{"id":""},{"id":129,"country_name":"Nigeria"},{"id":""},{"id":130,"country_name":"North Korea"},{"id":""},{"id":131,"country_name":"Norway"},{"id":""},{"id":132,"country_name":"Oman"},{"id":""},{"id":133,"country_name":"Pakistan"},{"id":""},{"id":134,"country_name":"Palau"},{"id":""},{"id":135,"country_name":"Palestine"},{"id":""},{"id":136,"country_name":"Panama"},{"id":""},{"id":137,"country_name":"Papua New Guinea"},{"id":""},{"id":138,"country_name":"Paraguay"},{"id":""},{"id":139,"country_name":"Peru"},{"id":""},{"id":140,"country_name":"Philippines"},{"id":""},{"id":141,"country_name":"Poland"},{"id":""},{"id":142,"country_name":"Portugal"},{"id":""},{"id":143,"country_name":"Qatar"},{"id":""},{"id":144,"country_name":"Republic of the Congo"},{"id":""},{"id":145,"country_name":"Romania"},{"id":""},{"id":146,"country_name":"Russia"},{"id":""},{"id":147,"country_name":"Rwanda"},{"id":""},{"id":148,"country_name":"Saint Kitts and Nevis"},{"id":""},{"id":149,"country_name":"Saint Lucia"},{"id":""},{"id":150,"country_name":"Saint Vincent and the Grenadines"},{"id":""},{"id":151,"country_name":"Samoa "},{"id":""},{"id":152,"country_name":"San Marino"},{"id":""},{"id":153,"country_name":"Sao Tome and Principe"},{"id":""},{"id":154,"country_name":"Saudi Arabia"},{"id":""},{"id":155,"country_name":"Senegal"},{"id":""},{"id":156,"country_name":"Serbia"},{"id":""},{"id":157,"country_name":"Seychelles"},{"id":""},{"id":158,"country_name":"Sierra Leone"},{"id":""},{"id":159,"country_name":"Singapore"},{"id":""},{"id":160,"country_name":"Slovakia"},{"id":""},{"id":161,"country_name":"Slovenia"},{"id":""},{"id":162,"country_name":"Solomon Islands"},{"id":""},{"id":163,"country_name":"Somalia"},{"id":""},{"id":164,"country_name":"South Africa"},{"id":""},{"id":165,"country_name":"South Korea"},{"id":""},{"id":166,"country_name":"South Sudan"},{"id":""},{"id":167,"country_name":"Spain "},{"id":""},{"id":168,"country_name":"Sri Lanka"},{"id":""},{"id":169,"country_name":"Sudan"},{"id":""},{"id":170,"country_name":"Suriname"},{"id":""},{"id":171,"country_name":"Swaziland"},{"id":""},{"id":172,"country_name":"Sweden"},{"id":""},{"id":173,"country_name":"Switzerland"},{"id":""},{"id":174,"country_name":"Syria"},{"id":""},{"id":175,"country_name":"Taiwan"},{"id":""},{"id":176,"country_name":"Tajikistan"},{"id":""},{"id":177,"country_name":"Tanzania"},{"id":""},{"id":178,"country_name":"Thailand "},{"id":""},{"id":179,"country_name":"Timor-Leste"},{"id":""},{"id":180,"country_name":"Togo"},{"id":""},{"id":181,"country_name":"Tonga"},{"id":""},{"id":182,"country_name":"Trinidad and Tobago"},{"id":""},{"id":183,"country_name":"Tunisia"},{"id":""},{"id":184,"country_name":"Turkey"},{"id":""},{"id":185,"country_name":"Turkmenistan"},{"id":""},{"id":186,"country_name":"Tuvalu"},{"id":""},{"id":187,"country_name":"Uganda"},{"id":""},{"id":188,"country_name":"Ukraine"},{"id":""},{"id":189,"country_name":"United Arab Emirates"},{"id":""},{"id":190,"country_name":"United Kingdom"},{"id":""},{"id":191,"country_name":"United States"},{"id":""},{"id":192,"country_name":"Uruguay"},{"id":""},{"id":193,"country_name":"Uzbekistan"},{"id":""},{"id":194,"country_name":"Vanuatu"},{"id":""},{"id":195,"country_name":"Vatican City"},{"id":""},{"id":196,"country_name":"Venezuela"},{"id":""},{"id":197,"country_name":"Vietnam"},{"id":""},{"id":198,"country_name":"Yemen"},{"id":""},{"id":199,"country_name":"Zambia"},{"id":""},{"id":200,"country_name":"Zimbabwe"},{"id":""},{"id":201,"country_name":"Akrotiri"},{"id":""},{"id":202,"country_name":"American Samoa"},{"id":""},{"id":203,"country_name":"Anguilla"},{"id":""},{"id":204,"country_name":"Aruba"},{"id":""},{"id":205,"country_name":"Ashmore and Cartier Islands"},{"id":""},{"id":206,"country_name":"Baker Island"},{"id":""},{"id":207,"country_name":"Bermuda"},{"id":""},{"id":208,"country_name":"Bouvet Island"},{"id":""},{"id":209,"country_name":"British Indian Ocean Territory"},{"id":""},{"id":210,"country_name":"British Virgin Islands"},{"id":""},{"id":211,"country_name":"Cayman Islands"},{"id":""},{"id":212,"country_name":"Christmas Island"},{"id":""},{"id":213,"country_name":"Clipperton Island"},{"id":""},{"id":214,"country_name":"Cocos (Keeling) Islands"},{"id":""},{"id":215,"country_name":"Cook Islands"},{"id":""},{"id":216,"country_name":"Coral Sea Islands"},{"id":""},{"id":217,"country_name":"Dhekelia"},{"id":""},{"id":219,"country_name":"Falkland Islands (Islas Malvinas)"},{"id":""},{"id":220,"country_name":"Faroe Islands"},{"id":""},{"id":221,"country_name":"French Polynesia"},{"id":""},{"id":222,"country_name":"French Southern and Antarctic Lands"},{"id":""},{"id":223,"country_name":"Gibraltar"},{"id":""},{"id":224,"country_name":"Greenland"},{"id":""},{"id":225,"country_name":"Guam"},{"id":""},{"id":228,"country_name":"Guernsey"},{"id":""},{"id":229,"country_name":"Heard Island and McDonald Islands"},{"id":""},{"id":230,"country_name":"Howland Island"},{"id":""},{"id":231,"country_name":"Isle of Man"},{"id":""},{"id":232,"country_name":"Jan Mayen"},{"id":""},{"id":233,"country_name":"Jarvis Island"},{"id":""},{"id":234,"country_name":"Jersey"},{"id":""},{"id":235,"country_name":"Johnston Atoll"},{"id":""},{"id":236,"country_name":"Kingman Reef"},{"id":""},{"id":237,"country_name":"Malawi"},{"id":""},{"id":238,"country_name":"Mayotte"},{"id":""},{"id":239,"country_name":"Midway Islands"},{"id":""},{"id":240,"country_name":"Moldova"},{"id":""},{"id":241,"country_name":"Montserrat"},{"id":""},{"id":242,"country_name":"Navassa Island"},{"id":""},{"id":243,"country_name":"New Caledonia"},{"id":""},{"id":244,"country_name":"Niue"},{"id":""},{"id":245,"country_name":"Norfolk Island"},{"id":""},{"id":246,"country_name":"Northern Mariana Islands"},{"id":""},{"id":247,"country_name":"Palmyra Atoll"},{"id":""},{"id":248,"country_name":"Pitcairn Islands"},{"id":""},{"id":249,"country_name":"Puerto Rico"},{"id":""},{"id":250,"country_name":"Saint Barthelemy"},{"id":""},{"id":251,"country_name":"Saint Helena"},{"id":""},{"id":252,"country_name":"Saint Martin"},{"id":""},{"id":253,"country_name":"Saint Pierre and Miquelon"},{"id":""},{"id":254,"country_name":"South Georgia and the South Sandwich Islands"},{"id":""},{"id":255,"country_name":"Svalbard"},{"id":""},{"id":256,"country_name":"Tokelau"},{"id":""},{"id":257,"country_name":"United States Pacific Island Wildlife Refuges"},{"id":""},{"id":258,"country_name":"Virgin Islands"},{"id":""},{"id":259,"country_name":"Wake Island"},{"id":""},{"id":260,"country_name":"Wallis and Futuna"},{"id":""},{"id":261,"country_name":"Turks and Caicos Islands"},{"id":""}];

// // final jsonResponse = convert.jsonDecode(json);

//   String _mySelection;
//   UserController _con;

//   User user = new User();
  
//   GlobalKey<ScaffoldState> scaffoldKey;
//   GlobalKey<FormState> loginFormKey;
//   FirebaseMessaging _firebaseMessaging;
//   bool hidePassword = true;

//   final String url = "http://solveitgh.org/xman/country.php";

//   List data = List(); //edited line
//   Map<String, dynamic> dat;
//   Future<String> getSWData() async {
//     var res = await http
//         .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
//     var resBody = json.decode(res.body);

//     setState(() {
//       data = resBody;
//       dat = resBody;
//     });

//     print(resBody);

//     return "Sucess";
//   }

//  void register() async {

// // _firebaseMessaging.getToken().then((String _deviceToken) {
// //       user.deviceToken = _deviceToken;
// //     });
// scaffoldKey.currentState.showSnackBar(SnackBar(
//             content: Text("S.current.welcome + value.name"),
//           ));
//           print("my code is working");
// user.deviceToken = "aw44545asd5";

//     if (loginFormKey.currentState.validate()) {
//       loginFormKey.currentState.save();
//       repository.register(user).then((value) {
//         if (value != null ) {
//           scaffoldKey.currentState.showSnackBar(SnackBar(
//             content: Text("S.current.welcome + value.name"),
//           ));
//           Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => TipScreen()));
//         } else {
//           scaffoldKey.currentState.showSnackBar(SnackBar(
//             content: Text("S.current.wrong_email_or_password"),
//           ));
//         }
//       });
//     }
//   }

//   Widget _backButton() {
//     return InkWell(
//       onTap: () {
//         Navigator.pop(context);
//       },
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 10),
//         child: Row(
//           children: <Widget>[
//             Container(
//               padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
//               child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
//             ),
//             Text('Back',
//                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _entryField(String title, {bool isPassword = false}) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 1),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             title,
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 8),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Column(
//             children: <Widget>[
//               TextField(
//                   obscureText: isPassword,
//                   decoration: InputDecoration(
//                       border: InputBorder.none,
//                       fillColor: Color(0xfff3f3f4),
//                       filled: true)),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget _submitButton() {
//     return GestureDetector(
//       onTap: () {
//                           register();
//                         },
//           child: Container(
//         width: MediaQuery.of(context).size.width,
//         padding: EdgeInsets.symmetric(vertical: 15),
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(5)),
//             boxShadow: <BoxShadow>[
//               BoxShadow(
//                   color: Colors.grey.shade200,
//                   offset: Offset(2, 4),
//                   blurRadius: 5,
//                   spreadRadius: 2)
//             ],
//             gradient: LinearGradient(
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//                 colors: [Color(0xfffbb448), Color(0xfff7892b)])),
//         child: Text(
//           'Register Now',
//           style: TextStyle(fontSize: 20, color: Colors.white),
//         ),
//       ),
//     );
//   }

//   Widget _loginAccountLabel() {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 20),
//       alignment: Alignment.bottomCenter,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             'Already have an account ?',
//             style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
//           ),
//           SizedBox(
//             width: 10,
//           ),
//           InkWell(
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => LoginPage()));
//             },
//             child: Text(
//               'Login',
//               style: TextStyle(
//                   color: Color(0xfff79c4f),
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Widget _title() {
//     return RichText(
//       textAlign: TextAlign.center,
//       text: TextSpan(
//           text: 'R',
//           style: GoogleFonts.portLligatSans(
//             textStyle: Theme.of(context).textTheme.display1,
//             fontSize: 30,
//             fontWeight: FontWeight.w700,
//             color: Colors.white,
//           ),
//           children: [
//             TextSpan(
//               text: 'OR',
//               style: TextStyle(color: Colors.black, fontSize: 30),
//             ),
//             TextSpan(
//               text: ' Bible',
//               style: TextStyle(color: Colors.white, fontSize: 30),
//             ),
//           ]),
//     );
//   }

//   Widget _emailPasswordWidget() {
//     return Column(
//       children: <Widget>[
//         _entryField("first Name"),
//         _entryField("last Name"),
//         _entryField("Email id"),
//         _entryField("Phone"),
//         _entryField("Password", isPassword: true),
//         _entryField("Password", isPassword: true),
//         _entryField(
//           "Password",
//         ),
//       ],
//     );
//   }

//   void initState() {
//     super.initState();
//     this.getSWData();
//     _myActivity = '';
//     _myActivityResult = '';
//   }

//   String _myActivity;
//   String _myActivityResult;
//   final formKey = new GlobalKey<FormState>();

//   _saveForm() {
//     var form = formKey.currentState;
//     if (form.validate()) {
//       form.save();
//       setState(() {
//         _myActivityResult = _myActivity;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//         body: SingleChildScrollView(
//             child: Stack(
//       children: <Widget>[
//         Container(
//           height: MediaQuery.of(context).size.height,
//           child: Stack(
//             children: <Widget>[
//               Container(
//                 height: MediaQuery.of(context).size.height,
//                 width: MediaQuery.of(context).size.width,
//                 child: Image.asset(
//                   ConstanceData.background4,
//                   alignment: Alignment.center,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               Form(
//                 key: loginFormKey,
//                               child: Container( 
//                   padding: EdgeInsets.symmetric(horizontal: 20),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Expanded(
//                         flex: 3,
//                         child: SizedBox(),
//                       ),
//                       _title(),
//                       SizedBox(
//                         height: 50,
//                       ),
//                       // _emailPasswordWidget(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           new Flexible(
//                               child: Container(
//                             margin: EdgeInsets.symmetric(vertical: 1),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   "First Name",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold, fontSize: 10),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Column(
//                                   children: <Widget>[
//                                     TextFormField(
//                         keyboardType: TextInputType.text,
//                         onSaved: (input) => user.firstName = input,
//                         validator: (input) => input.length < 3 ?' S.of(context).should_be_more_than_3_letters' : null,
//                         decoration: InputDecoration(
//                           labelText: 'first name',
//                           labelStyle: TextStyle(color: Theme.of(context).accentColor),
//                           contentPadding: EdgeInsets.all(12),
//                           hintText: "John",
//                           hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
//                           prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
//                           border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
//                           focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
//                           enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
//                         ),
//                       ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           )),
//                           SizedBox(width: 20),
//                           new Flexible(
//                               child: Container(
//                             margin: EdgeInsets.symmetric(vertical: 1),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   "Last Name",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold, fontSize: 10),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Column(
//                                   children: <Widget>[
//                                    TextFormField(
//                         keyboardType: TextInputType.text,
//                         onSaved: (input) => user.lastName = input,
//                         validator: (input) => input.length < 3 ? "S.of(context).should_be_more_than_3_letters" : null,
//                         decoration: InputDecoration(
//                           labelText: "last name",
//                           labelStyle: TextStyle(color: Theme.of(context).accentColor),
//                           contentPadding: EdgeInsets.all(12),
//                           hintText: "Doe",
//                           hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
//                           prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
//                           border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
//                           focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
//                           enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
//                         ),
//                       ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           )),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           new Flexible(
//                               child: Container(
//                             margin: EdgeInsets.symmetric(vertical: 1),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   "Email",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold, fontSize: 10),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 TextFormField(
//                         keyboardType: TextInputType.emailAddress,
//                         onSaved: (input) => user.email = input,
//                         validator: (input) => !input.contains('@') ? "S.of(context).should_be_a_valid_email" : null,
//                         decoration: InputDecoration(
//                           labelText: 'email',
//                           labelStyle: TextStyle(color: Theme.of(context).accentColor),
//                           contentPadding: EdgeInsets.all(12),
//                           hintText: 'johndoe@gmail.com',
//                           hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
//                           prefixIcon: Icon(Icons.alternate_email, color: Theme.of(context).accentColor),
//                           border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
//                           focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
//                           enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
//                         ),
//                       ),
//                               ],
//                             ),
//                           )),
//                           SizedBox(width: 20),
//                           new Flexible(
//                               child: Container(
//                             margin: EdgeInsets.symmetric(vertical: 1),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   "Phone",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold, fontSize: 10),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Column(
//                                   children: <Widget>[
//                                     TextFormField(
//                         keyboardType: TextInputType.text,
//                         onSaved: (input) => user.lastName = input,
//                         validator: (input) => input.length < 3 ? "S.of(context).should_be_more_than_3_letters" : null,
//                         decoration: InputDecoration(
//                           labelText: "phone",
//                           labelStyle: TextStyle(color: Theme.of(context).accentColor),
//                           contentPadding: EdgeInsets.all(12),
//                           hintText: "024******",
//                           hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
//                           prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).accentColor),
//                           border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
//                           focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
//                           enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
//                         ),
//                       ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           )),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),

//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           new Flexible(
//                               child: Container(
//                             margin: EdgeInsets.symmetric(vertical: 1),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   "Password",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold, fontSize: 10),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Column(
//                                   children: <Widget>[
//                                    TextFormField(
//                         obscureText: hidePassword,
//                         onSaved: (input) => user.password = input,
//                         validator: (input) => input.length < 6 ? "S.of(context).should_be_more_than_6_letters" : null,
//                         decoration: InputDecoration(
//                           labelText: 'password',
//                           labelStyle: TextStyle(color: Theme.of(context).accentColor),
//                           contentPadding: EdgeInsets.all(12),
//                           hintText: '••••••••••••',
//                           hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
//                           prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
//                           suffixIcon: IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 hidePassword = !hidePassword;
//                               });
//                             },
//                             color: Theme.of(context).focusColor,
//                             icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
//                           ),
//                           border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
//                           focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
//                           enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
//                         ),
//                       ),
//                                   ],
//                                 )
//                               ],
//                             ),
//                           )),
//                           SizedBox(width: 20),
//                           new Flexible(
//                               child: Container(
//                             margin: EdgeInsets.symmetric(vertical: 1),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   "Confirm Password",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold, fontSize: 10),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                                 Column(
//                                   children: <Widget>[
//                                     TextFormField(
//                         obscureText: hidePassword,
//                         onSaved: (input) => user.password2 = input,
//                         validator: (input) => input.length < 6 ? 'S.of(context).should_be_more_than_6_letters'  : null && input == user.password,
//                         decoration: InputDecoration(
//                           labelText: 'confirm password',
//                           labelStyle: TextStyle(color: Theme.of(context).accentColor),
//                           contentPadding: EdgeInsets.all(12),
//                           hintText: '••••••••••••',
//                           hintStyle: TextStyle(color: Theme.of(context).focusColor.withOpacity(0.7)),
//                           prefixIcon: Icon(Icons.lock_outline, color: Theme.of(context).accentColor),
//                           suffixIcon: IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 hidePassword = hidePassword;
//                               });
//                             },
//                             color: Theme.of(context).focusColor,
//                             icon: Icon(hidePassword ? Icons.visibility : Icons.visibility_off),
//                           ),
//                           border: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
//                           focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.5))),
//                           enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.2))),
//                         ),
//                       ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           )),
//                         ],
//                       ),
//                       Column(
//                         children: <Widget>[
//                           Container(
//                             margin: EdgeInsets.symmetric(vertical: 1),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(
//                                   "",
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold, fontSize: 10),
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),

//                                 //                     DropdownButton(
//                                 //   items: data.map((item) {
//                                 //     return new DropdownMenuItem(
//                                 //       child: Text(item['country_name'] !=null?item['country_name']:'default value'),
//                                 //       value: item['id'],
//                                 //     );
//                                 //   }).toList(),
//                                 //   onChanged: (newVal) {
//                                 //     setState(() {
//                                 //       _mySelection = newVal;
//                                 //     });
//                                 //   },
//                                 //   value: _mySelection,
//                                 // ),
//                                 DropDownFormField(
//                                   titleText: 'Country',
//                                   hintText: 'Please choose one',
//                                   value: _myActivity,
//                                   onSaved: (value) {
//                                     setState(() {
//                                       user.country  = '1';
//                                     });
//                                   },
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _myActivity = value;
//                                     });
//                                   },
//                                   dataSource: [
//                                     {"id": 1, "country_name": "Afghanistan"},
//                                     {"id": 2, "country_name": "Albania"},
//                                     {"id": 3, "country_name": "Algeria"},
//                                     {"id": 4, "country_name": "Andorra"},
//                                     {"id": 5, "country_name": "Angola"},
//                                     {
//                                       "id": 6,
//                                       "country_name": "Antigua and Barbuda"
//                                     },
//                                     {"id": 7, "country_name": "Argentina"},
//                                     {"id": 8, "country_name": "Armenia"},
//                                     {"id": 9, "country_name": "Australia"},
//                                     {"id": 10, "country_name": "Austria"},
//                                     {"id": 11, "country_name": "Azerbaijan"},
//                                     {"id": 12, "country_name": "Bahamas"},
//                                     {"id": 13, "country_name": "Bahrain"},
//                                     {"id": 14, "country_name": "Bangladesh"},
//                                     {"id": 15, "country_name": "Barbados"},
//                                     {"id": 16, "country_name": "Belarus"},
//                                     {"id": 17, "country_name": "Belgium"},
//                                     {"id": 18, "country_name": "Belize"},
//                                     {"id": 19, "country_name": "Benin"},
//                                     {"id": 20, "country_name": "Bhutan"},
//                                     {"id": 21, "country_name": "Bolivia"},
//                                     {
//                                       "id": 22,
//                                       "country_name": "Bosnia and Herzegovina"
//                                     },
//                                     {"id": 23, "country_name": "Botswana"},
//                                     {"id": 24, "country_name": "Brazil"},
//                                     {"id": 25, "country_name": "Brunei"},
//                                     {"id": 26, "country_name": "Bulgaria"},
//                                     {"id": 27, "country_name": "Burkina Faso"},
//                                     {"id": 28, "country_name": "Burma"},
//                                     {"id": 29, "country_name": "Burundi"},
//                                     {"id": 30, "country_name": "Cambodia"},
//                                     {"id": 31, "country_name": "Cameroon"},
//                                     {"id": 32, "country_name": "Canada"},
//                                     {"id": 33, "country_name": "Cape Verde"},
//                                     {
//                                       "id": 34,
//                                       "country_name": "Central African Republic"
//                                     },
//                                     {"id": 35, "country_name": "Chad"},
//                                     {"id": 36, "country_name": "Chile"},
//                                     {"id": 37, "country_name": "China"},
//                                     {"id": 38, "country_name": "Colombia"},
//                                     {"id": 39, "country_name": "Comoros"},
//                                     {"id": 40, "country_name": "Costa Rica"},
//                                     {"id": 41, "country_name": "Cote d'Ivoire"},
//                                     {"id": 42, "country_name": "Croatia"},
//                                     {"id": 43, "country_name": "Cuba"},
//                                     {"id": 44, "country_name": "Cyprus"},
//                                     {"id": 45, "country_name": "Czech Republic"},
//                                     {
//                                       "id": 46,
//                                       "country_name":
//                                           "Democratic Republic of the Congo"
//                                     },
//                                     {"id": 47, "country_name": "Denmark"},
//                                     {"id": 48, "country_name": "Djibouti"},
//                                     {"id": 49, "country_name": "Dominica"},
//                                     {
//                                       "id": 50,
//                                       "country_name": "Dominican Republic"
//                                     },
//                                     {"id": 218, "country_name": "European Union"},
//                                     {"id": 52, "country_name": "Ecuador"},
//                                     {"id": 53, "country_name": "Egypt"},
//                                     {"id": 54, "country_name": "El Salvador"},
//                                     {
//                                       "id": 55,
//                                       "country_name": "Equatorial Guinea"
//                                     },
//                                     {"id": 56, "country_name": "Eritrea"},
//                                     {"id": 57, "country_name": "Estonia"},
//                                     {"id": 58, "country_name": "Ethiopia"},
//                                     {"id": 59, "country_name": "Fiji"},
//                                     {"id": 60, "country_name": "Finland"},
//                                     {"id": 61, "country_name": "France"},
//                                     {"id": 62, "country_name": "Gabon"},
//                                     {"id": 63, "country_name": "Gambia"},
//                                     {"id": 64, "country_name": "Georgia"},
//                                     {"id": 65, "country_name": "Germany"},
//                                     {"id": 66, "country_name": "Ghana"},
//                                     {"id": 67, "country_name": "Greece"},
//                                     {"id": 68, "country_name": "Grenada"},
//                                     {"id": 69, "country_name": "Guatemala"},
//                                     {"id": 70, "country_name": "Guinea"},
//                                     {"id": 71, "country_name": "Guinea-Bissau"},
//                                     {"id": 72, "country_name": "Guyana"},
//                                     {"id": 73, "country_name": "Haiti"},
//                                     {"id": 74, "country_name": "Holy See"},
//                                     {"id": 75, "country_name": "Honduras"},
//                                     {"id": 76, "country_name": "Hong Kong"},
//                                     {"id": 77, "country_name": "Hungary"},
//                                     {"id": 78, "country_name": "Iceland"},
//                                     {"id": 79, "country_name": "India"},
//                                     {"id": 80, "country_name": "Indonesia"},
//                                     {"id": 81, "country_name": "Iran"},
//                                     {"id": 82, "country_name": "Iraq"},
//                                     {"id": 83, "country_name": "Ireland"},
//                                     {"id": 84, "country_name": "Israel"},
//                                     {"id": 85, "country_name": "Italy"},
//                                     {"id": 86, "country_name": "Jamaica"},
//                                     {"id": 87, "country_name": "Japan"},
//                                     {"id": 88, "country_name": "Jordan"},
//                                     {"id": 89, "country_name": "Kazakhstan"},
//                                     {"id": 90, "country_name": "Kenya"},
//                                     {"id": 91, "country_name": "Kiribati"},
//                                     {"id": 92, "country_name": "Kosovo"},
//                                     {"id": 93, "country_name": "Kuwait"},
//                                     {"id": 94, "country_name": "Kyrgyzstan"},
//                                     {"id": 95, "country_name": "Laos"},
//                                     {"id": 96, "country_name": "Latvia"},
//                                     {"id": 97, "country_name": "Lebanon"},
//                                     {"id": 98, "country_name": "Lesotho"},
//                                     {"id": 99, "country_name": "Liberia"},
//                                     {"id": 100, "country_name": "Libya"},
//                                     {"id": 101, "country_name": "Liechtenstein"},
//                                     {"id": 102, "country_name": "Lithuania"},
//                                     {"id": 103, "country_name": "Luxembourg"},
//                                     {"id": 104, "country_name": "Macau"},
//                                     {"id": 105, "country_name": "Macedonia"},
//                                     {"id": 106, "country_name": "Madagascar"},
//                                     {"id": 107, "country_name": "Malaysia"},
//                                     {"id": 108, "country_name": "Maldives"},
//                                     {"id": 109, "country_name": "Mali"},
//                                     {"id": 110, "country_name": "Malta"},
//                                     {
//                                       "id": 111,
//                                       "country_name": "Marshall Islands"
//                                     },
//                                     {"id": 112, "country_name": "Mauritania"},
//                                     {"id": 113, "country_name": "Mauritius"},
//                                     {"id": 114, "country_name": "Mexico"},
//                                     {"id": 115, "country_name": "Micronesia"},
//                                     {"id": 116, "country_name": "Monaco"},
//                                     {"id": 117, "country_name": "Mongolia"},
//                                     {"id": 118, "country_name": "Montenegro"},
//                                     {"id": 119, "country_name": "Morocco"},
//                                     {"id": 120, "country_name": "Mozambique"},
//                                     {"id": 121, "country_name": "Namibia"},
//                                     {"id": 122, "country_name": "Nauru"},
//                                     {"id": 123, "country_name": "Nepal"},
//                                     {"id": 124, "country_name": "Netherlands"},
//                                     {
//                                       "id": 125,
//                                       "country_name": "Netherlands Antilles"
//                                     },
//                                     {"id": 126, "country_name": "New Zealand"},
//                                     {"id": 127, "country_name": "Nicaragua"},
//                                     {"id": 128, "country_name": "Niger"},
//                                     {"id": 129, "country_name": "Nigeria"},
//                                     {"id": 130, "country_name": "North Korea"},
//                                     {"id": 131, "country_name": "Norway"},
//                                     {"id": 132, "country_name": "Oman"},
//                                     {"id": 133, "country_name": "Pakistan"},
//                                     {"id": 134, "country_name": "Palau"},
//                                     {"id": 135, "country_name": "Palestine"},
//                                     {"id": 136, "country_name": "Panama"},
//                                     {
//                                       "id": 137,
//                                       "country_name": "Papua New Guinea"
//                                     },
//                                     {"id": 138, "country_name": "Paraguay"},
//                                     {"id": 139, "country_name": "Peru"},
//                                     {"id": 140, "country_name": "Philippines"},
//                                     {"id": 141, "country_name": "Poland"},
//                                     {"id": 142, "country_name": "Portugal"},
//                                     {"id": 143, "country_name": "Qatar"},
//                                     {
//                                       "id": 144,
//                                       "country_name": "Republic of the Congo"
//                                     },
//                                     {"id": 145, "country_name": "Romania"},
//                                     {"id": 146, "country_name": "Russia"},
//                                     {"id": 147, "country_name": "Rwanda"},
//                                     {
//                                       "id": 148,
//                                       "country_name": "Saint Kitts and Nevis"
//                                     },
//                                     {"id": 149, "country_name": "Saint Lucia"},
//                                     {
//                                       "id": 150,
//                                       "country_name":
//                                           "Saint Vincent and the Grenadines"
//                                     },
//                                     {"id": 151, "country_name": "Samoa "},
//                                     {"id": 152, "country_name": "San Marino"},
//                                     {
//                                       "id": 153,
//                                       "country_name": "Sao Tome and Principe"
//                                     },
//                                     {"id": 154, "country_name": "Saudi Arabia"},
//                                     {"id": 155, "country_name": "Senegal"},
//                                     {"id": 156, "country_name": "Serbia"},
//                                     {"id": 157, "country_name": "Seychelles"},
//                                     {"id": 158, "country_name": "Sierra Leone"},
//                                     {"id": 159, "country_name": "Singapore"},
//                                     {"id": 160, "country_name": "Slovakia"},
//                                     {"id": 161, "country_name": "Slovenia"},
//                                     {
//                                       "id": 162,
//                                       "country_name": "Solomon Islands"
//                                     },
//                                     {"id": 163, "country_name": "Somalia"},
//                                     {"id": 164, "country_name": "South Africa"},
//                                     {"id": 165, "country_name": "South Korea"},
//                                     {"id": 166, "country_name": "South Sudan"},
//                                     {"id": 167, "country_name": "Spain "},
//                                     {"id": 168, "country_name": "Sri Lanka"},
//                                     {"id": 169, "country_name": "Sudan"},
//                                     {"id": 170, "country_name": "Suriname"},
//                                     {"id": 171, "country_name": "Swaziland"},
//                                     {"id": 172, "country_name": "Sweden"},
//                                     {"id": 173, "country_name": "Switzerland"},
//                                     {"id": 174, "country_name": "Syria"},
//                                     {"id": 175, "country_name": "Taiwan"},
//                                     {"id": 176, "country_name": "Tajikistan"},
//                                     {"id": 177, "country_name": "Tanzania"},
//                                     {"id": 178, "country_name": "Thailand "},
//                                     {"id": 179, "country_name": "Timor-Leste"},
//                                     {"id": 180, "country_name": "Togo"},
//                                     {"id": 181, "country_name": "Tonga"},
//                                     {
//                                       "id": 182,
//                                       "country_name": "Trinidad and Tobago"
//                                     },
//                                     {"id": 183, "country_name": "Tunisia"},
//                                     {"id": 184, "country_name": "Turkey"},
//                                     {"id": 185, "country_name": "Turkmenistan"},
//                                     {"id": 186, "country_name": "Tuvalu"},
//                                     {"id": 187, "country_name": "Uganda"},
//                                     {"id": 188, "country_name": "Ukraine"},
//                                     {
//                                       "id": 189,
//                                       "country_name": "United Arab Emirates"
//                                     },
//                                     {"id": 190, "country_name": "United Kingdom"},
//                                     {"id": 191, "country_name": "United States"},
//                                     {"id": 192, "country_name": "Uruguay"},
//                                     {"id": 193, "country_name": "Uzbekistan"},
//                                     {"id": 194, "country_name": "Vanuatu"},
//                                     {"id": 195, "country_name": "Vatican City"},
//                                     {"id": 196, "country_name": "Venezuela"},
//                                     {"id": 197, "country_name": "Vietnam"},
//                                     {"id": 198, "country_name": "Yemen"},
//                                     {"id": 199, "country_name": "Zambia"},
//                                     {"id": 200, "country_name": "Zimbabwe"},
//                                     {"id": 201, "country_name": "Akrotiri"},
//                                     {"id": 202, "country_name": "American Samoa"},
//                                     {"id": 203, "country_name": "Anguilla"},
//                                     {"id": 204, "country_name": "Aruba"},
//                                     {
//                                       "id": 205,
//                                       "country_name":
//                                           "Ashmore and Cartier Islands"
//                                     },
//                                     {"id": 206, "country_name": "Baker Island"},
//                                     {"id": 207, "country_name": "Bermuda"},
//                                     {"id": 208, "country_name": "Bouvet Island"},
//                                     {
//                                       "id": 209,
//                                       "country_name":
//                                           "British Indian Ocean Territory"
//                                     },
//                                     {
//                                       "id": 210,
//                                       "country_name": "British Virgin Islands"
//                                     },
//                                     {"id": 211, "country_name": "Cayman Islands"},
//                                     {
//                                       "id": 212,
//                                       "country_name": "Christmas Island"
//                                     },
//                                     {
//                                       "id": 213,
//                                       "country_name": "Clipperton Island"
//                                     },
//                                     {
//                                       "id": 214,
//                                       "country_name": "Cocos (Keeling) Islands"
//                                     },
//                                     {"id": 215, "country_name": "Cook Islands"},
//                                     {
//                                       "id": 216,
//                                       "country_name": "Coral Sea Islands"
//                                     },
//                                     {"id": 217, "country_name": "Dhekelia"},
//                                     {
//                                       "id": 219,
//                                       "country_name":
//                                           "Falkland Islands (Islas Malvinas)"
//                                     },
//                                     {"id": 220, "country_name": "Faroe Islands"},
//                                     {
//                                       "id": 221,
//                                       "country_name": "French Polynesia"
//                                     },
//                                     {
//                                       "id": 222,
//                                       "country_name":
//                                           "French Southern and Antarctic Lands"
//                                     },
//                                     {"id": 223, "country_name": "Gibraltar"},
//                                     {"id": 224, "country_name": "Greenland"},
//                                     {"id": 225, "country_name": "Guam"},
//                                     {"id": 228, "country_name": "Guernsey"},
//                                     {
//                                       "id": 229,
//                                       "country_name":
//                                           "Heard Island and McDonald Islands"
//                                     },
//                                     {"id": 230, "country_name": "Howland Island"},
//                                     {"id": 231, "country_name": "Isle of Man"},
//                                     {"id": 232, "country_name": "Jan Mayen"},
//                                     {"id": 233, "country_name": "Jarvis Island"},
//                                     {"id": 234, "country_name": "Jersey"},
//                                     {"id": 235, "country_name": "Johnston Atoll"},
//                                     {"id": 236, "country_name": "Kingman Reef"},
//                                     {"id": 237, "country_name": "Malawi"},
//                                     {"id": 238, "country_name": "Mayotte"},
//                                     {"id": 239, "country_name": "Midway Islands"},
//                                     {"id": 240, "country_name": "Moldova"},
//                                     {"id": 241, "country_name": "Montserrat"},
//                                     {"id": 242, "country_name": "Navassa Island"},
//                                     {"id": 243, "country_name": "New Caledonia"},
//                                     {"id": 244, "country_name": "Niue"},
//                                     {"id": 245, "country_name": "Norfolk Island"},
//                                     {
//                                       "id": 246,
//                                       "country_name": "Northern Mariana Islands"
//                                     },
//                                     {"id": 247, "country_name": "Palmyra Atoll"},
//                                     {
//                                       "id": 248,
//                                       "country_name": "Pitcairn Islands"
//                                     },
//                                     {"id": 249, "country_name": "Puerto Rico"},
//                                     {
//                                       "id": 250,
//                                       "country_name": "Saint Barthelemy"
//                                     },
//                                     {"id": 251, "country_name": "Saint Helena"},
//                                     {"id": 252, "country_name": "Saint Martin"},
//                                     {
//                                       "id": 253,
//                                       "country_name": "Saint Pierre and Miquelon"
//                                     },
//                                     {
//                                       "id": 254,
//                                       "country_name":
//                                           "South Georgia and the South Sandwich Islands"
//                                     },
//                                     {"id": 255, "country_name": "Svalbard"},
//                                     {"id": 256, "country_name": "Tokelau"},
//                                     {
//                                       "id": 257,
//                                       "country_name":
//                                           "United States Pacific Island Wildlife Refuges"
//                                     },
//                                     {"id": 258, "country_name": "Virgin Islands"},
//                                     {"id": 259, "country_name": "Wake Island"},
//                                     {
//                                       "id": 260,
//                                       "country_name": "Wallis and Futuna"
//                                     },
//                                     {
//                                       "id": 261,
//                                       "country_name": "Turks and Caicos Islands"
//                                     }
//                                   ],
//                                   textField: 'country_name',
//                                   valueField: 'id',
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
                      
//                 //        Container(
//                 //   padding: EdgeInsets.all(8),
//                 //   child: RaisedButton(
//                 //     child: Text('Save'),
//                 //     onPressed: _saveForm,
//                 //   ),
//                 // ),
//                 // Container(
//                 //   padding: EdgeInsets.all(16),
//                 //   child: Text(_myActivityResult),
//                 // ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       // _submitButton(),
//                       RaisedButton(onPressed:  () {
//                           register();
//                         },child: Text("submit"),),
//                       Expanded(
//                         flex: 2,
//                         child: SizedBox(),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: _loginAccountLabel(),
//               ),
//               Positioned(top: 40, left: 0, child: _backButton()),
//               // Positioned(
//               //     top: -MediaQuery.of(context).size.height * .15,
//               //     right: -MediaQuery.of(context).size.width * .4,
//               //     child: BezierContainer())
//             ],
//           ),
//         ),
//       ],
//     )));
//   }
// }

// // Row(
// //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                 children: [
// //                 new Flexible(child: phonenumber),
// //                   new Flexible(child: phonenumber),
// //                 ],
// //               ),
