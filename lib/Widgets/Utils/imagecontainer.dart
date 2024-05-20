import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Components/images/Images.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ImageContainer extends StatelessWidget {
  final bool? isNetworkImage;
  final Function()? onpressed;
  final bool? isSvg;
  final Color? color;
  final Color? backgroundColor;
  final String? imagePath;
  final String? pic;
  final double? height;
  final double? width;
  const ImageContainer({
    super.key,
    this.imagePath,
    this.color,
    this.backgroundColor,
    this.isSvg = true,
    this.onpressed,
    this.isNetworkImage,
    this.pic,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10.0),
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: backgroundColor),
        child: InkWell(
            onTap: onpressed,
            child: Image(height: Get.height * 0.04, image: AssetImage(pic!))));
  }
}
