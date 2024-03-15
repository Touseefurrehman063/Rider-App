// import 'dart:convert';

// import 'package:flutter_riderapp/Models/appointmentdetail.dart';
// import 'package:flutter_riderapp/Models/checkintry.dart';
// import 'package:flutter_riderapp/Utilities.dart';

class ViewInformation {
  // late Future<List<checkintry>> checkin;

  // checkinapi() async {
  //   var url = '$ip/api/Booking/CheckInPatientAppointment';
  //   var header = {
  //     'Content-Type': 'application/json',
  //   };

  //   PatientCheckIn patientcheckinobj =
  //       PatientCheckIn(patientId: widget.user.patientid);
  //   List<PatientCheckIn> lst = [];
  //   lst.add(patientcheckinobj);
  //   lst[0].checkInTypeId = "9cac3d33-e8aa-e711-80c1-a0b3cce147ba";
  //   // ignore: unused_local_variable
  //   PatientCheckIn patientserviceobj =
  //       PatientCheckIn(patientId: widget.user.patientid);

  //   for (apointmentdetail detail in appointments) {
  //     PatientServicelist tempobj = PatientServicelist();
  //     tempobj.subServiceId = detail.subServiceId;
  //     tempobj.charges = detail.price.toString();
  //     tempobj.isAutoNumberGenerationEnabled = false;
  //     tempobj.typeBit = "2";
  //     tempobj.totalCharges = detail.price.toString();
  //     tempobj.subServiceCount = 1;
  //     tempobj.preference = 1;
  //     tempobj.specimenName = "Serum";
  //     tempobj.vatpercentage = detail.vatpercentage;
  //     tempobj.vatamount = detail.vatamount;

  //     if (appointments.contains(detail)) {
  //       lst1.add(tempobj);
  //     }
  //   }

  //   checkintry checkin = checkintry(
  //       patientCheckIn: lst,
  //       userId: widget.empId,
  //       branchLocationIds: widget.user.branchlocationid,
  //       paymentNo: widget.user.LabNo,
  //       patientServicelist: lst1);

  //   final response = await http.post(Uri.parse(url),
  //       headers: header, body: jsonEncode(checkin));
  //   print(checkin);
  //   print("Response: ${response.body}");

  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);
  //     print("Response data: $data");

  //     // Assuming you have a status field in the response indicating ride start success
  //     var status = data["Status"];
  //     dynamic detail = data["Detail"];
  //     if (status != null && status == 1 && detail != null) {
  //       checkinreponselist.add(checkinresponse.fromJson(detail));

  //       ischeckin = true;
  //       debugPrint(response.body);
  //     } else {
  //       ischeckin = false;
  //       debugPrint("Data is null");
  //     }
  //   } else {
  //     throw Exception('Failed to checkin');
  //   }
  // }
}
