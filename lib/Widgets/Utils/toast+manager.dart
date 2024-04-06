import 'package:flutter/material.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastManager {
  static void showToast(String message, {Color? bgColor, Color? textColor}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.SNACKBAR,
      timeInSecForIosWeb: 1,
      backgroundColor: bgColor ?? ColorManager.kblackColor,
      textColor: textColor ?? ColorManager.kWhiteColor,
      fontSize: 16.0,
    );
  }
}
