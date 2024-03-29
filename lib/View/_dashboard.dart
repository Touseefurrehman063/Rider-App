import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Controller/api.dart';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Models/userprofile.dart';
import 'package:flutter_riderapp/Repositeries/localdb.dart';
import 'package:flutter_riderapp/Screen/Dashboard/firstview.dart';
import 'package:flutter_riderapp/Screen/Login/Signup/change_password.dart';
import 'package:flutter_riderapp/Screen/Login/_login.dart';
import 'package:flutter_riderapp/Screen/Notification/notification.dart';
import 'package:flutter_riderapp/Screen/Profile/_profile.dart';
import 'package:flutter_riderapp/Screen/Welcome_Screens/_splash_screen.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

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

        var empId = responseData['Id'];

        //          showDialog(context: context, builder: (context){
        //   return const Center(child: CircularProgressIndicator(),);

        // });
      } else if (status == 0) {}
    }

    return {'isLoggedoff': false, 'empId': null};
  }

  @override
  void initState() {
    super.initState();
    instance();
  }

  instance() async {
    if (userprofile != userProfile()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      login(
          prefs.getString('username') ?? "", prefs.getString('password') ?? "");
    }
  }

  String _getGreetingMessage() {
    var now = DateTime.now();
    var hour = now.hour;

    if (hour < 10) {
      return 'Good Morning';
    } else if (hour < 18) {
      return 'Good Afternoon';
    } else if (hour < 22) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  final List<Widget> pages = [
    const notification(),

    FirstView(),

    Profile(empId: empId ?? "", userName: "$UserName"),

    // AllChats(),
    // Settings(),
  ];
  int selectedPage = 1;

  final items = [
    const Icon(Icons.notifications, size: 30, color: Colors.white),
    const Icon(
      Icons.home,
      size: 30,
      color: Colors.white,
    ),
    const Icon(Icons.person, size: 30, color: Colors.white),
  ];

  int index = 1;

  Future<void> saveLoginState() async {
    var sharedpref = await SharedPreferences.getInstance();
    sharedpref.setBool(SplashscreenState.KEYLOGIN, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      appBar: selectedPage == 1
          ? AppBar(
              shadowColor: Colors.white,
              backgroundColor: Colors.white,
              elevation: 0.0,
              title: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.width * 0.4,
                  child: Image.asset("assets/Helpful.png")),
              leading: Builder(
                builder: (BuildContext context) {
                  return IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    tooltip:
                        MaterialLocalizations.of(context).openAppDrawerTooltip,
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
      drawer: const DrawerContent(),
    );
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

  var response = await http.post(Uri.parse(url), headers: headers, body: body);

  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);
    var status = responseData['Status'];
    print(responseData);

    print('API Response: $responseData');
    if (status == 1) {}
  }
}

class DrawerContent extends StatelessWidget {
  const DrawerContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Welcome',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.fingerprint),
            title: const Text(
              'Biometric',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.password),
            title: const Text('Change Password'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChangePassword()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text(
              'Delete Account',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              deleteaccount();

              logout(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
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
        ],
      ),
    );
  }
}

Future<void> logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(SplashscreenState.KEYLOGIN, false);
  prefs.clear();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const Login()),
    (Route<dynamic> route) => false,
  );
}
