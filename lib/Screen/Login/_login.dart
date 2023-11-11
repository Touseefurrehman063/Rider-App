import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Repositeries/authentication.dart';
import 'package:flutter_riderapp/Repositeries/localdb.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_riderapp/Models/userprofile.dart';
import 'package:flutter_riderapp/Screen/Dashboard/_dashboard.dart';
import 'package:flutter_riderapp/Screen/Login/_signup.dart';
import 'package:flutter_riderapp/Screen/Welcome_Screens/_splash_screen.dart';

import '../../Utilities.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = true;
  bool isLoading = false;
  User? user;
  final bool _obscureText = true;

  Future<Map<String, dynamic>> login(String userName, String password) async {
    var url = '$ip/api/account';
    var headers = {
      'Content-Type': 'application/json',
    };
    String? DeviceToken = await LocalDB().getDeviceToken();
    var body = jsonEncode({
      'username': userName,
      'password': password,
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
      user = User.fromJson(usr);
      // var sharedpref = await SharedPreferences.getInstance();
      // sharedpref.setString('Token',user!.token.toString());

      userprofile = userProfile.fromJson(responseData);

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
    call();
    instance();
    super.initState();
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

  call() async {
    SharedPreferences sharedpref = await SharedPreferences.getInstance();
    String? username = sharedpref.getString(
      'riderusername',
    );
    String? riderpassword = sharedpref.getString(
      'riderpassword',
    );

    if (username != null && riderpassword != null) {
      bool auth = await Authentication.authentication();
      if (auth) {
        authentication = await _authenticate();
        if (authentication) {
          fingerprint = authentication;
          //   } else {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(content: Text('You are already Logged in')));
          //     // Utils().toastmessage(“You are already Logged in”);
          //     fingerprint = true;
          //   }
          //   setState(() {});
          // } else {
          // ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //         content: Text(
          //             “You declined the biometric login.“)));
        }
        if (fingerprint) {
          if (authentication) {
            if (userprofile?.id != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('You are already Logged in')));
              setState(() {
                fingerprint = true;
              });
            }
            setState(() {
              userprofile;
            });
          } else {
            // login(username,riderpassword);
            var loginResult = await login(
              username,
              riderpassword,
            );

            bool isLoggedIn = loginResult['isLoggedIn'];

            if (isLoggedIn) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Dashboard(
                          userName: userNameController.text,
                          empId: loginResult['empId'],
                          user: user,
                        )),
              );
            }
            setState(() {});
          }
        }
      } else {
        setState(() {
          fingerprint = false;
        });
      }
    }
  }

  instance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = await prefs.setString('firstapp', "notfirst");
    return value;
  }

  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: formkey,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/helpbackgraound.png'),
                alignment: Alignment.centerLeft,
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/Helpful.png',
                    width: Get.width * 0.4,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.07,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'welcometo'.tr,
                            style: GoogleFonts.raleway(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Color(0xFF1272D3),
                              ),
                            ),
                          ),
                          Text(
                            'helpful'.tr,
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
                  SizedBox(height: Get.height*0.02,),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AuthTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'enterusername'.tr;
                              }
                              return null;
                            },
                            controller: userNameController,
                            hintText: 'username'.tr,
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: AuthTextField(
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter a password'; // You can replace this message with a translated string if needed.
                                }
                                return null;
                              },
                              hintText: 'password'.tr,
                              keyboardType: TextInputType.text,
                              controller: passwordController,
                              obscureText: passwordVisible,
                              suffixIcon: IconButton(
                                icon: Icon(passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: CupertinoButton(
                              color: CupertinoColors.activeBlue,
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  var sharedpref =
                                      await SharedPreferences.getInstance();
                                  sharedpref.setBool(
                                      SplashscreenState.KEYLOGIN, true);
                                  if (userNameController.text
                                          .toString()
                                          .isNotEmpty &&
                                      passwordController.text
                                          .toString()
                                          .isNotEmpty) {
                                    var loginResult = await login(
                                      userNameController.text,
                                      passwordController.text,
                                    );
                                    sharedpref.setString('username',
                                        userNameController.text.toString());
                                    sharedpref.setString('password',
                                        passwordController.text.toString());

                                    bool isLoggedIn = loginResult['isLoggedIn'];

                                    if (isLoggedIn) {
                                      sharedpref.setString('riderusername',
                                          userNameController.text.toString());
                                      sharedpref.setString('riderpassword',
                                          passwordController.text.toString());
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Dashboard(
                                                  userName:
                                                      userNameController.text,
                                                  empId: loginResult['empId'],
                                                  user: user,
                                                )),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text('invalid'.tr),
                                          duration: const Duration(seconds: 5),
                                        ),
                                      );
                                    }
                                  }
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("entervaliddata".tr)));
                                }
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Center(
                                child: Text(
                                  'login'.tr,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.18,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("dontaccount".tr),
                              TextButton(
                                onPressed: () async {
                                  Get.to(const Signup());
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.blue,
                                ),
                                child: Text("register".tr),
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
          ),
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
