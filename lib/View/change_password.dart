import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/Widgets/Utils/toaster.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
 
  const ChangePassword({ super.key});

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
      Showtoaster().classtoaster(message);
  }


Future <void> changepass() async {
  var url = '$ip/api/account/ChangePassword';
  var headers = {
    'Content-Type': 'application/json',
  };
    var sharedpref = await SharedPreferences.getInstance();
   String userid=sharedpref.getString('userId').toString();
  var body = jsonEncode({
    'UserId':userid,
    'OldPassword': oldpass.text.toString(),
    'NewPassword': newpass.text.toString(),
  });

  var response = await http.post(Uri.parse(url), headers: headers, body: body);

  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);
    var status = responseData['Status'];


      print('API Response: $responseData'); 
      if (status==1){
        
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('pass', newpass.text.toString());
      }


   
  }

  
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0.0,
        
        title: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.5,
                                height: MediaQuery.of(context).size.height*0.05,
            
            child: Text("Change Password",style: GoogleFonts.poppins(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 20),)),
        ),
    leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios_new,color: Color(0xff0F64C6),)),
      
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
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120),
              child: Image.asset(
                'assets/Helpful.png',
                width: MediaQuery.of(context).size.width / 1,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              children: [
                SizedBox(width: MediaQuery.of(context).size.width * 0.07),
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
                      'Tabib AlBait',
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
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: FractionallySizedBox(
                              widthFactor: 1,
                              child: TextFormField(
                                obscureText: _Password_Visible,
                                controller: oldpass,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                  labelText: 'Enter old Password',
                                  suffixIcon: IconButton(
                                    icon: Icon(_Password_Visible ? Icons.visibility : Icons.visibility_off),
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
                                    return 'Please enter old password';
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
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                labelText: 'Enter New Password',
                                suffixIcon: IconButton(
                                  icon: Icon(PasswordVisible ? Icons.visibility : Icons.visibility_off),
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
                                  return 'Please enter new password';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              obscureText: _PasswordVisible,
                              controller: confirmnewpass,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                                labelText: 'Confirm new Password',
                                suffixIcon: IconButton(
                                  icon: Icon(_PasswordVisible ? Icons.visibility : Icons.visibility_off),
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
                                  return 'Please confirm new password';
                                }
                                if (!isPasswordMatch()) {
                                  return 'Passwords do not match';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height*0.1,
                    ),
                    if (!isPasswordMatch())
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Passwords do not match!',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      child: ElevatedButton(
                        onPressed: () async{
                          if (_formKey.currentState!.validate()) {
                               try {
                await changepass().then((value) {
                  _showSnackBar('Password changed successfully');
                Future.delayed(const Duration(seconds: 3), () {
                  Navigator.pop(context);
                  
                });
                },);
                
              } catch (e) {
                _showSnackBar('Failed to change password');
              }
                            // Form is valid, proceed with your logic here
                          }
                          
                          changepass();
                          
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: const Center(
                            child: Text(
                              'Submit',
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
