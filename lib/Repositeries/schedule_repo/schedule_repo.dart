import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riderapp/AppConstants.dart';
import 'package:flutter_riderapp/LocalDb/localDB.dart';
import 'package:flutter_riderapp/Widgets/Utils/toast+manager.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class ScheduleRepo {
  rescheduleLabAppointment(
      {String? labNO,
      BuildContext? context,
      String? formatteddt,
      DateTime? date,
      String? time,
      String? labID,
      String? packageGroupId,
      String? packageGroupName,
      String? packageGroupDiscountRate,
      String? packageGroupDiscountType}) async {
    var branchId = await LocalDb().getBranchId();
    var token = await LocalDb().getToken();
    var patientId = await LocalDb().getPatientId();
    // ScheduleController.i.updateIsLoading(true);
    String? formatteddate =
        DateFormat('yyyy-MM-dd').format(date ?? DateTime.now());
    var body = {
      "LabTestChallanNo": "$labNO",
      "PatientId": "$patientId",
      "Date": formatteddt ?? formatteddate,
      "Time": "$time",
      "LabId": "$labID",
      "Token": "$token",
      "BranchId": branchId,
      "PackageGroupId": "$packageGroupId",
      "PackageGroupName": "$packageGroupName",
      "PackageGroupDiscountRate": "$packageGroupDiscountRate",
      "PackageGroupDiscountType": "$packageGroupDiscountType"
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.rescheduleLabTest),
          headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          ToastManager.showToast('${result['ErrorMessage']}',
              bgColor: Colors.green);
          // await ScheduleController.i.clearData();
          // ScheduleController.i.getAppointmentsSummery();
          // await ScheduleController.i.getUpcomingAppointment('', true);
          // await ScheduleController.i.getAppointmentsList("");
          // ScheduleController.i.updateIsLoading(false);
        } else {
          ToastManager.showToast('${result['ErrorMessage']}',
              bgColor: ColorManager.kRedColor);
          // ScheduleController.i.updateIsLoading(false);
        }
      }
    } catch (e) {
      // ToastManager.showToast(e.toString(),
      //     bgColor: ColorManager.kRedColor, textColor: ColorManager.kWhiteColor);
      // ScheduleController.i.updateIsLoading(false);
    }
  }
}
