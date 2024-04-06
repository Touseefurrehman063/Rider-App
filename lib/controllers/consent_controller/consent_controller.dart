import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/container_info/container_info.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class CustomContainerController extends GetxController {
  final List<ContainerInfo> containerInfoList = [];

  void saveContainerInfo({
    required File image,
    required String remarks,
    required bool accepted,
  }) {
    containerInfoList.add(
      ContainerInfo(
        image: image,
        remarks: remarks,
        accepted: accepted,
      ),
    );
  }
}
