import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/languages_Model/languagesmodel.dart';
import 'package:get/get.dart';

class AppConstants {
  static const int maximumDataTobeFetched = 25;
  static List<LanguageModel> languages = [
    LanguageModel(name: 'English', id: 1, locale: const Locale('en', 'US')),
    LanguageModel(name: 'عربي'.tr, id: 2, locale: const Locale('ar', 'SA')),
     LanguageModel(name: 'اردو'.tr, id: 2, locale: const Locale('ar', 'Ur')),
  ];
}