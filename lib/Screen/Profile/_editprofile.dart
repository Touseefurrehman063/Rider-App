// ignore_for_file: unused_element, avoid_print, use_build_context_synchronously, non_constant_identifier_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Models/userprofile.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/Widgets/Custombutton.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widgets/CustomFormField.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController fname = TextEditingController();
  TextEditingController phoneno = TextEditingController();
  User? user;

  FocusNode focusNode = FocusNode();
  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  PickedFile? pickedFile;
  // ignore: unused_field
  bool _isBottomSheetVisible = false;
  void _showBottomSheet() {
    setState(() {
      _isBottomSheetVisible = true;
    });
  }

  void _hideBottomSheet() {
    setState(() {
      _isBottomSheetVisible = false;
    });
  }

  Future<String> uploadPicture(XFile file) async {
    String r = '';
    var url = '$ip/api/account/UploadPicture';

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('image', file.path));

    final res = await request.send();

    if (res.statusCode == 200) {
      dynamic data = jsonDecode(await res.stream.bytesToString());
      r = data["Path"];

      // print('Upload success: ');
    } else {
      // print('Upload failed with status ${res.statusCode}');
    }

    return r;
  }

  Future<void> updateaccount() async {
    var url = '$ip/api/account/UpdateRiderProfile';
    var headers = {
      'Content-Type': 'application/json',
    };
    var sharedpref = await SharedPreferences.getInstance();
    String userid = sharedpref.getString('userId').toString();

    var body = jsonEncode({
      'Id': userid,
      'FullName': fname.text.toString(),
      'MobileNo': phoneno.text.toString()
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);

    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var status = responseData['Status'];
      // print(responseData);
      dynamic usr = responseData;
      user = User.fromJson(usr);

      // print('API Response: $responseData');
      if (status == 1) {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xff0F64C6),
            )),
        title: Text(
          'Edit Profile',
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
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 35),
            child: Row(
              children: [
                SizedBox(
                  width: 140,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ImageProfile(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  //  height: MediaQuery.of(context).size.height*0.08,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: customFormField(
                      hinttext: " Full Name",
                      val: fname.text.toString(),
                      controller: fname,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: IntlPhoneField(
                    initialCountryCode: 'SA',
                    focusNode: focusNode,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: ' Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    languageCode: "en",
                    onChanged: (phone) {
                      // print(phone.completeNumber);
                      phoneno.text = phone.number.toString();
                    },
                    onCountryChanged: (country) {
                      // print('Country changed to: ${country.name}');
                      print(phoneno.text);
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please enter a valid number';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                CustomButton(
                  onPressed: () async {
                    String str = await uploadPicture(_imageFile!);
                    userProfile update = userProfile();
                    update.fullName = fname.text.toString();
                    update.cellNumber = phoneno.text.toString();
                    update.imagePath =
                        str.toString().split('=')[1].split('"')[0];

                    await updateaccount();
                    userprofile!.fullName = fname.text.toString();
                    userprofile!.cellNumber = phoneno.text.toString();
                    userprofile!.imagePath =
                        str.toString().split('=')[1].split('"')[0];
                    Navigator.pop(context);
                  },
                  title: "Update ",
                  radius: 20,
                  style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  primcolor: const Color(0xFF1272D3),
                  width: MediaQuery.of(context).size.width * 0.8,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile Photo",
            style: GoogleFonts.raleway(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.camera),
                onPressed: () {
                  TakePhoto(ImageSource.camera);
                  Navigator.pop(context);
                },
                label: Text(
                  "camera",
                  style: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
              TextButton.icon(
                icon: const Icon(Icons.image),
                onPressed: () async {
                  TakePhoto(ImageSource.gallery);
                  Navigator.pop(context);
                },
                label: Text(
                  "Gallery",
                  style: GoogleFonts.raleway(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void TakePhoto(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    } else {
      // Handle the case when the user cancels the image selection
      // or if there was an error while picking the image.
    }
  }

  Widget ImageProfile() {
    return Stack(
      children: <Widget>[
        CircleAvatar(
            radius: 60.0,
            backgroundImage: _imageFile == null
                ? const AssetImage("assets/pp.jpg")
                : FileImage(File(_imageFile!.path)) as ImageProvider),
        Positioned(
          bottom: 2.0,
          right: 3.0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: (builder) => bottomsheet());
            },
            child: const Icon(
              Icons.camera_alt,
              color: Colors.blue,
              size: 28.0,
            ),
          ),
        )
      ],
    );
  }
}
