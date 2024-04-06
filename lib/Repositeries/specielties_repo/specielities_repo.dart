import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/AppConstants.dart';
import 'package:flutter_riderapp/LocalDb/localDB.dart';
import 'package:flutter_riderapp/Models/payment_response/payment_response.dart';
import 'package:flutter_riderapp/Widgets/Utils/toast+manager.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../components/success_or_failed.dart';

class SpecialitiesRepo {
  static getPaymentMethods() async {
    var branchID = await LocalDb().getBranchId();
    var token = await LocalDb().getToken();
    var body = {
      "IsMobile": "true",
      "BranchId": branchID,
      "IsWeb": "true",
      "IsHIMS": "false",
      "Token": "$token"
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getPayments),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          PaymentResponse payments = PaymentResponse.fromJson(result);
          return payments.data;
        } else {
          ToastManager.showToast('${result['Data']}');
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
