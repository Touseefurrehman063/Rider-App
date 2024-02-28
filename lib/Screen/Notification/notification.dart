// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Repositeries/Notificationrepo/notification_repo.dart';
import 'package:flutter_riderapp/Screen/Appointments_Screen/_appointments_history.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/Widgets/custom_notification.dart';
import 'package:flutter_riderapp/controllers/Notification/dashboardcontroller.dart';
import 'package:flutter_riderapp/controllers/Notification/notification_controller.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class notification extends StatefulWidget {
  const notification({Key? key}) : super(key: key);

  @override
  _notificationState createState() => _notificationState();
}

class _notificationState extends State<notification> {
  User? user;
  String endDate = "";
  String startDate = "";
  int start = 0;
  int length = 10;

  @override
  void initState() {
    super.initState();
    NotificationRepository().getnotifications(
      userprofile!.id.toString(),
      formatLastMonthDate().toString(),
      formatDate(DateTime.now()).toString(),
      length,
      start,
    );
  }

  String formatLastMonthDate() {
    final now = DateTime.now();
    final lastMonth = DateTime(now.year, now.month - 5, now.day);

    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(lastMonth);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                setState(() {
                  dashboardcontroller.j.updatenotification(1);
                });
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
              )),
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: SizedBox(
            width: 150,
            height: MediaQuery.of(context).size.height * 0.09,
            child: Center(
              child: Text(
                "notification".tr,
                style: GoogleFonts.poppins(
                  color: ColorManager.kDarkBlue,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
          ),
        ),
        body: GetBuilder<notificationscontroller>(
          builder: (context) {
            return const SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: CustomNotification(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
