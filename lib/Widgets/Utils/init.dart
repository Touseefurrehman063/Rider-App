import 'package:flutter_riderapp/controllers/Notification/dashboardcontroller.dart';
import 'package:flutter_riderapp/controllers/Notification/notification_controller.dart';
import 'package:flutter_riderapp/controllers/memberscontroller.dart';
import 'package:get/get.dart';


class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<familycontroller>(familycontroller());
    Get.put<notificationscontroller>(notificationscontroller());
    Get.put<dashboardcontroller>(dashboardcontroller());
   ///dashboardcontroller
  }
}
