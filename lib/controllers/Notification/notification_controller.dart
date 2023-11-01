import 'package:flutter_riderapp/Models/Notification_Model/notification_model.dart';
import 'package:get/get.dart';
 

class notificationscontroller extends GetxController
{
  List<RiderNotifications> notifications = [];
   static notificationscontroller get j =>
      Get.put(notificationscontroller());
      
updatenotification(List<RiderNotifications> noti){
  notifications=noti;
  update();
}
}