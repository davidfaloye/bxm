import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
// import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
// import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import '../models/setting.dart';

// ValueNotifier<Setting> setting = new ValueNotifier(new Setting());
// LocationData locationData;

// Future<Setting> initSettings() async {
//   Setting _setting;
//   final String url = '${GlobalConfiguration().getString('api_base_url')}settings';
//   final response = await http.get(url, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
//   if (response.statusCode == 200 && response.headers.containsValue('application/json')) {
//     if (json.decode(response.body)['data'] != null) {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setString('settings', json.encode(json.decode(response.body)['data']));
//       _setting = Setting.fromJSON(json.decode(response.body)['data']);
//       if (prefs.containsKey('language')) {
//         _setting.mobileLanguage = new ValueNotifier(Locale(prefs.get('language'), ''));
//       }
//       setting.value = _setting;
//       setting.notifyListeners();
//     }
//   }
//   print("initSettings");
//   return setting.value;
// }

// Future<LocationData> setCurrentLocation() async {
//   var location = new Location();
//   location.requestService().then((value) async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();
//       locationData = await location.getLocation();
//       await prefs.setDouble('currentLat', locationData.latitude);
//       await prefs.setDouble('currentLon', locationData.longitude);
//     } on PlatformException catch (e) {
//       if (e.code == 'PERMISSION_DENIED') {
//         print('Permission denied');
//       }
//     }
//   });
//   return locationData;
// }

// Future<LocationData> getCurrentLocation() async {
//   print("getCurrentLocation");
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   if (prefs.containsKey('currentLat') && prefs.containsKey('currentLon')) {
//     locationData = LocationData.fromMap({"latitude": prefs.getDouble('currentLat'), "longitude": prefs.getDouble('currentLon')});
//   } else {
//     setCurrentLocation().then((value) {
//       if (prefs.containsKey('currentLat') && prefs.containsKey('currentLon')) {
//         locationData = LocationData.fromMap({"latitude": prefs.getDouble('currentLat'), "longitude": prefs.getDouble('currentLon')});
//       }
//     });
//   }
//   return locationData;
// }

void setBrightness(Brightness brightness) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  brightness == Brightness.dark ? prefs.setBool("isDark", true) : prefs.setBool("isDark", false);
}

Future<void> setDefaultLanguage(String language) async {
  if (language != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }
}

Future<String> getDefaultLanguage(String defaultLanguage) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('language')) {
    defaultLanguage = await prefs.get('language');
  }
  return defaultLanguage;
}
