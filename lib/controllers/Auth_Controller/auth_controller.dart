// ignore_for_file: prefer_final_fields

import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Models/user_data_model.dart/userdata_model.dart';
import 'package:flutter_riderapp/Widgets/Utils/toast+manager.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:new_version_plus/new_version_plus.dart';

class AuthController extends GetxController implements GetxService {
  UserDataModel? patient;
  File? file;
  late TextEditingController fullname;
  late TextEditingController phone;
  late TextEditingController email;
  late TextEditingController identity;
  late TextEditingController password;
  late TextEditingController retypePassword;
  late TextEditingController street;
  static DateTime? arrival;

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

  Future<File?> pickImage(
      {bool allowMultiple = false,
      BuildContext? context,
      FileType? type = FileType.any}) async {
    File? pickedFile;
    try {
      FilePickerResult? result = await FilePicker.platform
          .pickFiles(allowMultiple: allowMultiple, type: type ?? FileType.any);
      if (result != null) {
        pickedFile = File(result.files.first.path!);
        // log('${result.files.first.path} the picked file is');
      }
    } catch (e) {
      if (e is SocketException) {
        ToastManager.showToast('No Internet Connection',
            bgColor: ColorManager.kRedColor);
      } else if (e is TimeoutException) {
        ToastManager.showToast('Request Time Out',
            bgColor: ColorManager.kRedColor);
      } else {
        ToastManager.showToast('An Unknown Error Occured');
      }
    }
    update();
    return pickedFile;
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

  String appVersion = "";
  updateAppVersion(version) {
    appVersion = version;
  }

  void getAppVersion() async {
    NewVersionPlus newVersion = NewVersionPlus();
    final status = await newVersion.getVersionStatus();
    appVersion = status!.storeVersion;
  }

  RxString? formatArrival;
  Future<void> selectDateAndTime({
    bool isRegisterScreen = false,
    bool isFamilyScreen = false,
    BuildContext? context,
    DateTime? date,
    RxString? formattedDate,
  }) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context!,
        confirmText: 'Ok',
        initialDate: date ?? DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != date) {
      date = pickedDate;
      if (isRegisterScreen == true) {
        AuthController.arrival = date;
      }

      AuthController.i.formatArrival =
          DateFormat('dd-MM-yyyy').format(date).obs;
      formattedDate!.value = DateFormat('dd-MM-yyyy').format(date);

      update();
    }
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
    getAppVersion();
    // selectedGender  = genders![0];
    // log(genders![0].name.toString());

    super.onInit();
  }

  static AuthController get i => Get.put(AuthController());
}
