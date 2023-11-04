import 'package:flutter/material.dart';
import 'package:flutter_riderapp/controllers/Auth_Controller/auth_controller.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:flutter_riderapp/helpers/font_manager.dart';
import 'package:get/get.dart';


class PrimaryButton extends StatelessWidget {
  final bool? isLoading;
  final bool? isGradient;
  final Color? gradientColor;
  final double? textWidth;
  final bool? isDisabled;
  final double? radius;
  final FontWeight? fontweight;
  final Widget? textWidget;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? width;
  final Color color;
  final Color textcolor;
  final String title;
  final double? fontSize;
  final VoidCallback onPressed;
  final Widget? icon;
  final bool? primaryIcon;
  final BoxBorder? border;
  const PrimaryButton(
      {Key? key,
      this.height = 50,
      this.margin,
      required this.title,
      required this.onPressed,
      required this.color,
      required this.textcolor,
      this.fontSize = FontSize.s20,
      this.icon,
      this.primaryIcon = false,
      this.width,
      this.padding,
      this.textWidget,
      this.fontweight = FontWeight.w900,
      this.border,
      this.radius = 10,
      this.isDisabled = false,
      this.textWidth,
      this.isGradient,
      this.gradientColor,
      this.isLoading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(builder: (cont) {
      return GestureDetector(
        onTap: isDisabled == false ? onPressed : null,
        child: Container(
            margin: margin,
            padding: padding,
            height: height,
            width: width ?? double.infinity,
            decoration: BoxDecoration(
                gradient: isGradient == true
                    ? LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [gradientColor!, color])
                    : null,
                border: border,
                color: isDisabled == true ? ColorManager.kGreyColor : color,
                borderRadius: BorderRadius.circular(radius!)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                primaryIcon == true ? icon! : const SizedBox(),
                // const SizedBox(
                //   width: 5,
                // ),
                // const SizedBox(
                //   width: 5,
                // ),
                Center(
                    child: isLoading == false
                        ? SizedBox(
                            width: textWidth,
                            child: Text(
                              title,
                              style: TextStyle(
                                  fontSize: fontSize,
                                  color: textcolor,
                                  fontWeight: fontweight),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : const CircularProgressIndicator(
                            color: ColorManager.kWhiteColor,
                          )),
              ],
            )),
      );
    });
  }
}
