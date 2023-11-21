
import 'dart:convert';


import 'package:flutter_riderapp/Models/userprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import "../Models/User.dart";


import 'package:flutter_riderapp/Utilities.dart';

// ignore: unused_import
import 'package:http/http.dart' as http;

bool isGender=false;
bool Vehicletype=false;
  User rlist =User();
  Future<User> getprofile() async {

    String url = '$ip/api/account';
    Uri uri = Uri.parse(url);
    var response = await http.post(uri);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      
      Map<String, dynamic> map = data;
      rlist=(User.fromJson(map));
      return rlist;
    } else {
      return rlist;
    }
  }


   
Future<Map<String, dynamic>> login(String userName, String password) async {
  var url = '$ip/api/account';
  var headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    'username': userName,
    'password': password,
  });

  var response = await http.post(Uri.parse(url), headers: headers, body: body);

  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);
    var status = responseData['Status'];

    userprofile= userProfile.fromJson(responseData);

      print('API Response: $responseData'); 


    if (status != -5) {
      var empId = responseData['Id'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      prefs.setString('userId', empId);
      

      return {'isLoggedIn': true, 'empId': empId};
    } else if (status == -5) {
      return {'isLoggedIn': false, 'empId': null};
    }
  }

  return {'isLoggedIn': false, 'empId': null};
}


 

  






