import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
// import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xman/src/reporsitory/user_service.dart';

// import '../helpers/helper.dart';
// import '../models/address.dart';
// import '../models/credit_card.dart';
import '../models/user.dart';
// import '../repository/user_repository.dart' as userRepo;

ValueNotifier<User> currentUser = new ValueNotifier(User());
String token;
User user = new User();
UserService userService = new UserService();

int mycoin = 0;
int questionLevel = 0;
int diamond = 0;
int swap = 0;
int f5050 = 0;
int lifeCoach = 0;
int leafFaith = 0;
int squadronPack = 0;
int faithPack = 0;
int victoryPack = 0;
int askAudience = 0;
// Address deliveryAddress = new Address();

Future<User> login(User user) async {
  final String url = 'https://api.rorbible.plus/login.php';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  if (response.statusCode == 200) {
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  }
  return currentUser.value;
}

Future<User> register(param0,
    {User user,
    password,
    email,
    firstname,
    lastname,
    country,
    phone,
    password2}) async {
  print('MY DEVICE TOKEN IS :' + user.deviceToken);
  final String url = 'https://api.rorbible.plus/register.php';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: {
      "email": email,
      "first_name": firstname,
      "last_name": lastname,
      "phone": phone,
      "country": country,
      "password": password,
      "password2": password2,
      "deviceType": user.deviceType,
      "deviceToken": user.deviceToken
    },
  );
  if (response.statusCode == 200) {
    print(response.body);
    setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  }
  return currentUser.value;
}

Future<User> questLogin(User user) async {
  print('MY DEVICE TOKEN IS :' + user.deviceToken);
  print('total coin' + ' ' + userService.totalcoin.toString());

  final String url = 'https://xman.rorbible.plus/api/api/device-code';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.questToMap()),
  );
  if (response.statusCode == 200) {
    print(response.body);
    user.apiToken = json.decode(response.body)['data']['token'];
    token = json.decode(response.body)['data']['token'];

    // print(userService.loadScore());

    print(user.apiToken);

    loadScore();
    // setCurrentUser(response.body);
    currentUser.value = User.fromJSON(json.decode(response.body)['data']);
    // loadScore();
  } else {
    print("error registering");
  }
  return currentUser.value;
}

Future<User> loadScore() async {
  // String token;
  // token = user.apiToken;
  User user = new User();

  final String url = 'http://xman.rorbible.plus/api/api/total-scores';
  // final client = new http.Client();
  final response = await http.get(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: "application/json", // or whatever
      HttpHeaders.authorizationHeader: "Bearer $token",
    },
  );
  if (response.statusCode == 200) {
    print(response.body);

    diamond = json.decode(response.body)['data']['diamond'];
    mycoin = json.decode(response.body)['data']['coin'];
    swap = json.decode(response.body)['data']['swap'];
    leafFaith = json.decode(response.body)['data']['leafFaith'];
    lifeCoach = json.decode(response.body)['data']['lifeCoach'];
    f5050 = json.decode(response.body)['data']['f5050'];
    squadronPack = json.decode(response.body)['data']['squadronPack'];
    faithPack = json.decode(response.body)['data']['faithPack'];
    victoryPack = json.decode(response.body)['data']['victoryPack'];
    askAudience = json.decode(response.body)['data']['askAudience'];

    print('my coin is ======' + mycoin.toString());
  } else {
    print(response.body);
    print("error fetching data");
    print(token);
    //  print('my token is:'+user.apiToken);
  }
  return currentUser.value;
}

fromScore() {
  user.coin = currentUser.value.coin;
  user.diamond = currentUser.value.diamond;
  user.swap = currentUser.value.swap;
  user.f5050 = currentUser.value.swap;
  user.lifeCoach = currentUser.value.lifeCoach;
  user.leafFaith = currentUser.value.leafFaith;
  user.squadronPack = currentUser.value.squadronPack;
  user.faithPack = currentUser.value.faithPack;
  user.victoryBox = currentUser.value.victoryBox;

  print('my user coin' + user.coin.toString());
  print('my user diamond' + user.diamond.toString());
}

Future<User> score(User user) async {
  // String token;
  // user.apiToken = token;

  final String url = 'http://xman.rorbible.plus/api/api/user-score';
  // final client = new http.Client();
  final response = await http.post(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.authorizationHeader: "Bearer $token"
    },
    body: json.encode(scoresToMap()),
  );
  if (response.statusCode == 200) {
    print(response.body);
    print(token);
  } else {
    print(response.body);
    print("erroor submitting scores");
    print('token is :' + token);
    print('user token :' + user.apiToken);
    //  print('my token is:'+user.apiToken);
  }
  return currentUser.value;
}

Map scoresToMap() {
  var map = new Map<String, dynamic>();
  map["coin"] = mycoin;
  map["diamond"] = diamond;
  map["tools"] = [
    {"id": "1", "qty": swap},
    {"id": "3", "qty": askAudience},
    {"id": "3", "qty": lifeCoach},
    {"id": "4", "qty": f5050}
  ];
  map["packages"] = [
    {"id": "1", "qty": victoryPack},
    {"id": "3", "qty": leafFaith},
    {"id": "3", "qty": squadronPack},
    {"id": "4", "qty": faithPack}
  ];

  return map;
}

Future<bool> resetPassword(User user) async {
  final String url = 'https://api.rorbible.plus/forgotPass.php?email=';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  if (response.statusCode == 200) {
    print(json.decode(response.body)['data']);
    return true;
  } else {
    return false;
  }
}

Future<void> logout() async {
  currentUser.value = new User();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('current_user');
}

void setCurrentUser(jsonString) async {
  if (json.decode(jsonString)['data'] != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'current_user', json.encode(json.decode(jsonString)['data']));
  }
}

// Future<void> setCreditCard(CreditCard creditCard) async {
//   if (creditCard != null) {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.setString('credit_card', json.encode(creditCard.toMap()));
//   }
// }

Future<User> getCurrentUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
//  prefs.clear();
  if (currentUser.value.auth == null && prefs.containsKey('current_user')) {
    currentUser.value =
        User.fromJSON(json.decode(await prefs.get('current_user')));
    currentUser.value.auth = true;
  } else {
    currentUser.value.auth = false;
  }
  currentUser.notifyListeners();
  return currentUser.value;
}

// Future<CreditCard> getCreditCard() async {
//   CreditCard _creditCard = new CreditCard();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey('credit_card')) {
//     _creditCard = CreditCard.fromJSON(json.decode(await prefs.get('credit_card')));
//   }
//   return _creditCard;
// }

Future<User> update(User user) async {
  final String _apiToken = 'api_token=${currentUser.value.apiToken}';
  final String url = 'https://api.rorbible.plus/forgotPass.php?email=';
  final client = new http.Client();
  final response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: json.encode(user.toMap()),
  );
  setCurrentUser(response.body);
  currentUser.value = User.fromJSON(json.decode(response.body)['data']);
  return currentUser.value;
}
