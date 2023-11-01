// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/Screen/Nodata/Nodata.dart';
import 'package:get/get.dart';


class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 10),
        child: GetBuilder(builder: (cont) {
          return ListView(
            children: [
              SizedBox(
                height: Get.height * 0.08,
              ),
             
              SizedBox(
                height: Get.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    userprofile?.fullName != null
                        ? '${userprofile?.fullName}'
                        : 'Rider',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: Get.width * 0.15,
                  ),
                  
                ],
              ),

              // SizedBox(
              //   width: Get.width * 0.5,
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //       enabled: false,
              //       hintText: AuthController.i.user?.fullName != null
              //           ? '${AuthController.i.user?.fullName}'
              //           : '',
              //       hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              //           fontSize: 20, color: ColorManager.kWhiteColor),
              //     ),
              //   ),
              // ),
              const Divider(
                color: Colors.white,
                thickness: 1,
              ),
              

              customListTile(context, onTap: () {
                Get.to(() => const NoDataFound());
              },
                  isIcon: true,
                  icon: const Icon(
                    Icons.history,
                    size: 30,
                    color: Colors.white,
                  ),
                  title: 'History'),
            
             
            
             
              // customListTile(context, onTap: () {
              //   Get.to(() => const NoDataFound());
              // }, imagePath: Images.lock, title: 'changePassword'.tr,imageHeight: Get.height*0.038),
              customListTile(
                context,
                onTap: () {
                  Get.to(() => const NoDataFound());
                },
                 icon: const Icon(
                    Icons.fingerprint,
                    size: 30,
                    color: Colors.white,
                  ),
                title: 'Biometric',
                togglebutton: true,
              ),
               customListTile(
                context,
                isIcon: true,
                icon:  const Icon(
                  Icons.password,
                  color: Colors.white,
                  size: 30,
                ),
                // imagePath: Images.language,
                title: 'Change Password',

                onTap: () async {
                  // await languageSelector(context, AppConstants.languages);
                },
              ),
              customListTile(
                context,
                isIcon: true,
                icon: const Icon(
                  Icons.language,
                  color: Colors.white,
                  size: 30,
                ),
                // imagePath: Images.language,
                title: 'Language',

                onTap: () async {
                  // await languageSelector(context, AppConstants.languages);
                },
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              const Divider(
                color: Colors.white,
                thickness: 1,
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              InkWell(
                onTap: () {
                  print('Pressed');
                },
                child: Text(
                  'privacyPolicy'.tr,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 14),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              InkWell(
                onTap: () {
                  print('Pressed');
                },
                child: Text(
                  'termsAndConditions'.tr,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 14),
                ),
              ),
              SizedBox(height: Get.height * 0.03),

              // customListTile(context, onTap: () {
              //   Get.to(() => const RegisterScreen());
              // }, imagePath: Images.wifi, title: 'signup'.tr,imageHeight: Get.height*0.038),

              // AuthController.i.loginStatus == false
              //     ? customListTile(
              //         context,
              //         imagePath: Images.logout,
              //         title: 'Login'.tr,imageHeight: Get.height*0.038,
              //         onTap: () async {
              //           Get.to(() => const LoginScreen());
              //         },
              //       )
              //     : const SizedBox.shrink(),

             
                     
                    
                
                customListTile(
                context,
                isIcon: true,
                icon: const Icon(
                  Icons.language,
                  color: Colors.white,
                  size: 30,
                ),
                // imagePath: Images.language,
                title: 'Logout',

                onTap: () async {
                  // await languageSelector(context, AppConstants.languages);
                },
              ),
            ],
          );
        }),
      ),
    );
  }

  customListTile(BuildContext context,
      {String? title,
      Function()? onTap,
      Widget? icon,
      Color? textColor = Colors.white,
      String? imagePath,
      double? imageHeight = 20,
      bool? togglebutton = false,
      bool? isIcon = false,
      bool? isToggled,
      bool isImageThere = false}) {
    return ListTile(
      onTap: onTap,
      minLeadingWidth: 10,
      dense: false,
      horizontalTitleGap: 20,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      leading: isIcon == false
          ? (imagePath != null && imagePath.isNotEmpty)
              ? SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    imagePath,
                  ),
                )
              : const SizedBox.shrink()
          : icon ??
              const Icon(
                Icons.delete,
                color: Colors.red,
                size: 30,
              ),
      title: Text(
        '$title',
        style:
            Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor),
      ),
      trailing: togglebutton == true
          ? CupertinoSwitch(
              value: true,
              onChanged: (value) {},
            )
          : const SizedBox.shrink(),
    );
  }
}
