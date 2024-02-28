import 'package:get/get.dart';

// ignore: camel_case_types
class dashboardcontroller extends GetxController {
  int index = 1;
  static dashboardcontroller get j => Get.put(dashboardcontroller());

  updatenotification(noti) {
    index = noti;
    update();
  }
}
