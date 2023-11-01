import 'dart:convert';

import 'package:flutter_riderapp/Models/Notification_Model/notification_model.dart';
import 'package:flutter_riderapp/Repositeries/localdb.dart';
import 'package:flutter_riderapp/Screen/Appointments_Screen/_appointments_history.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/controllers/Notification/notification_controller.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class NotificationRepository{
  int TotalRecordsData = 0;
  bool isLoadingData = false;
  bool isLoadingmoreData = false;

 String formatLastMonthDate() {
  final now = DateTime.now();
  final lastMonth = DateTime(now.year, now.month - 1, now.day);

  final formatter = DateFormat('yyyy-MM-dd');
  return formatter.format(lastMonth);
}

  

  
getnotifications(String empId, String StartDate,
      String EndDate, int length, int start) async {
  
    var url = '$ip/api/account/GetUserNotifications';
    var headers = {
      'Content-Type': 'application/json',
    };
String? DeviceToken = await LocalDB().getDeviceToken();
    var requestBody = {
      'UserId': userprofile!.id,
      'BranchId':userprofile?.branchId,
      'FromDate': formatLastMonthDate().toString(),
      'ToDate': formatDate(DateTime.now()),
      'length': 6,
      'start': 0,
      'Search':'',
      'OrderDir':"desc",
      'OrderColumn':0,
      'Token':DeviceToken,
    };
    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(requestBody));
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        print("Response data: $data");
        List<RiderNotifications> ulist = [];
        if (data['TotalRecord'] != null) {
          TotalRecordsData = data['TotalRecord'].toInt();
        }
        if (data != null) {
          Iterable decode = data["data"];
          ulist = decode.map((e) => RiderNotifications.fromJson(e)).toList();
       
        //  notificationscontroller.j.notifications.clear();
        
         
            notificationscontroller.j.updatenotification(ulist);
           
                }
        print(ulist);

        isLoadingData = false;
        isLoadingmoreData = false;
       
      } catch (e) {
        isLoadingData = false;
        isLoadingmoreData = false;
      
        throw Exception('Failed to load appointments');
      }
    } else {
      isLoadingData = false;
      isLoadingmoreData = false;
     
      throw Exception('Failed to load appointments');
    }
  }

}