
import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Models/appointmentdetail.dart';
import 'package:flutter_riderapp/Models/checkinresponse.dart';
import 'package:flutter_riderapp/Models/checkintry.dart' as chkintry;
import 'package:flutter_riderapp/Models/checkintry.dart';
import 'package:flutter_riderapp/Models/labtest.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/Models/userprofile.dart';
import 'package:flutter_riderapp/controllers/memberscontroller.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

bool isGender=false;
bool Vehicletype=false;
  User rlist =User();
  Future<User> getprofile() async {

    String url = '$ip/api/account';
    Uri uri = Uri.parse(url);
    var response = await http.post(uri);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      
      Map<String, dynamic> map = data;
      rlist=(User.fromJson(map));
      return rlist;
    } else {
      return rlist;
    }
  }

 getlabtest() async {
  
    var bdody={
      "LabId":"","Token":"44717866-70BA-4223-8F97-45286B2FD599"
    };
    String url = '$ip/api/labs/GetLabTests';
    Uri uri = Uri.parse(url);
    try{
var response = await http.post(uri,body: bdody);
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      
      Iterable labtests= data['Data'];
     List<Labtest> labtest= labtests.map((e) => Labtest.fromJson(e)).toList();
   return labtest;
    } else {
      return [];
    }

    }catch (e)
    {
      return [];
    }
    
  }


   
Future<Map<String, dynamic>> login(String userName, String password) async {
  var url = '$ip/api/account';
  var headers = {
    'Content-Type': 'application/json',
  };
  var body = jsonEncode({
    'username': userName,
    'password': password,
  });

  var response = await http.post(Uri.parse(url), headers: headers, body: body);

  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);
    var status = responseData['Status'];

    userprofile= userProfile.fromJson(responseData);

      print('API Response: $responseData'); 


    if (status != -5) {
      var empId = responseData['Id'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('isLoggedIn', true);
      prefs.setString('userId', empId);
      

      return {'isLoggedIn': true, 'empId': empId};
    } else if (status == -5) {
      return {'isLoggedIn': false, 'empId': null};
    }
  }

  return {'isLoggedIn': false, 'empId': null};
}


 appointmentserviceapi(String branchid,String userid, String patientid, String labno,) async {
    final url = '$ip/api/account/GetAppointmentServicesDetail';
    final headers = {'Content-Type': 'application/json'};

    var requestBody = {
      "BranchLocationId": branchid,
      "UserId": userid,
      "PatientId":patientid,
      "AppointmentNo":labno
    };
      List<apointmentdetail> appointments = [];
    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Iterable list = data["Data"];
        if (data['Status'] != null &&
            data['Status'] == 1 &&
            data['Data'] != null) {
         familycontroller.i. appointments = list.map((e) => apointmentdetail.fromJson(e)).toList();
          print(appointments);
         
         
 
        }
      } else {
        throw Exception('Failed to fetch data from the server.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  checkinapi(String labno, String branchlocationid) async {
    var url = '$ip/api/Booking/CheckInPatientAppointment';
    var header = {
      'Content-Type': 'application/json',
    };

   chkintry. PatientCheckIn patientcheckinobj =
      chkintry.  PatientCheckIn(patientId: userprofile?.id??"");
    List<chkintry.PatientCheckIn> lst = [];
    lst.add(patientcheckinobj);
    lst[0].checkInTypeId = "9cac3d33-e8aa-e711-80c1-a0b3cce147ba";
    // ignore: unused_local_variable
      chkintry.PatientServicelist tempobj = chkintry.PatientServicelist();
  //  chkintry. PatientCheckIn patientserviceobj =
  //      chkintry. PatientCheckIn(patientId: userprofile?.id??"");

  for (apointmentdetail detail in familycontroller.i.appointments) {
      chkintry.PatientServicelist tempobj = chkintry.PatientServicelist();
      tempobj.subServiceId = detail.subServiceId;
      tempobj.charges = detail.price.toString();
      tempobj.isAutoNumberGenerationEnabled = false;
      tempobj.typeBit = "2";
      tempobj.totalCharges = detail.price.toString();
      tempobj.subServiceCount = 1;
      tempobj.preference = 1;
      tempobj.specimenName = "Serum";
      tempobj.vatpercentage = detail.vatpercentage;
      tempobj.vatamount = detail.vatamount;

      if (familycontroller.i.appointments.contains(detail)) {
        familycontroller.i.lst1.add(tempobj);
      }
    }

    checkintry checkin = checkintry(
        patientCheckIn: lst,
        userId: userprofile?.id??"",
        branchLocationIds: branchlocationid,
        paymentNo:labno,
        patientServicelist: familycontroller.i.lst1);

    final response = await http.post(Uri.parse(url),
        headers: header, body: jsonEncode(checkin));
    print(checkin);
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Response data: $data");

      // Assuming you have a status field in the response indicating ride start success
      var status = data["Status"];
      dynamic detail = data["Detail"];
      if (status != null && status == 1 && detail != null) {
   
       familycontroller.i.checkinreponselist.add(checkinresponse.fromJson(detail));
log(familycontroller.i.checkinreponselist.toString());
      } else {
      }
    } else {
      throw Exception('Failed to checkin');
    }
  }

 

  






