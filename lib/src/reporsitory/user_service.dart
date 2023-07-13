// import 'media.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'package:xman/src/reporsitory/user_reporsitory.dart';
import 'package:http/http.dart' as http;


class UserService {
 

 int totalcoin = 500;



Future loadScore() async {
  // String token;
  // token = user.apiToken;
   UserService user = new UserService();

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
    print('==paakow');
    print(response.body);
    
    currentUser = json.decode(response.body)['data'];
    print(currentUser);

  }
  
}


}
