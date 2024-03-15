import 'package:flutter/material.dart';
import 'package:get/get.dart';

class viewinformationcontroller extends GetxController {
  TextEditingController discount = TextEditingController();
  String? dsct;
  updatediscount(string) {
    discount = string;
    update();
  }
}
