// import 'media.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';

class User {
  String id;
  String firstName;
  String lastName;
  String email;
  String country;
  String password;
  String password2;
  String apiToken;
  String deviceType;
  String deviceToken;
  String phone;
  String address;
  String bio;
  int coin;
  int diamond;
  int swap;
  int f5050;
  int askAudience;
  int lifeCoach;
  int leafFaith;
  int squadronPack;
  int faithPack;
  int victoryBox;

  // Media image;

  // used for indicate if client logged in or not
  bool auth;

//  String role;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
ValueNotifier<User> currentUser = new ValueNotifier(User()); 

    id = jsonMap['id'].toString();
    firstName = jsonMap['first_name'];
    lastName = jsonMap['last_name'];
    email = jsonMap['email'];
    apiToken = jsonMap['api_token'];
    deviceToken = jsonMap['device_token'];
    coin = jsonMap['coin'];
    try {
      phone = jsonMap['custom_fields']['phone']['view'];
    } catch (e) {
      phone = "";
    }
    try {
      address = jsonMap['custom_fields']['address']['view'];
    } catch (e) {
      address = "";
    }
    try {
      bio = jsonMap['custom_fields']['bio']['view'];
    } catch (e) {
      bio = "";
    }
    // image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0
    //     ? Media.fromJSON(jsonMap['media'][0])
    //     : new Media();
  }
  


  User.fromScore(Map<String, dynamic> jsonMap) {
    coin = jsonMap['coin'];
    diamond = jsonMap['diamond'];
    swap = jsonMap['swap'];
    f5050 = jsonMap['f5050'];
    lifeCoach = jsonMap['lifeCoach'];
    leafFaith = jsonMap['leafFaith'];
    squadronPack = jsonMap['squadronPack'];
    faithPack = jsonMap['faithPack'];
    victoryBox = jsonMap['victoryPack'];

  }

    User.getScore(Map<String, dynamic> jsonMap) {
     jsonMap['coin'] = coin ;
     jsonMap['diamond'] = diamond ;
   jsonMap['swap'] = swap;
     jsonMap['f5050'] = f5050;
     jsonMap['lifeCoach'] = lifeCoach;
    jsonMap['leafFaith'] = leafFaith;
    jsonMap['squadronPack'] = squadronPack;
    jsonMap['faithPack'] = faithPack;
    jsonMap['victoryPack'] = victoryBox;

  }


  Map toMap() {
    var map = new Map<String, dynamic>();
    map["email"] = email;
    map["first_name"] = firstName;
    map["last_name"] = lastName;
    map["phone"] = phone;
    map["password"] = password;
    map["password2"] = password2;
    map["deviceType"] = deviceType;
    if (deviceToken != null) {
      map["deviceToken"] = deviceToken;
    }
    map["country"] = country;
    return map;
  }

  Map scoresToMap() {
    var map = new Map<String, dynamic>();
    map["coin"] = coin;
    map["diamond"] = diamond;
    map["tools"] = [
      {"id": "1", "qty": swap},
      {"id": "3", "qty": askAudience},
      {"id": "3", "qty": lifeCoach},
      {"id": "4", "qty": f5050}
    ];
    map["packages"] = [
      {"id": "1", "qty": victoryBox},
      {"id": "3", "qty": leafFaith},
      {"id": "3", "qty": squadronPack},
      {"id": "4", "qty": faithPack}
    ];

    return map;
  }

  Map questToMap() {
    var map = new Map<String, dynamic>();
    map["device"] = deviceToken;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }
}
