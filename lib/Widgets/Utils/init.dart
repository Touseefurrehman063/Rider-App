import 'package:flutter_riderapp/controllers/Notification/notification_controller.dart';
import 'package:get/get.dart';


class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<notificationscontroller>(notificationscontroller());
   
  }
}
