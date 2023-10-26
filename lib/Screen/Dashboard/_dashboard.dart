import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/AppConstants.dart';
import 'package:flutter_riderapp/Controller/api.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/Screen/Nodata/Nodata.dart';
import 'package:flutter_riderapp/Widgets/Utils/languages_dialogue.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      login(prefs.getString('username') ?? "",
          prefs.getString('password') ?? "");
    }
  }


LogoutUser() async {
  
  var url = '$ip/api/account/Logoff';
  var headers = {
    'Content-Type': 'application/json',
  };
  String? DeviceToken = await LocalDB().getDeviceToken();
  var body = jsonEncode({
    "UserId":"${widget.user!.empId}",
      "DeviceToken": DeviceToken,
  "Manufacturer": "Browser",
  "Model": "Infinix-X680B Infinix X680B",
  "AppVersion": "Infinix-X680B Infinix X680B",
  "DeviceVersion": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36"
  });

  var response = await http.post(Uri.parse(url), headers: headers, body: body);

  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);
    var status = responseData['Status'];
    dynamic usr=responseData;
    widget.user=User.fromJson(usr);
    var sharedpref = await SharedPreferences.getInstance();
    sharedpref.setString('Token',widget.user!.token.toString());


   

      print('API Response: $responseData'); 


    if (status == 1) {
      // ignore: use_build_context_synchronously
   
      // ignore: unused_local_variable
      var empId = responseData['Id'];

     
  //          showDialog(context: context, builder: (context){
  //   return const Center(child: CircularProgressIndicator(),);

  // });

      

    } else if (status == 0) {

    }
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
        shadowLayer2Color:  const Color(0xFF2157B2),
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
                  title: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.width * 0.4,
                    child: Image.asset("assets/Helpful.png"), // Replace with your image
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

class DrawerContent extends StatelessWidget {
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: const Color(0xFF2157B2),
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: Get.height*0.2  ,
              child: const Center(
           
              ),
            ),
             Padding(
               padding: const EdgeInsets.only(right:80.0),
               child: Text(
                 userprofile?.fullName != null
                     ? '${userprofile?.fullName}'
                     : 'Rider',
                 style: const TextStyle(
                     color: Colors.white, fontWeight: FontWeight.bold),
               ),
             ),
             const Divider(
              color: Colors.white,
             ),
            
             ListTile(
              leading: const Icon(Icons.history,color: Colors.white,),
              title: Text('History', style:
            Theme.of(context).textTheme.bodySmall?.copyWith(color:Colors.white,fontSize: 14)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NoDataFound()),
                );
              },
            ),
             ListTile(
              leading: const Icon(Icons.fingerprint,color: Colors.white,),
              title: Text('Biometric',style:
            Theme.of(context).textTheme.bodySmall?.copyWith(color:Colors.white,fontSize: 14)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NoDataFound()),
                );
              },
            ),
             ListTile(
              leading: const Icon(Icons.fingerprint,color: Colors.white,),
              title: Text('Language',style:
            Theme.of(context).textTheme.bodySmall?.copyWith(color:Colors.white,fontSize: 14)),
              onTap: () async{
                await languageSelector(context, AppConstants.languages);
              },
            ),
          
           
            ListTile(
              leading: const Icon(Icons.password,color: Colors.white,),
              title: Text('Change Password',style:
            Theme.of(context).textTheme.bodySmall?.copyWith(color:Colors.white,fontSize: 14)),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChangePassword()),
                );
              },
            ),
            const Divider(color: Colors.white,),
             SizedBox(
                height: Get.height * 0.02,
              ),
            Padding(
              padding: const EdgeInsets.only(right:80.0),
              child: InkWell(
                  onTap: () {
                    print('Pressed');
                  },
                  child: const Text(
                    'Privacy & Policy',
                    style: TextStyle(
                        color: Colors.white, fontSize: 14),
                  ),
                ),
            ),
              SizedBox(
                height: Get.height * 0.02,
              ),
            Padding(
              padding: const EdgeInsets.only(right:45.0),
              child: InkWell(
                  onTap: () {
                    print('Pressed');
                  },
                  child: const Text(
                    'Terms and Conditions',
                    style: TextStyle(
                        color: Colors.white, fontSize: 14),
                  ),
                ),
            ),
             SizedBox(
                height: Get.height * 0.07,
              ),


            ListTile(
              leading: const Icon(Icons.delete,color: Colors.white,),
              title: Text('Delete Account', style:
            Theme.of(context).textTheme.bodySmall?.copyWith(color:Colors.white,fontSize: 14)),
              onTap: () {
                deleteaccount();
              
              logout(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout,color: Colors.white,),
              title: Text('Logout',style:
            Theme.of(context).textTheme.bodySmall?.copyWith(color:Colors.white,fontSize: 14)),
              onTap: () {
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
      ),
    );
  }
  Future <void> deleteaccount() async {
  var url = '$ip/api/account/DeleteUserAccount';
  var headers = {
    'Content-Type': 'application/json',
  };
    var sharedpref = await SharedPreferences.getInstance();
   String userid=sharedpref.getString('userId').toString();
   String token=sharedpref.getString('Token').toString();
   
       
  var body = jsonEncode({
    'UserId':userid,
    'Token':token,
  });

  var response = await http.post(Uri.parse(url), headers: headers, body: body);

  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);
    var status = responseData['Status'];
    print(responseData);


      print('API Response: $responseData'); 
      if (status==1){
        
       
      }


   
  }
  

  
}




}


void logout(BuildContext context) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(SplashscreenState.KEYLOGIN, false);
  prefs.clear();
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
