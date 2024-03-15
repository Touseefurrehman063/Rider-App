import 'package:flutter_riderapp/Models/appointmentdetail.dart';
import 'package:flutter_riderapp/Models/checkinresponse.dart';
import 'package:flutter_riderapp/Models/checkintry.dart';

import 'package:get/get.dart';

class familycontroller extends GetxController{

static familycontroller get i => Get.put(familycontroller());

     List<checkinresponse> checkinreponselist = [];
List<PatientServicelist> lst1 = [];
List<apointmentdetail> appointments=[];

}