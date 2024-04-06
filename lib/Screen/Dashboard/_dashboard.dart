import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riderapp/AppConstants.dart';
import 'package:flutter_riderapp/Components/images/Images.dart';
import 'package:flutter_riderapp/Repositeries/authentication.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/View/_dashboard.dart';
import 'package:flutter_riderapp/Widgets/Utils/languages_dialogue.dart';
import 'package:flutter_riderapp/Widgets/Utils/toaster.dart';
import 'package:flutter_riderapp/controllers/Auth_Controller/auth_controller.dart';
import 'package:flutter_riderapp/controllers/Notification/dashboardcontroller.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
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

  final items = [
    const Icon(Icons.notifications, size: 30, color: Colors.white),
    const Icon(Icons.home, size: 30, color: Colors.white),
    const Icon(Icons.person, size: 30, color: Colors.white),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.notifications,
            size: 30,
            color: dashboardcontroller.j.index == 0
                ? ColorManager.kPrimaryColor
                : ColorManager.kGreyColor),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home,
            size: 30,
            color: dashboardcontroller.j.index == 1
                ? ColorManager.kWhiteColor
                : ColorManager.kGreyColor),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.person,
            size: 30,
            color: dashboardcontroller.j.index == 2
                ? ColorManager.kPrimaryColor
                : ColorManager.kGreyColor),
        activeColorPrimary: CupertinoColors.activeBlue,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  instance() async {
    if (userprofile != userProfile()) {
      // SharedPreferences prefs = await SharedPreferences.getInstance();

      // login(
      //     prefs.getString('username') ?? "", prefs.getString('password') ?? "");
    }
  }

  LogoutUser() async {
    var url = '$ip/api/account/Logoff';

    String? DeviceToken = await LocalDB().getDeviceToken();
    var sharedpref = await SharedPreferences.getInstance();
    String userid = sharedpref.getString('userId').toString();
    dynamic body = {
      "UserId": userid,
      "DeviceToken": DeviceToken,
      "Manufacturer": "Browser",
      "Model": "Infinix-X680B Infinix X680B",
      "AppVersion": "Infinix-X680B Infinix X680B",
      "DeviceVersion":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36"
    };

    var response = await http.post(Uri.parse(url), body: body);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var status = responseData['Status'];
      dynamic usr = responseData;
      // userid=User.fromJson(usr);
      var sharedpref = await SharedPreferences.getInstance();
      sharedpref.setString('Token', DeviceToken.toString());

      print('API Response: $responseData');

      if (status == 1) {
        // ignore: use_build_context_synchronously

        return status;

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

      // showShadow: true,

      shadowLayer2Color: ColorManager.kmenuBlue,
      menuBackgroundColor: ColorManager.kmenuBlue,
      angle: 0,
      slideWidth: 275,
      menuScreen: const DrawerContent(),
      mainScreen: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: dashboardcontroller.j.index == 1
              ? AppBar(
                  centerTitle: true,
                  shadowColor: Colors.white,
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                  title: Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.01),
                    child: Image.asset(
                      Images.logo,
                      height: Get.height * 0.07,
                      alignment: Alignment.center,
                    ),
                  ),
                  leading: Padding(
                    padding: EdgeInsets.only(left: Get.width * 0.05),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: Get.height * 0.015),
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(05),
                              color: ColorManager.kDarkBlue),
                          child: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),

                          // tooltip: MaterialLocalizations.of(context)
                          //     .openAppDrawerTooltip,
                        ),
                        onTap: () {
                          zoomController.toggle!();
                        },
                      ),
                    ),
                  ),
                  // Builder(
                  //   builder: (BuildContext context) {
                  //     return IconButton(
                  //       icon: const Icon(
                  //         Icons.menu,
                  //         color: Colors.blue,
                  //       ),
                  //       onPressed: () {
                  //         zoomController.toggle!();
                  //       },
                  //       tooltip: MaterialLocalizations.of(context)
                  //           .openAppDrawerTooltip,
                  //     );
                  //   },
                  // ),
                )
              : AppBar(
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: Colors.white,
                  toolbarHeight: 0,
                ),
          bottomNavigationBar:
              GetBuilder<dashboardcontroller>(builder: (context) {
            return Container(
              height: Get.height * 0.08,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30)),
                color: ColorManager.kWhiteColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: ColorManager.kGreyColor,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                      onTap: () {
                        dashboardcontroller.j.updatenotification(0);
                        setState(() {});
                      },
                      child: Icon(Icons.notifications,
                          size: 30,
                          color: dashboardcontroller.j.index == 0
                              ? ColorManager.kDarkBlue
                              : ColorManager.kGreyColor)),
                  const Text("    "),
                  InkWell(
                      onTap: () {
                        dashboardcontroller.j.updatenotification(2);
                        setState(() {});
                      },
                      child: Icon(Icons.person,
                          size: 30,
                          color: dashboardcontroller.j.index == 2
                              ? ColorManager.kDarkBlue
                              : ColorManager.kGreyColor)),
                ],
              ),
            );
          }),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.home,
                  size: 30, color: ColorManager.kWhiteColor),
              onPressed: () {
                dashboardcontroller.j.updatenotification(1);
                setState(() {});
              }),
          // SizedBox(
          //   height:selectedPage == 1 && homechk==true
          //     ? Get.height*0.89: Get.height*0.98,
          //   child: PersistentTabView(

          //         context,

          //         screens:pages ,
          //         items: _navBarsItems(),
          //      //   confineInSafeArea: true,
          //         backgroundColor: Colors.white, // Default is Colors.white.
          //        // handleAndroidBackButtonPress: true, // Default is true.
          //        // resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
          //         // stateManagement: true, // Default is true.
          //         hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
          //         decoration: const NavBarDecoration(
          //   borderRadius: BorderRadius.only(topLeft: Radius.circular(30),topRight:  Radius.circular(30)),
          //   boxShadow: <BoxShadow>[
          //   BoxShadow(
          //     color: ColorManager.kGreyColor,
          //     blurRadius: 10,
          //   ),
          //   ],
          //         ),
          //       onItemSelected: (i){
          //         setState(() {
          //       index = i;
          //       if(i==1)
          //       {
          //         homechk=true;
          //       }
          //       else
          //       {
          //         homechk=false;
          //       }
          //       selectedPage = index;
          //       setState(() {

          //       });

          //     });
          //       },
          //       navBarHeight: 50,
          //         popAllScreensOnTapOfSelectedTab: true,
          //         popActionScreens: PopActionScreensType.all,
          //         itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
          //   duration: Duration(milliseconds: 200),
          //   curve: Curves.ease,
          //         ),
          //         screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
          //   animateTabTransition: true,
          //   curve: Curves.ease,
          //   duration: Duration(milliseconds: 200),
          //         ),
          //         navBarStyle: NavBarStyle.style15, // Choose the nav bar style with this property.
          //     ),
          // ),
          // CurvedNavigationBar(
          //   items: items,
          //   index: index,
          //   onTap: (int selectedIndex) {
          //     setState(() {
          //       index = selectedIndex;
          //       selectedPage = index;
          //     });
          //   },
          //   height: 50,
          //   backgroundColor: Colors.transparent,
          //   animationDuration: const Duration(milliseconds: 300),
          //   color: Colors.blue,
          // ),

          body: GetBuilder<dashboardcontroller>(builder: (cnt) {
            return SafeArea(
              child: pages[cnt.index],
            );
          }),
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
  instance() async {
    if (userprofile != userProfile()) {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      fingerprint = await LocalDB.getfingerprint();
      setState(() {
        fingerprint;
      });
      // login(
      //     prefs.getString('username') ?? "", prefs.getString('password') ?? "");
    }
  }

  @override
  void initState() {
    instance();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF2157B2),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(children: [
                SizedBox(
                  width: double.infinity,
                  height: Get.height * 0.1,
                ),
                ListTile(
                  leading: CircleAvatar(
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
                ListTile(
                  visualDensity:
                      const VisualDensity(vertical: -4, horizontal: 2),
                  leading: Text(
                    userprofile?.fullName != null
                        ? '${userprofile?.fullName}'
                        : 'Rider',
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 16),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.036),
                  child: const Divider(
                    color: Colors.white,
                  ),
                ),
                ListTile(
                  visualDensity:
                      const VisualDensity(vertical: -4, horizontal: 2),
                  leading: Text(
                    userprofile?.cNICNumber != null
                        ? "National Id: ${userprofile?.cNICNumber}"
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
                SizedBox(
                  height: Get.height * 0.01,
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: Get.width * 0.15,
                      child: Icon(
                        Icons.fingerprint,
                        size: Get.width * 0.07,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "biometric".tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      width: Get.width * 0.08,
                    ),
                    Switch(
                        value: fingerprint,
                        onChanged: (val) async {
                          bool auth = await Authentication.authentication();
                          if (val == true) {
                            if (auth) {
                              // authentication = await _authenticate();
                              if (auth) {
                                if (userprofile?.id == null) {
                                  fingerprint = auth;
                                } else {
                                  LocalDB.savefingerprint(true);
                                  // Utils().toastmessage(“You are already Logged in”);
                                  fingerprint = true;
                                }
                                setState(() {});
                              } else {
                                Showtoaster().classtoaster(
                                    "You declined the biometric login.");
                              }
                              if (fingerprint) {
                                if (auth) {
                                  if (userprofile?.id != null) {
                                    Showtoaster()
                                        .classtoaster("Fingerprint Enabled");
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
                          } else {
                            if (auth) {
                              LocalDB.savefingerprint(false);
                              fingerprint = val;
                              setState(() {});
                            }
                          }
                        }),
                  ],
                ),
                SizedBox(
                  height: Get.height * 0.02,
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
                SizedBox(
                  height: Get.height * 0.02,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.036),
                  child: const Divider(
                    color: Colors.white,
                  ),
                ),

                ListTile(
                  visualDensity:
                      const VisualDensity(vertical: -4, horizontal: 2),
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
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
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
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Text(
                                                  'informationWeCollect'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 15,
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
                                                  height: Get.height * 0.01,
                                                ),
                                                Text(
                                                  'usageTitle'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 15,
                                                          color: ColorManager
                                                              .kblackColor,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
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
                                                SizedBox(
                                                  height: Get.height * 0.01,
                                                ),
                                                Text(
                                                  'disclosureTitle'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(
                                                          fontSize: 15,
                                                          color: ColorManager
                                                              .kblackColor,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                ),
                                                SizedBox(
                                                  height: Get.height * 0.01,
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
                                        // SizedBox(
                                        //   height: Get.height * 0.06,
                                        //   width: Get.width,
                                        //   child: Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.center,
                                        //     children: [
                                        //       Expanded(
                                        //         child: RichText(
                                        //           text: TextSpan(
                                        //             children: <TextSpan>[
                                        //               TextSpan(
                                        //                 children: <InlineSpan>[
                                        //                   WidgetSpan(
                                        //                     child: SizedBox(
                                        //                         width:
                                        //                             Get.width *
                                        //                                 0.01),
                                        //                   ),
                                        //                 ],
                                        //                 style: Theme.of(context)
                                        //                     .textTheme
                                        //                     .titleMedium
                                        //                     ?.copyWith(
                                        //                         color: ColorManager
                                        //                             .kblackColor,
                                        //                         fontWeight:
                                        //                             FontWeight
                                        //                                 .bold,
                                        //                         fontSize: 12),
                                        //                 // text: 'theTermsAndCondition'
                                        //                 //     .tr,
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: Get.height * 0.06,
                                              width: Get.width * 0.4,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          // padding:  EdgeInsets
                                                          //     .symmetric(
                                                          //     horizontal: Get.width*0.1,
                                                          //     vertical:  Get.height*0.02),
                                                          backgroundColor:
                                                              Colors.blue,
                                                          shape: RoundedRectangleBorder(
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
                  leading: Text(
                    'privacyPolicy'.tr,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),

                ListTile(
                  visualDensity:
                      const VisualDensity(vertical: -4, horizontal: 2),
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
                                        // SizedBox(
                                        //   height: Get.height * 0.06,
                                        //   width: Get.width,
                                        //   child: Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.center,
                                        //     children: [
                                        //       Expanded(
                                        //         child: RichText(
                                        //           text: TextSpan(
                                        //             children: <TextSpan>[
                                        //               TextSpan(
                                        //                 children: <InlineSpan>[
                                        //                   WidgetSpan(
                                        //                     child: SizedBox(
                                        //                         width:
                                        //                             Get.width *
                                        //                                 0.01),
                                        //                   ),
                                        //                 ],
                                        //                 style: Theme.of(context)
                                        //                     .textTheme
                                        //                     .titleMedium
                                        //                     ?.copyWith(
                                        //                         color: ColorManager
                                        //                             .kblackColor,
                                        //                         fontWeight:
                                        //                             FontWeight
                                        //                                 .bold,
                                        //                         fontSize: 12),
                                        //                 // text: 'theTermsAndCondition'
                                        //                 //     .tr,
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: Get.height * 0.06,
                                              width: Get.width * 0.4,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          // padding:  EdgeInsets
                                                          //     .symmetric(
                                                          //     horizontal: Get.width*0.1,
                                                          //     vertical:  Get.height*0.02),
                                                          backgroundColor:
                                                              Colors.blue,
                                                          shape: RoundedRectangleBorder(
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
                  leading: Text(
                    'termsAndConditions'.tr,
                    style: const TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.07,
                ),
              ]),
              Column(
                children: [
                  customListTile(context, onTap: () async {
                    deleteaccount();

                    logout(context);
                  },
                      isIcon: true,
                      icon: Icon(
                        Icons.delete_sharp,
                        size: Get.height * 0.04,
                        color: Colors.white,
                      ),
                      title: 'deleteAccount'.tr,
                      textColor: ColorManager.kWhiteColor),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
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
                      setState(() {});

                      int ret = await LogoutUser();
                      if (ret == 1) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Log Out Fail'),
                            duration: Duration(seconds: 5),
                          ),
                        );
                      }
                      setState(() {});
                    },
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  ListTile(
                    visualDensity:
                        const VisualDensity(horizontal: 4, vertical: -4),
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: Get.width * 0.06, vertical: 0),
                    title: Row(
                      children: [
                        Text(
                          'App Version:'.tr,
                          style: GoogleFonts.poppins(
                            textStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              color: ColorManager.kWhiteColor,
                              //  fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.09,
                        ),
                        Text(
                          AuthController.i.appVersion,
                          style: GoogleFonts.poppins(
                            textStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              color: ColorManager.kWhiteColor,
                              //  fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
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
      ),
    );
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
    return InkWell(
      onTap: onTap,
      child: Row(
        // visualDensity: const VisualDensity(vertical: -1, horizontal: 2),
        // onTap: onTap,
        // minLeadingWidth: 10,
        // dense: true,
        // horizontalTitleGap: 10,
        // contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        children: [
          SizedBox(
            width: Get.width * 0.15,
            child: isIcon == false
                ? (imagePath != null && imagePath.isNotEmpty)
                    ? SizedBox(
                        height: Get.width * 0.07,
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
          ),
          Text(
            '$title',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: textColor),
          ),
          togglebutton == true
              ? CupertinoSwitch(
                  value: isToggled,
                  onChanged: (value) {
                    if (onTap != null) {
                      onTap();
                    }
                  },
                )
              : const SizedBox.shrink(),
        ],
      ),
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
  userprofile = userProfile();
  prefs.setString('userId', '').toString();
  prefs.setString('username', '').toString();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const Login()),
    (Route<dynamic> route) => false,
  );
}

bool homechk = false;
// int selectedPage = 1;
String UserName = "YourUsername";
String empId = "YourEmpId";

final List<Widget> pages = [
  const notification(),
  FirstView(),
  Profile(empId: empId, userName: UserName),
];

class Mycustomnavbar extends StatelessWidget {
  const Mycustomnavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<dashboardcontroller>(builder: (cnt) {
      return Container(
        height: Get.height * 0.08,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: ColorManager.kWhiteColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: ColorManager.kGreyColor,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
                onTap: () {
                  dashboardcontroller.j.updatenotification(0);

                  Get.offAll(() => Dashboard(
                      userName: userprofile!.username!,
                      empId: userprofile!.id!));
                },
                child: Icon(Icons.notifications,
                    size: 30,
                    color: dashboardcontroller.j.index == 0
                        ? ColorManager.kDarkBlue
                        : ColorManager.kGreyColor)),
            InkWell(
                onTap: () {
                  dashboardcontroller.j.updatenotification(1);
                  Get.offAll(() => Dashboard(
                      userName: userprofile!.username!,
                      empId: userprofile!.id!));
                },
                child: Icon(Icons.home,
                    size: 30,
                    color: dashboardcontroller.j.index == 1
                        ? ColorManager.kDarkBlue
                        : ColorManager.kGreyColor)),
            InkWell(
                onTap: () {
                  dashboardcontroller.j.updatenotification(2);
                  Get.offAll(() => Dashboard(
                      userName: userprofile!.username!,
                      empId: userprofile!.id!));
                },
                child: Icon(Icons.person,
                    size: 30,
                    color: dashboardcontroller.j.index == 2
                        ? ColorManager.kDarkBlue
                        : ColorManager.kGreyColor)),
          ],
        ),
      );
    });
  }
}
