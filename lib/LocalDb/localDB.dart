// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:developer';
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

  Future<String?>? getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('token');
    log('the token is $result');
    return result;
  }

  Future<String?>? getBranchId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('BranchId');

    return result;
  }

  Future<String?>? getPatientId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? result = prefs.getString('patientId');
    log('The patient Id is $result');
    return result;
  }

  Future<bool?> getDisclosureDialogueValue() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    bool? value = s.getBool('dialogue');
    log('value got from dialogue $value');
    return value;
  }

  disclosureDialogvalue() async {
    SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool('dialogue', true);
    log('true');
  }
}
