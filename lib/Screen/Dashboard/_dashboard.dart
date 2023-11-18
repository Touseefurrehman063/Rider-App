import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riderapp/AppConstants.dart';
import 'package:flutter_riderapp/Components/images/Images.dart';
import 'package:flutter_riderapp/Controller/api.dart';
import 'package:flutter_riderapp/LocalDb/localDB.dart';
import 'package:flutter_riderapp/Repositeries/authentication.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/Widgets/Utils/languages_dialogue.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Replace these with your actual implementations.
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Models/userprofile.dart';
import 'package:flutter_riderapp/Repositeries/localdb.dart';
import 'package:flutter_riderapp/Screen/Login/Signup/change_password.dart';
import 'package:flutter_riderapp/Screen/Dashboard/firstview.dart';
import 'package:flutter_riderapp/Screen/Notification/notification.dart';
import 'package:flutter_riderapp/Screen/Login/_login.dart';
import 'package:flutter_riderapp/Screen/Profile/_profile.dart';
import 'package:flutter_riderapp/Screen/Welcome_Screens/_splash_screen.dart';

// ignore: must_be_immutable
class Dashboard extends StatefulWidget {
  final String userName;
  late String empId;
  User? user;

  Dashboard({required this.userName, required this.empId, this.user, Key? key})
      : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final ZoomDrawerController zoomController = ZoomDrawerController();
  int index = 1;

  @override
  void initState() {
    super.initState();
    instance();
  }

  instance() async {
    if (userprofile != userProfile()) {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      fingerprint= await LocalDB.getfingerprint();
      setState(() {
        
      });
      // login(
      //     prefs.getString('username') ?? "", prefs.getString('password') ?? "");
    }
  }

  LogoutUser() async {
    var url = '$ip/api/account/Logoff';
    var headers = {
      'Content-Type': 'application/json',
    };
    String? DeviceToken = await LocalDB().getDeviceToken();
    var body = jsonEncode({
      "UserId": "${widget.user!.empId}",
      "DeviceToken": DeviceToken,
      "Manufacturer": "Browser",
      "Model": "Infinix-X680B Infinix X680B",
      "AppVersion": "Infinix-X680B Infinix X680B",
      "DeviceVersion":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36"
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var status = responseData['Status'];
      dynamic usr = responseData;
      widget.user = User.fromJson(usr);
      var sharedpref = await SharedPreferences.getInstance();
      sharedpref.setString('Token', widget.user!.token.toString());

      print('API Response: $responseData');

      if (status == 1) {
        // ignore: use_build_context_synchronously

        // ignore: unused_local_variable
        var empId = responseData['Id'];

        //          showDialog(context: context, builder: (context){
        //   return const Center(child: CircularProgressIndicator(),);

        // });
      } else if (status == 0) {}
    }

    return {'isLoggedoff': false, 'empId': null};
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: zoomController,
      // style: DrawerStyle.style3,
      dragOffset: 40,

      showShadow: true,

      shadowLayer2Color: const Color(0xFF2157B2),
      menuBackgroundColor: const Color(0xFF2157B2),
      angle: 0,
      slideWidth: 275,
      menuScreen: const DrawerContent(),
      mainScreen: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: selectedPage == 1
              ? AppBar(
                  shadowColor: Colors.white,
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  title: Padding(
                    padding:  EdgeInsets.only(left:Get.width*0.01),
                    child: Image.asset(
                       Images.logo,
                      height: Get.height * 0.09,
                      alignment: Alignment.center,
                    ),
                  ),
                  leading: Builder(
                    builder: (BuildContext context) {
                      return IconButton(
                        icon: const Icon(
                          Icons.menu,
                          color: Colors.blue,
                        ),
                        onPressed: () {
                          zoomController.toggle!();
                        },
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      );
                    },
                  ),
                )
              : AppBar(
                  elevation: 0,
                  backgroundColor: Colors.white,
                  toolbarHeight: 0,
                ),
          bottomNavigationBar: CurvedNavigationBar(
            items: items,
            index: index,
            onTap: (int selectedIndex) {
              setState(() {
                index = selectedIndex;
                selectedPage = index;
              });
            },
            height: 50,
            backgroundColor: Colors.transparent,
            animationDuration: const Duration(milliseconds: 300),
            color: Colors.blue,
          ),
          body: pages[index],
        ),
      ),
      borderRadius: 24.0,

      // showShadow: true,
    );
  }
}

class DrawerContent extends StatefulWidget {
  const DrawerContent({super.key});

  @override
  State<DrawerContent> createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Material(
        child: Container(
          color: const Color(0xFF2157B2),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                height: Get.height * 0.1,
                child: const Center(),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 110.0),
                child: CircleAvatar(
                  radius: 28,
                  backgroundColor: const Color(0xFFFEF4F7),
                  child: userprofile?.imagePath == null
                      ? const CircleAvatar(
                          backgroundImage: AssetImage("assets/pp.jpg"),
                          radius: 25,
                        )
                      : Hero(
                          tag: 'profile',
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(ip + userprofile!.imagePath!),
                            radius: 25,
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Text(
                userprofile?.fullName != null
                    ? '${userprofile?.fullName}'
                    : 'Rider',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Divider(
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: Get.width * 0.09),
                child: Text(
                  userprofile?.cNICNumber != null
                      ? "MRN: ${userprofile?.cNICNumber}"
                      : "",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              customListTile(context, onTap: () async {
                Get.to(() => const ChangePassword());
              },
                  // isIcon: true,
                  // icon: const Icon(
                  //   Icons.password,
                  //   color: Colors.white,
                  // ),
                  imagePath: Images.lock,
                  // imageHeight: 2,
                  title: 'changepassword'.tr,
                  textColor: ColorManager.kWhiteColor),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    SizedBox(width: Get.width*0.05,),
                  const Icon(Icons.fingerprint,color: Colors.white,),
                  SizedBox(width: Get.width*0.04,),
                  Text("Biometric", style:
            Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),),
            SizedBox(width: Get.width*0.1,),
                  Switch(value: fingerprint, onChanged:(val) async { 
                      bool auth = await Authentication.authentication();
                      if(val==true){
                      if (auth) {
                        // authentication = await _authenticate();
                        if (auth) {
                          if (userprofile?.id == null) {
                            fingerprint = auth;
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('You are already Logged in')));
                                     LocalDB.savefingerprint(true);
                            // Utils().toastmessage(“You are already Logged in”);
                            fingerprint = true;
                          }
                          setState(() {});
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("You declined the biometric login.")));
                        }
                        if (fingerprint) {
                          if (auth) {
                            if (userprofile?.id != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('You are already Logged in')));
                              LocalDB.savefingerprint(true);
                              setState(() {
                                fingerprint = true;
                              });
                            }
                            setState(() {
                              userprofile;
                            });
                          } else {
                            setState(() {
                              LocalDB.savefingerprint(true);
                              fingerprint = true;
                            });
                          }
                        }
                      } else {
                        setState(() {
                          LocalDB.savefingerprint(false);
                          fingerprint = false;
                        });
                      }
                      }
                      else
                      {
                        fingerprint=val;
                        setState(() {
                          
                        });
                      }
                  }),
                ],
              ),
              //   context,
              //   onTap: 
                
              //     // print("Authenticate:$auth");
              //   },
              //   isIcon: true,
              //   icon: const Icon(
              //     Icons.fingerprint,
              //     color: Colors.white,
              //   ),
              //   title: 'biometric'.tr,
              //   togglebutton: false,
              // ),

              customListTile(
                context,
                isIcon: true,
                icon: const Icon(
                  Icons.language,
                  color: Colors.white,
                  size: 25,
                ),
                // imagePath: Images.language,
                title: 'languages'.tr,

                onTap: () async {
                  await languageSelector(context, AppConstants.languages);
                },
              ),

              const Padding(
                padding: EdgeInsets.only(left: 30.0),
                child: Divider(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: Get.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 80.0),
                child: InkWell(
                  onTap: () {
 showDialog(
                        context: Get.context!,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setstate) {
                            return Scaffold(
                              backgroundColor: Colors.transparent,
                              body: Material(
                                color: Colors.transparent,
                                child: AlertDialog(
                                  scrollable: true,
                                  title: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'privacyPolicy'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: ColorManager.kblackColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w900),
                                      ),
                                      const Divider(
                                        color: ColorManager.kblackColor,
                                      ),
                                    ],
                                  ),
                                  backgroundColor: Colors.white,
                                  content: SizedBox(
                                    width: Get.width,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: Get.height * 0.5,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'consentTitle'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color: ColorManager
                                                              .kblackColor,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                ),
                                                Text(
                                                  'consent'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: ColorManager
                                                              .kblackColor),
                                                ),
                                                Text(
                                                  'informationWeCollect'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 13,
                                                          color: ColorManager
                                                              .kblackColor,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Text(
                                                  'information1'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: ColorManager
                                                              .kblackColor),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                                Text(
                                                  'information2'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: ColorManager
                                                              .kblackColor),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                                Text(
                                                  'usageTitle'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 13,
                                                          color: ColorManager
                                                              .kblackColor,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                                Text(
                                                  'usage'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: ColorManager
                                                              .kblackColor),
                                                ),
                                                Text(
                                                  'disclosureTitle'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 13,
                                                          color: ColorManager
                                                              .kblackColor,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                ),
                                                Text(
                                                  'disclosure'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: ColorManager
                                                              .kblackColor),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.06,
                                          width: Get.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        children: <InlineSpan>[
                                                          WidgetSpan(
                                                            child: SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.01),
                                                          ),
                                                        ],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium
                                                            ?.copyWith(
                                                                color: ColorManager
                                                                    .kblackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12),
                                                        // text: 'theTermsAndCondition'
                                                        //     .tr,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: Get.width * 0.05),
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 100,
                                                          vertical: 20),
                                                      backgroundColor:
                                                          Colors.blue,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: const Text("Ok")),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                        });


                  },
                  child: Text(
                    'privacyPolicy'.tr,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 45.0),
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: Get.context!,
                        builder: (context) {
                          return StatefulBuilder(builder: (context, setstate) {
                            return Scaffold(
                              backgroundColor: Colors.transparent,
                              body: Material(
                                color: Colors.transparent,
                                child: AlertDialog(
                                  scrollable: true,
                                  title: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'termsAndConditions'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                color: ColorManager.kblackColor,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w900),
                                      ),
                                      const Divider(
                                        color: ColorManager.kblackColor,
                                      ),
                                    ],
                                  ),
                                  backgroundColor: Colors.white,
                                  content: SizedBox(
                                    width: Get.width,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: Get.height * 0.5,
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'termsofuse'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          color: ColorManager
                                                              .kblackColor,
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                ),
                                                 SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                                Text(
                                                  'link'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: ColorManager
                                                              .kblackColor),
                                                ),
                                                 SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                                Text(
                                                  'access'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 13,
                                                          color: ColorManager
                                                              .kblackColor,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Text(
                                                  'accessinformation'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: ColorManager
                                                              .kblackColor),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                                // Text(
                                                //   'disclaimer1'.tr,
                                                //   style: Theme.of(context)
                                                //       .textTheme
                                                //       .bodyMedium!
                                                //       .copyWith(
                                                //           fontSize: 12,
                                                //           color: ColorManager
                                                //               .kblackColor),
                                                // ),
                                                // SizedBox(
                                                //   height: Get.height * 0.02,
                                                // ),
                                                Text(
                                                  'disclaimertitle'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 13,
                                                          color: ColorManager
                                                              .kblackColor,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                                Text(
                                                  'disclaimer1'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: ColorManager
                                                              .kblackColor),
                                                ),
                                                 SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                                Text(
                                                  'contactinfo'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 13,
                                                          color: ColorManager
                                                              .kblackColor,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                ),
                                                 SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                                Text(
                                                  'contactinfodetail'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 12,
                                                          color: ColorManager
                                                              .kblackColor),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.02,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.03,
                                        ),
                                        SizedBox(
                                          height: Get.height * 0.06,
                                          width: Get.width,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                        children: <InlineSpan>[
                                                          WidgetSpan(
                                                            child: SizedBox(
                                                                width:
                                                                    Get.width *
                                                                        0.01),
                                                          ),
                                                        ],
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium
                                                            ?.copyWith(
                                                                color: ColorManager
                                                                    .kblackColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12),
                                                        // text: 'theTermsAndCondition'
                                                        //     .tr,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: Get.width * 0.05),
                                              child: ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 100,
                                                          vertical: 20),
                                                      backgroundColor:
                                                          Colors.blue,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: const Text("Ok")),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                        });

                   
                  },
                  child: Text(
                    'termsAndConditions'.tr,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.15,
              ),
              customListTile(context, onTap: () async {
                deleteaccount();

                logout(context);
              },
                  isIcon: true,
                  icon: const Icon(
                    Icons.delete_sharp,
                    color: Colors.white,
                  ),
                  title: 'deleteAccount'.tr,
                  textColor: ColorManager.kWhiteColor),

              customListTile(
                context,
                // isIcon: true,
                // icon: const Icon(
                //   Icons.logout,
                //   color: Colors.white,
                // ),
                imagePath: Images.logout,
                // imageHeight: 10,
                imageHeight: Get.height * 0.025,
                title: 'logout'.tr,
                onTap: () async {
                  logout(context);
                  // int ret=await LogoutUser();
                  // if(ret==1)
                  // {
                  //    Navigator.pushReplacement(
                  //                   context,
                  //                   MaterialPageRoute(builder: (context) => Login(),

                  //                   ));

                  // }
                  // else{
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //                   const SnackBar(
                  //                     content: Text('Log Out Fail'),
                  //                     duration: Duration(seconds: 5),
                  //                   ),
                  //                 );

                  // }
                },
              ),

              // ListTile(
              //   leading: const Icon(Icons.logout,color: Colors.white,),
              //   title: Text('Logout',style:
              // Theme.of(context).textTheme.bodySmall?.copyWith(color:Colors.white,fontSize: 14)),
              //   onTap: () {
              //      logout(context);
              //   // int ret=await LogoutUser();
              //   // if(ret==1)
              //   // {
              //   //    Navigator.pushReplacement(
              //   //                   context,
              //   //                   MaterialPageRoute(builder: (context) => Login(),

              //   //                   ));

              //   // }
              //   // else{
              //   //   ScaffoldMessenger.of(context).showSnackBar(
              //   //                   const SnackBar(
              //   //                     content: Text('Log Out Fail'),
              //   //                     duration: Duration(seconds: 5),
              //   //                   ),
              //   //                 );

              //   // }
              //   },
              // ),
            ],
          ),
        ),
      )
    ]);
  }

  Future<void> deleteaccount() async {
    var url = '$ip/api/account/DeleteUserAccount';
    var headers = {
      'Content-Type': 'application/json',
    };
    var sharedpref = await SharedPreferences.getInstance();
    String userid = sharedpref.getString('userId').toString();
    String token = sharedpref.getString('Token').toString();

    var body = jsonEncode({
      'UserId': userid,
      'Token': token,
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var status = responseData['Status'];
      print(responseData);

      print('API Response: $responseData');
      if (status == 1) {}
    }
  }

  customListTile(
    BuildContext context, {
    String? title,
    Function()? onTap,
    Widget? icon,
    Color? textColor = ColorManager.kWhiteColor,
    String? imagePath,
    double? imageHeight = 20,
    bool? togglebutton = false,
    bool? isIcon = false,
    bool isToggled = false,
    bool isImageThere = false,
  }) {
    return ListTile(
      visualDensity: const VisualDensity(vertical: -1, horizontal: 2),
      onTap: onTap,
      minLeadingWidth: 10,
      dense: true,
      horizontalTitleGap: 10,
      contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
                color: ColorManager.kRedColor,
                size: 30,
              ),
      title: Text(
        '$title',
        style:
            Theme.of(context).textTheme.bodySmall?.copyWith(color: textColor),
      ),
      trailing: togglebutton == true
          ? CupertinoSwitch(
              value: isToggled,
              onChanged: (value) {
                if (onTap != null) {
                  onTap();
                }
              },
            )
          : const SizedBox.shrink(),
    );
  }
}

bool isBiometric = false;

final LocalAuthentication auth = LocalAuthentication();
List<BiometricType>? _availableBiometrics;
String _authorized = "Not Authorized";
bool _isAuthenticating = false;
bool authentication = false;
Future<bool> _authenticate() async {
  bool authenticated = false;
  try {
    _isAuthenticating = true;
    _authorized = "Authenticating";

    authenticated = await auth.authenticate(
      localizedReason: "Let OS determine authentication method",
      options: const AuthenticationOptions(
        stickyAuth: true,
      ),
    );

    _isAuthenticating = false;
  } on PlatformException catch (e) {
    _isAuthenticating = false;
    _authorized = "Error - ${e.message}";
    print(e.message.toString());

    return authenticated;
  }

  () => _authorized = authenticated ? "Authorized" : "Not Authorized";
  return authenticated;
}

bool fingerprint = false;

void logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(SplashscreenState.KEYLOGIN, false);
  // prefs.clear();
  userprofile=userProfile();
prefs.setString('userId','').toString();
  prefs.setString('username','').toString();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const Login()),
    (Route<dynamic> route) => false,
  );
}

int selectedPage = 1;
String UserName = "YourUsername";
String empId = "YourEmpId";

final List<Widget> pages = [
  const notification(),
  FirstView(),
  Profile(empId: empId, userName: UserName),
];

final items = [
  const Icon(Icons.notifications, size: 30, color: Colors.white),
  const Icon(Icons.home, size: 30, color: Colors.white),
  const Icon(Icons.person, size: 30, color: Colors.white),
];
