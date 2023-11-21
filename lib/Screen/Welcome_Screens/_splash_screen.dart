
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Components/images/Images.dart';
import 'package:flutter_riderapp/Controller/api.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/Screen/Welcome_Screens/welcome_1.dart';
import 'package:get/get.dart';
// import 'package:flutter_riderapp/Utilities.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riderapp/Screen/Dashboard/_dashboard.dart';
import 'package:flutter_riderapp/Screen/Login/_login.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

// import '../Models/User.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => SplashscreenState();
  
}
class SplashscreenState extends State<Splashscreen>
    with SingleTickerProviderStateMixin {
  // late AnimationController _animationController;
  // late Animation<Offset> _animation;

  static const String KEYLOGIN = "login";

 String? username;
  String? password;

 Future<void> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username');
    password = prefs.getString('pass');
    
    String? value = prefs.getString('firstapp');

    if (value == null || value == "") {
     
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Welcome1()));
    } else {
   
      String userId = prefs.getString('userId') ?? "";
      String userName = prefs.getString('username') ?? "";
      Map<String, dynamic> mp = await login(username??"", password??"");

      if (mp['isLoggedIn']) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard(userName: userName, empId: userId)));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login()));
      }
    }
  }

// instance() async
// {
//   SharedPreferences _pref=await SharedPreferences.getInstance();
//   bool? val=_pref.getBool('initScreen');
 
  
//   String? username;
//   String? password;


//    SharedPreferences prefs = await SharedPreferences.getInstance();
    
//       username= await prefs.getString('username');
//          password= await prefs.getString('pass');

//   String value="";
  
//   value= await prefs.getString('firstapp')!;
//           String userid=prefs.getString('userId').toString();
//     String usernm=prefs.getString('username').toString();
//   Map<String,dynamic>mp= await login(username!, password!);
// if(value.toString()==null || value.toString()=="")
//   {
//     debugPrint(value.toString());
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Welcome1()));
//   }

//   else if(mp['isLoggedIn'])
//   {
//     Navigator.push(context, MaterialPageRoute(builder: (builder)=> Dashboard(userName: usernm, empId: userid)));
//   }
//   else{
//     debugPrint(value.toString());
//      Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Login()));
//   }
// }
instance() async
{
      final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(minutes: 2),
      ),
    );
    await remoteConfig.fetchAndActivate();
   ip = remoteConfig.getString('HOMECAREURL');
    if (ip == "") {
      ip = 'https://tabibalbait.homecare.ihealthcure.com/';
    }
    // ip = remoteConfig.getString('HOMECAREURLQA');
    // if (ip == "") {
    //   ip = 'http://192.168.88.254:377';
    // }
}


  @override
  void initState() {
    super.initState();
    // instance();
    // instance();
    checkFirstTime();
    

   
    // _animationController = AnimationController(
    //   duration: const Duration(seconds: 5),
    //   vsync: this,
      
     
    
    // );

    // _animation = Tween<Offset>(
    //   begin: const Offset(-1.0, 0.0),
    //   end: const Offset(1.0, 0.0),
    // ).animate(_animationController);

    // Start the logo animation after a delay
    // Future.delayed(const Duration(seconds: 5), () {
    //   _animationController.forward();
    // });

    // _animationController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     WheretoGo(context);
    //   }
    // }
    
    // );
  }
  

  @override
  void dispose() {
    // _animationController.dispose();
   
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          top: 100,
          right: 0,
          child: Container(
            height: Get.height * 0.8,
            width: Get.width,
            alignment: Alignment.centerLeft,
            child: Image.asset(
              Images.logoBackground,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SlideTransitions(
          image: Center(child: Image.asset(Images.logo,height: Get.height*0.1,)),
        )
      ],
    ));
  }
}

Future<void> WheretoGo(BuildContext context) async {
  var sharedpref = await SharedPreferences.getInstance();
  var isLoggedIn = sharedpref.getBool(SplashscreenState.KEYLOGIN);
  
  
  if (isLoggedIn != null && isLoggedIn) {
    String userid=sharedpref.getString('userId').toString();
    String username=sharedpref.getString('username').toString();
    if(userid!="" && username!="")
    {

    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Dashboard(userName:username ,empId: userid)),
    );
    }
    else
    {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Name or userid is not valid")));
    }
  } else  {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
      (Route<dynamic> route) => false,
    );
  }

  
}
Future<int?> getIsOnboarding() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt('initScreen');
  }
  class SlideTransitions extends StatefulWidget {
  final Widget? image;
  const SlideTransitions({super.key, this.image});

  @override
  State<SlideTransitions> createState() => _SlideTransitionsState();
}

class _SlideTransitionsState extends State<SlideTransitions>
    with SingleTickerProviderStateMixin {
 late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 8),
    vsync: this,
  )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
 late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.fastLinearToSlowEaseIn,
  ));
   @override
  void initState() {
    super.initState();
    _controller.forward();
  }
   @override
  void dispose() {
    // _animationController.dispose();
      _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: widget.image,
      ),
    );
  }
    }

