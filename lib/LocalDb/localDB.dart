// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter_riderapp/Models/languages_Model/languagesmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDb {
  setLanguage(LanguageModel? language) async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setString('language', jsonEncode(language));
  }

  Future<LanguageModel?> getLanguage() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    String? data = s.getString("language");
    LanguageModel? lang;
    if (data != null) {
      lang = LanguageModel.fromJson(jsonDecode(data));
    } else {
      lang = null;
    }
    return lang;
  }
}
