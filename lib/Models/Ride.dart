
import 'package:http/http.dart' as http;

class Ride{
  String? status;
   String? message;
   String? PatientId;
   String? UserId;
   double? RiderLatitude;
   double? RiderLongitude;

Ride(
  {
  
this.status,
this.PatientId,
this.RiderLatitude,
this.RiderLongitude,
this.UserId,
this.message,

  }
);
Ride.fromJson(Map<String,dynamic> json){
  
   status=json["Status"];
   
   message=json["Message"];
   PatientId=json["PatientId"];
   RiderLatitude=json["RiderLatitude"];
  RiderLongitude=json["RiderLongitude"];
  UserId=json["UserId"];


}
Map<String, dynamic> toJson(http.Response response){
  final Map<String,dynamic> data=<String,dynamic>{};
 
  data['Status']=status;
 data['PatientId']=PatientId;
 data['RiderLatitude']=RiderLatitude;
  data['RiderLongitude']=RiderLongitude;
   data['UserId']=UserId;
   data['Message']=message;




  return data;
}
}
