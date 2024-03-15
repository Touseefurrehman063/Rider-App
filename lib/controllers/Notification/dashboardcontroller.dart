import 'package:get/get.dart';
 

class dashboardcontroller extends GetxController
{
  int index = 1;
   static dashboardcontroller get j =>
      Get.put(dashboardcontroller());
      
updatenotification(noti){
  index=noti;
  update();
}
}