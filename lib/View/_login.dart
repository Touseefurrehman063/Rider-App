import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Repositeries/localdb.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_riderapp/Models/userprofile.dart';
import 'package:flutter_riderapp/View/_dashboard.dart';
import 'package:flutter_riderapp/View/_signup.dart';
import 'package:flutter_riderapp/View/_splash_screen.dart';

import '../Utilities.dart';


class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  User? user;
  bool _obscureText=true;
  
Future<Map<String, dynamic>> login(String userName, String password) async {
  
  var url = '$ip/api/account';
  var headers = {
    'Content-Type': 'application/json',
  };
  String? DeviceToken = await LocalDB().getDeviceToken();
  var body = jsonEncode({
    'username': userName,
    'password': password,
      "DeviceToken": "$DeviceToken",
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
    user=User.fromJson(usr);
    // var sharedpref = await SharedPreferences.getInstance();
    // sharedpref.setString('Token',user!.token.toString());


    userprofile= userProfile.fromJson(responseData);

      print('API Response: $responseData'); 


    if (status != -5) {
      // ignore: use_build_context_synchronously
   
      var empId = responseData['Id'];

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('userId', empId);
        prefs.setString('pass', passwordController.text.toString());
      return {'isLoggedIn': true, 'empId': empId};
      

    } else if (status == -5) {
      return {'isLoggedIn': false, 'empId': null};
    }
  }

  return {'isLoggedIn': false, 'empId': null};
  
}
@override
  void initState() {
    instance();
    super.initState();


  }
  instance() async {
SharedPreferences prefs = await SharedPreferences.getInstance();
 bool value = await prefs.setString('firstapp',"notfirst");
 return value;

  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/helpbackgraound.png'),
            alignment: Alignment.centerLeft,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 120) ,
              child: Image.asset(
                'assets/Helpful.png',
                width: MediaQuery.of(context).size.width/2,
               
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.15,
            ),
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width*0.07,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Welcome to',
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Color(0xFF1272D3),
                          ),
                        ),
                      
                    ),
                    Text(
                    'Helpful',
                    style: GoogleFonts.raleway(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Color(0xFF1272D3),
                      ),
                    
                  ),
                ),
                  ],
                ),
              ],
            ),
            
            
            
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
  child: TextFormField(
    controller: userNameController,
    keyboardType: TextInputType.text,
    style: TextStyle(
      fontSize: 18, // Set the font size
      color: Colors.black, // Set the text color
    ),
    decoration: InputDecoration(
      labelText: 'UserName',
      contentPadding: const EdgeInsets.all(16), // Set the padding
      border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your username';
      }
      return null;
    },
  ),
)
,
                    const SizedBox(height: 10),
                   Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Form(
          child: TextFormField(
            controller: passwordController,
            obscureText: _obscureText,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              fillColor: Colors.transparent,
              filled: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              ),
            ),
            keyboardType: TextInputType.text,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black,
            ),
          ),
        ),
      ),
    
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          
                          var sharedpref=await SharedPreferences.getInstance();
                          sharedpref.setBool(SplashscreenState.KEYLOGIN, true);
                          if (userNameController.text.toString().isNotEmpty && passwordController.text.toString().isNotEmpty) {
                            var loginResult = await login(
                      userNameController.text,
                      passwordController.text,
                    );
                    sharedpref.setString('username', userNameController.text.toString());
                    sharedpref.setString('password', passwordController.text.toString());
                    
                     bool isLoggedIn = loginResult['isLoggedIn'];
                    
                            if (isLoggedIn) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => Dashboard(userName: userNameController.text,empId:loginResult['empId'],
                                user: user,
                            
                              
                               
                                )
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Invalid Username or Password'),
                                  duration: Duration(seconds: 5),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.zero,
                        ),
                        child:  SizedBox(
                          height: MediaQuery.of(context).size.height*0.05,
                          width: MediaQuery.of(context).size.width*0.8,
                          child: const Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Don't Have An Account?"),
                          TextButton(
                            onPressed: () async {
                             Get.to(Signup());
                            },  
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue,
                            ),
                            child: const Text("Register"),
                          ),
                        ],
                      
                    ),
                  ],
                ),
              ),
            ),
            
          ],
          
        ),
      
      ),
      
    );
    
  }
}
 setisOnboarding() async {
    int isviewed = 1;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setInt("initScreen", isviewed);
  }
