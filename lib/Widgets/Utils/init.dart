import 'package:flutter_riderapp/controllers/Auth_Controller/auth_controller.dart';
import 'package:flutter_riderapp/controllers/Notification/dashboardcontroller.dart';
import 'package:flutter_riderapp/controllers/Notification/notification_controller.dart';
import 'package:flutter_riderapp/controllers/edit_patient_controller.dart';
import 'package:flutter_riderapp/controllers/internet_connectivity/connectivity_controller.dart';
import 'package:flutter_riderapp/controllers/memberscontroller.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<familycontroller>(familycontroller());
    Get.put<notificationscontroller>(notificationscontroller());
    Get.put<dashboardcontroller>(dashboardcontroller());
    Get.put<NetworkController>(NetworkController(), permanent: true);
    Get.put<AuthController>(AuthController());

    Get.put<EditPatientController>(EditPatientController());

    ///dashboardcontroller
  }
}
