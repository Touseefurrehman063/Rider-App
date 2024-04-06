import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/Notification_Model/notification_model.dart';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Repositeries/Notificationrepo/notification_repo.dart';
import 'package:flutter_riderapp/Screen/Appointments_Screen/_appointments_history.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/controllers/Notification/notification_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// Import intl for date formatting

class CustomNotification extends StatefulWidget {
  const CustomNotification({Key? key}) : super(key: key);

  @override
  State<CustomNotification> createState() => _CustomNotificationState();
}

class _CustomNotificationState extends State<CustomNotification> {
  User? user;
  String endDate = "";
  String startDate = "";
  int start = 0;
  int length = 10;
  @override
  void initState() {
    didChangeDependencies(_)
    {
      today=0;
      yesterday=0;
      before=0;
    }
    log(DateTime.now().toString());
    super.initState();
  }

  String formatLastMonthDate() {
    final now = DateTime.now();
    final lastMonth = DateTime(now.year, now.month - 5, now.day);

    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(lastMonth);
  }

  Future<void> _refreshNotifications() async {
    await NotificationRepository().getnotifications(
      userprofile!.id.toString(),
      formatLastMonthDate().toString(),
      formatDate(DateTime.now()).toString(),
      length,
      start,
    );
  }

  @override
  void dispose() {
  today=0;
      yesterday=0;
      before=0;
    // TODO: implement dispose
    super.dispose();
  }
  DateTime t1=DateTime.now().subtract(const Duration(days:1));

int today=0;
int yesterday=0;
int before=0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<notificationscontroller>(builder: (cont) {
      return Column(
        children: [
          RefreshIndicator(
            onRefresh: _refreshNotifications,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: notificationscontroller.j.notifications.length,
              itemBuilder: (context, index) {
                final data = notificationscontroller.j.notifications[index];
                
              
                if(DateTime.now().toString().split(' ')[0]==data.dateTime.toString().split('T')[0] && today==0)
                {
                  today+=1;
                  return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         const Text("Today"),
                          customListTile(context, data),
                        ],
                      ));
                }
                else if(t1.isBefore(DateTime.now()) && yesterday==0)
                {
                  yesterday+=1;
                  return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           const Text("Yesterday"),
                          customListTile(context, data),
                        ],
                      ));
                }
               
               
                else
                {
                   return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          customListTile(context, data),
                        ],
                      ));
                }
               




                // } else if (DateTime.now().toString().split(' ')[0] !=
                //         data.dateTime.toString().split('T')[0] &&
                //     chk2) {
                //       chk2=false;
                //   return Padding(
                //       padding: const EdgeInsets.only(top: 10),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           "${DateTime.now().toString().split(' ')[0].split('-')[0]}-${int.parse(DateTime.now().toString().split(' ')[0].split('-')[2]) - 1}${DateTime.now().toString().split(' ')[0].split('-')[2]}" ==
                //                   data.dateTime.toString().split('T')[0]
                //               ? const Padding(
                //                   padding: EdgeInsets.only(left: 8.0),
                //                   child: Text("Yesterday"),
                //                 )
                //               :  const SizedBox.shrink(),
                //           customListTile(context, data),
                //         ],
                //       ));
                // } else if (DateTime.now().toString().split(' ')[0] !=
                //         data.dateTime.toString().split('T')[0] &&
                //     chk2) {
                //   return Padding(
                //       padding: const EdgeInsets.only(top: 10),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           DateTime.now().toString().split(' ')[0] ==
                //                   data.dateTime.toString().split('T')[0]
                //               ? const Padding(
                //                   padding: EdgeInsets.only(left: 8.0),
                //                   child: Text("Yesterday"),
                //                 )
                //               : const SizedBox.shrink(),
                //           customListTile(context, data),
                //         ],
                //       ));
                // }
                // else{
                //    return Padding(
                //       padding: const EdgeInsets.only(top: 10),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                         
                //           customListTile(context, data),
                //         ],
                //       ));
                // }
              }

            ),
          ),
        ],
      );
    });
  }

  customListTile(BuildContext context, RiderNotifications data) {
    return Card(
      child: ListTile(
        minVerticalPadding: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        tileColor: Colors.transparent,
        title: Text(
          data.title.toString(),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
        ),
        subtitle: Text(
          "${data.body!.split(" at ").first}\n${calculateTimeAgo(data.dateTime)}",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
                fontSize: 10,
              ),
        ),
      ),
    );
  }

  String calculateTimeAgo(String? dateTimeString) {
    if (dateTimeString == null) {
      return 'Unknown Date';
    }

    final dateTime = DateTime.parse(dateTimeString);
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    final years = difference.inDays ~/ 365;
    final months = (difference.inDays % 365) ~/ 30;
    final days = (difference.inDays % 365) % 30;
    final hours = difference.inHours % 24;
    final minutes = difference.inMinutes % 60;

    String timeAgo = '';
    if (years > 0) {
      timeAgo = '$years year${years > 1 ? 's' : ''}';
    } else if (months > 0) {
      timeAgo = '$months month${months > 1 ? 's' : ''}';
    } else if (days > 0) {
      timeAgo = '$days day${days > 1 ? 's' : ''}';
    } else if (hours > 0) {
      timeAgo = '$hours hour${hours > 1 ? 's' : ''}';
    } else if (minutes > 0) {
      timeAgo = '$minutes minute${minutes > 1 ? 's' : ''}';
    } else {
      timeAgo = 'Just now';
    }

    return '$timeAgo ago';
  }
}
