// ignore_for_file: prefer_final_fields

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:get/get.dart';



class AuthController extends GetxController implements GetxService {
  File? file;
  late TextEditingController fullname;
  late TextEditingController phone;
  late TextEditingController email;
  late TextEditingController identity;
  late TextEditingController password;
  late TextEditingController retypePassword;
  late TextEditingController street;

  User? user;



  bool _isChecked = false;
  bool get isChecked => _isChecked;

  updateisChecked(bool value) {
    _isChecked = value;
    update();
  }

  bool? _loginStatus = false;
  bool? get loginStatus => _loginStatus;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  updateIsloading(bool value) {
    _isLoading = value;
    update();
  }

  updateLoginStatus(bool value) {
    _loginStatus = value;
    update();
  }

// =======> LoginControllers
  late TextEditingController emailController;
  late TextEditingController passwordController;

// ===========>






  // Login Password Visibility
  bool _isLoginPasswordVisible = false;
  bool get isLoginPasswordVisible => _isLoginPasswordVisible;

  updateisLoginPasswordVisible() {
    _isLoginPasswordVisible = !_isLoginPasswordVisible;
    update();
  }


//===========================> Provinces



  //=========================> Cities

 

  updateFile(File? value) {
    file = value;
    update();
  }

  @override
  void onInit() {
    fullname = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    identity = TextEditingController();
    password = TextEditingController();
    retypePassword = TextEditingController();
    street = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    // selectedGender  = genders![0];
    // log(genders![0].name.toString());

    super.onInit();
  }

  static AuthController get i => Get.put(AuthController());
}
