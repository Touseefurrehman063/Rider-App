import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
class LocalDB
{
saveDeviceToken(String? token) async {
    SharedPreferences s = await SharedPreferences.getInstance();
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
