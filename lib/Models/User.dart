


import 'package:http/http.dart' as http;

class User{
  dynamic UserName;
  dynamic Password;

  dynamic empId;
  dynamic start;
  dynamic StartDate;
  dynamic EndDate;
  dynamic patientName;
  dynamic test;
  dynamic address;
  dynamic status;
  dynamic patientid;
  dynamic message;
  dynamic ride_CancelRemarks;
  dynamic appointmentno;
  dynamic branchlocationid;
  dynamic Patientappoinmentid;
  dynamic LabNo;
  dynamic url;
  dynamic imagePath;
  dynamic cNICNumber;
  dynamic latitude;
  dynamic longitude;
  dynamic vehicleno;
  dynamic dob;
  dynamic cellNumber;
  dynamic token;
   dynamic labTestChallanNo;
   dynamic time;
   dynamic Labid;
   dynamic inroutelat;
   dynamic inroutelon;
   dynamic paymentstatusname;
   dynamic paymentstatusvalue;
  dynamic visitno;

User(
  {
    this.UserName,
this.Password,
this.empId,
this.start,
this.visitno,
this.StartDate,
this.Labid,
this.patientName,
this.test,
this.EndDate,
this.address,
this.status,
this.patientid,
this.message,
this.ride_CancelRemarks,
this.appointmentno,
this.branchlocationid,
this.Patientappoinmentid,
this.LabNo,
this.url,
this.imagePath,
this.cNICNumber,
this.latitude,
this.longitude,
this.vehicleno,
this.dob,
this.cellNumber,
this.token,
 this.labTestChallanNo,
 this.time,
 this.inroutelat,
 this.inroutelon,
 this.paymentstatusname,
 this.paymentstatusvalue
  }
);
User.fromJson(Map<String,dynamic> json){
  UserName =json["UserName"];
  Password=json["Password"];
   empId=json["UserId"];
   Labid=json["LabId"];
   visitno=json['VisitNo'];
   StartDate=json["BookingDate"];
   start=json["start"];
   EndDate=json["EndDate"];
   patientName=json["PatientName"];
   test=json["LabTest"];
   address=json["PickupAddress"];
   status=json["Status"];
   patientid=json["PatientId"];
   message=json["Message"];
   ride_CancelRemarks=json["RideCancelRemarks"];
   appointmentno=json["AppointmentNo"];
   branchlocationid=json["BranchLocationId"];
   Patientappoinmentid=json["PatientAppointmentId"];
   LabNo=json["LabNo"];
   url=json["RiderLocationURL"];
   imagePath=json["ImagePath"];
   cNICNumber = json["CNICNumber"];
   latitude= json["Latitude"];
   longitude=json["Longitude"];
   vehicleno=json["VehicleNumber"];
   dob=json["DateofBirth"];
   cellNumber=json["CellNumber"];
   token=json["Token"];
    labTestChallanNo = json['LabTestChallanNo'];
    time=json['Time'];
    inroutelat=json['InRouteLatitude'];
    inroutelon=json['InRouteLongitude'];
    paymentstatusname=json['PaymentStatusName'];
    paymentstatusvalue=json['PaymentStatusValue'];


}
Map<String, dynamic> toJson(http.Response response){
  final Map<String,dynamic> data=<String,dynamic>{};
  data['UserName']=UserName;
  data['Password']=Password;
  data['UserId']=empId;
  data['start']=start;
  data['BookingDate']=StartDate;
  data['EndDate']=EndDate;
  data['PatientName']=patientName;
  data['LabTest']=test;
  data['PickupAddress']=address;
  data['Status']=status;
  data['VisitNo']=visitno;
  data['PatientId']=patientid;
  data['Message']=message;
  data['RideCancelRemarks']=ride_CancelRemarks;
  data['AppointmentNo']=appointmentno;
  data['BranchLocationId']=branchlocationid;
  data['PatientAppointmentId']=Patientappoinmentid;
  data['LabNo']=LabNo;
  data['LabId']=Labid;
  data['RiderLocationURL']=url;
  data['ImagePath']=imagePath;
  data['CNICNumber'] = cNICNumber;
  data['Latitude']=latitude;
  data['Longitude']=longitude;
  data['VehicleNumber']=vehicleno;
  data['DateofBirth']=dob;
  data['CellNumber']=cellNumber;
  data['Token']=token;
   data['LabTestChallanNo'] = this.labTestChallanNo;
   data['Time']=this.time;
   data['InRouteLatitude']=this.inroutelat;
   data['InRouteLongitude']=this.inroutelon;
   data['PaymentStatusName']=this.paymentstatusname;
   data['PaymentStatusValue']=this.paymentstatusvalue;



  return data;
}
}
