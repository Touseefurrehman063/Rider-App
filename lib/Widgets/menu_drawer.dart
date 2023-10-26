import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/View/_dashboard.dart';

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';


class DrawerScreen extends StatefulWidget {
  final int? index;
  const DrawerScreen({super.key, this.index});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
    // return   ZoomDrawer(
    //     dragOffset: 40,
    //     showShadow: true,
    //     shadowLayer2Color:  Color(0xFF2157B2),
    //     menuBackgroundColor: Colors.blue,
    //     angle: 0,
    //     slideWidth: 300,
    //     drawerShadowsBackgroundColor: Colors.blue,
    //     menuScreen:  DrawerMenuScreen(),
    //     mainScreen: Dashboard(userName: userprofile?.fullName??"",empId: userprofile?.id??"",));
  }
}
