import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Screen/Login/_login.dart';
import 'package:flutter_riderapp/Screen/Welcome_Screens/_splash_screen.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController oldpass = TextEditingController();
  TextEditingController newpass = TextEditingController();
  TextEditingController confirmnewpass = TextEditingController();
  bool PasswordVisible = true;
  bool _PasswordVisible = true;
  bool _Password_Visible = true;

  bool isPasswordMatch() {
    String password = newpass.text;
    String rePassword = confirmnewpass.text;
    return password == rePassword;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  Future<bool> changepass() async {
    var url = '$ip/api/account/ChangePassword';
    var headers = {
      'Content-Type': 'application/json',
    };
    var sharedpref = await SharedPreferences.getInstance();
    String userid = sharedpref.getString('userId').toString();
    var body = jsonEncode({
      'UserId': userid,
      'OldPassword': oldpass.text.toString(),
      'NewPassword': newpass.text.toString(),
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var status = responseData['Status'];

      print('API Response: $responseData');
      if (status == 1) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('pass', newpass.text.toString());
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Row(
          children: [
            InkWell(
              onTap: Get.back,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Image.asset(
                  "assets/back.png",
                  height: Get.height * 0.1,
                  width: Get.width * 0.08,

                  // color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        title: Text(
          'changepassword'.tr,
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            height: 1.175,
            color: const Color(0xFF1272D3),
          ),
        ),
        centerTitle: true,
      ),
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
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 120),
            //   child: Image.asset(
            //     'assets/Helpful.png',
            //     width: MediaQuery.of(context).size.width / 1,
            //   ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.07),
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
                      'aria'.tr,
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
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: FractionallySizedBox(
                              widthFactor: 1,
                              child: TextFormField(
                                obscureText: _Password_Visible,
                                controller: oldpass,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  labelText: 'oldpassword'.tr,
                                  labelStyle: const TextStyle(color: Colors.grey),
                                  suffixIcon: IconButton(
                                    icon: Icon(_Password_Visible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _Password_Visible = !_Password_Visible;
                                      });
                                    },
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'pleaseoldpassword'.tr;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              obscureText: PasswordVisible,
                              controller: newpass,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'newpassword'.tr,
                                labelStyle: const TextStyle(color: Colors.grey),
                                
                                suffixIcon: IconButton(
                                  icon: Icon(PasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      PasswordVisible = !PasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'pleasenewpassword'.tr;
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              obscureText: _PasswordVisible,
                              controller: confirmnewpass,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                labelText: 'confirmpassword'.tr,
                                labelStyle: const TextStyle(color: Colors.grey),
                                suffixIcon: IconButton(
                                  icon: Icon(_PasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    setState(() {
                                      _PasswordVisible = !_PasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'pleaseconfirmpassword'.tr;
                                }
                                if (!isPasswordMatch()) {
                                  return 'passwordnotmatch'.tr;
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    if (!isPasswordMatch())
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          '',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            bool success = await changepass();
                            if (success) {
                              _showSnackBar('passwordsuccess'.tr);
                              Future.delayed(const Duration(seconds: 3), () {
                                logout(context);
                              });
                            } else {
                              _showSnackBar('passwordfailed'.tr);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Center(
                            child: Text(
                              'submit'.tr,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
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

void logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(SplashscreenState.KEYLOGIN, false);
  prefs.clear();
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const Login()),
    (Route<dynamic> route) => false,
  );
}
}
