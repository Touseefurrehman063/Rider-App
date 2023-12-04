import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
class LocalDB
{
   static savefingerprint(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('fingerprint', val);
  }
    static saveFaceId(bool val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('faceid', val);
  }

  static getfingerprint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool returnvalue = prefs.getBool('fingerprint') ?? false;
    return returnvalue;
  }

saveDeviceToken(String? token) async {
  
    SharedPreferences s = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    var string = s.setString('devicetoken', token!);
    log('saved in pref $token');
  }
  Future<String> getDeviceToken() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String? token = s.getString('devicetoken') ?? '';
    log('received token $token');
    String receivedToken = token;
    return receivedToken;
  }
}
