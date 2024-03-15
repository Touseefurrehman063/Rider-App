import 'package:flutter_riderapp/Models/Notification_Model/notification_model.dart';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Repositeries/Notificationrepo/notification_repo.dart';
import 'package:flutter_riderapp/Screen/Appointments_Screen/_appointments_history.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:get/get.dart';

class notificationscontroller extends GetxController {
  User? user;
  List<RiderNotifications> notifications = [];
  static notificationscontroller get j => Get.put(notificationscontroller());

  updatenotification(List<RiderNotifications> noti) {
    notifications = noti;
    update();
  }

  // getnotifications() async {
  //   try {
  //     isLoadinfnotification = true;
  //     notifications = await NotificationRepository().getnotifications(
  //         user?.empId ?? "",
  //         NotificationRepository().formatLastMonthDate().toString(),
  //         formatDate(DateTime.now().add(const Duration(days: 1))),
  //         100,
  //         0);
  //     isLoadinfnotification = false;
  //   } catch (e) {
  //     isLoadinfnotification = false;
  //   }
  //   isLoadinfnotification = false;
  // }

  bool isLoadinfnotification = false;
  void setIsLoadingNotification(bool isLoading) {
    isLoadinfnotification = isLoading;
    update();
  }
}
