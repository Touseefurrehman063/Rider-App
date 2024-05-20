import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/languages_Model/languagesmodel.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppConstants {
  static String getLabs = '$ip2/api/labs/GetLabs';

  static String getLabTests = '$ip2/api/labs/GetLabTests';
  static String getPackages =
      '$ip2/api/Appointment/GetPackageGroupServicesDetail';
  static String uploadFile = '$ip2/api/UploadFile';
  static String confirmLabTestPaymentUri =
      '$ip2/api/labs/ConfirmLabTestPayment';
  static String updateLabTests = '$ip/api/account/UpdatePatientAppointment';
  static String getPayments = '$ip2/api/account/GetPaymentMethods';

  static String rescheduleLabTest = '$ip2/api/labs/RescheduleLabTest';
  static const int maximumDataTobeFetched = 25;
  static const String maximumDataTobeFetched2 = "25";

  String contact = "";
  static List<LanguageModel> languages = [
    LanguageModel(name: 'English', id: 1, locale: const Locale('en', 'US')),
    LanguageModel(name: 'عربي'.tr, id: 2, locale: const Locale('ar', 'SA')),
    LanguageModel(name: 'اردو'.tr, id: 3, locale: const Locale('ur', 'PK')),
  ];
}

DateTime? toDateTime(dynamic dateValue) {
  if (dateValue is DateTime) {
    return dateValue;
  } else if (dateValue is String) {
    DateTime date = DateTime.parse(dateValue);
    String dateFormat = DateFormat('yyyy-MM-dd').format(date);
    return DateTime.parse(dateFormat);
  } else {
    return null;
  }
}
