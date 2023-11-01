import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riderapp/Models/countrymodel.dart';
import 'package:flutter_riderapp/Models/statemodel.dart';
import 'package:flutter_riderapp/Widgets/custom_dropdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riderapp/Models/Register.dart';
import 'package:flutter_riderapp/Models/city.dart';
import 'package:flutter_riderapp/Models/gender.dart';
import 'package:flutter_riderapp/Models/vehicle.dart';
// ignore: unused_import
import 'package:flutter_riderapp/Screen/Login/_login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riderapp/Screen/Login/_registered.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image/image.dart' as img;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  vehicle? Vehicle;

  late File _heicImage;
  String hintText = "";
  String? countryCode;

  Future convertImage() async {
    final imageData = await _heicImage.readAsBytes();
    final image = img.decodeImage(imageData);
    final jpegImage = img.encodeJpg(image!);

    final file = await _heicImage.copy('${_heicImage.path}.jpeg');
    await file.writeAsBytes(jpegImage);

    setState(() {
      _heicImage = file;
    });
  }

  DateTime dateTime = DateTime.now();
  final dateFormat = DateFormat('yyyy-MM-dd');
  DateTime selectedDate = DateTime.now();

  TextEditingController Name = TextEditingController();
  TextEditingController mobile_number = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController datetimecontroller = TextEditingController();
  final TextEditingController gvt_id = TextEditingController();
  final MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: 'XXX-XXXX-XXXXXXXX-X',
    filter: {"X": RegExp(r'[0-9]')},
  );
  TextEditingController v_type = TextEditingController();
  TextEditingController L_No = TextEditingController();
  TextEditingController Password = TextEditingController();
  TextEditingController Re_Password = TextEditingController();
  TextEditingController City = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController v_number = TextEditingController();

// final GlobalKey _dropdownKey = GlobalKey();

  bool passwordVisible = true;
  bool PasswordVisible = true;
  bool registered = false;
  FocusNode focusNode = FocusNode();

  final formkey = GlobalKey<FormState>();
  bool passToggle = true;

  bool isPasswordMatch() {
    String password = Password.text;
    String rePassword = Re_Password.text;
    return password == rePassword;
  }

  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  PickedFile? pickedFile;
  // bool passwordVisible=false;
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

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
        value: null,
        child: Text("   Gender"),
      ),
      const DropdownMenuItem(value: "Male", child: Text(" Male")),
      const DropdownMenuItem(value: "Female", child: Text("  Female")),
    ];
    return menuItems;
  }

  List<DropdownMenuItem<String>> get vehicleItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
        value: null,
        child: Text("  Vehicle Type"),
      ),
      const DropdownMenuItem(value: "Car", child: Text("  Car")),
      const DropdownMenuItem(value: "Bike", child: Text("  Bike")),
    ];
    return menuItems;
  }

  String? selectedGender;
  String? selectedVehicle;
  String? selectedCity;
  String? selectedCountries;
  String? SelectedState;
  String? selectedCountriesName;
  String? selectedCityName;
  String? SelectedStateName;

  List<String> cityNameArray = ['Select Vehicle'];
  List<CityModel> cities = [];
  Future<void> cityapi(String id) async {
    final url = '$ip/api/ddl/GetCities';
    final headers = {'Content-Type': 'application/json'};

    try {
      var body = {
        "StateORProvinceId": id,
      };
      print('To post Body of City API : $body');
      print('To post headers of City API : $headers');
      var response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print((data['Status'] == 1 &&
            data['Status'] != null &&
            data['Data'] != null));
        if (data['Status'] != null &&
            data['Status'] == 1 &&
            data['Data'] != null) {
          for (var cityData in data['Data']) {
            cities.add(CityModel.fromJson(cityData));
          }
          List<String> selectedCity = ['Select City'];

          setState(() {
            cityNameArray = selectedCity;
          });
        }
      } else {
        throw Exception('Failed to fetch data from the server.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  List<String> genderNameArray = ['Select gender'];
  List<int> genderIdArray = [];
  List<Gender> gender = [];

  Future<void> genderapi() async {
    final url = '$ip/api/RiderRegistrationRequest/GetGenders';
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['Status'] != null &&
            data['Status'] == 1 &&
            data['Data'] != null) {
          for (var genderData in data['Data']) {
            gender.add(Gender.fromJson(genderData));
          }

          List<String> selectedGender = ['Select Gender'];

          setState(() {
            vechilesNameArray = selectedGender;
          });
        }
      } else {
        throw Exception('Failed to fetch data from the server.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

//vehicle api
  List<String> vechilesNameArray = ['Select Vehicle'];
  List<int> vechileIdArray = [];
  List<vehicle> vehicles = [];

  Future<void> vehicleapi() async {
    final url = '$ip/api/RiderRegistrationRequest/GetVehicleTypes';
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['Status'] != null &&
            data['Status'] == 1 &&
            data['Results'] != null) {
          for (var vehicleData in data['Results']) {
            vehicles.add(vehicle.fromJson(vehicleData));
          }

          List<String> selectedVehicle = ['Select Vehicle'];

          setState(() {
            vechilesNameArray = selectedVehicle;
          });
        }
      } else {
        throw Exception('Failed to fetch data from the server.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  List<String> countryNameArray = ['Select country'];
  List<CountryModel> countries = [];
  Future<void> countriesapi() async {
    final url = '$ip/api/ddl/GetCountries';
    final headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.get(Uri.parse(url), headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        print('Body is : ${response.body}');
        final data = jsonDecode(response.body);
        if (data['Status'] != null &&
            data['Status'] == 1 &&
            data['Data'] != null) {
          for (var countryData in data['Data']) {
            countries.add(CountryModel.fromJson(countryData));
          }

          List<String> selectedCountries = ['Select Country'];

          setState(() {
            countryNameArray = selectedCountries;
          });
        }
      } else {
        throw Exception('Failed to fetch data from the server.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  List<String> stateNameArray = ['Select State'];
  List<StateModel> state = [];
  Future<void> stateapi(String id) async {
    final url = '$ip/api/ddl/GetStateOrProvinces';
    var headers = {
      'Content-Type': 'application/json',
    };

    try {
      var body = {
        "CountryId": id,
      };
      print(body);
      print(headers);
      var response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data);
        if (data['Status'] != null &&
            data['Status'] == 1 &&
            data['Data'] != null) {
          for (var stateData in data['Data']) {
            state.add(StateModel.fromJson(stateData));
          }

          List<String> selectedState = ['Select State'];

          setState(() {
            stateNameArray = selectedState;
          });
        }
      } else {
        throw Exception('Failed to fetch data from the server.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> _register_api(Register register) async {
    var url = '$ip/api/RiderRegistrationRequest/SubmitRegistrationRequest';
    var headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(register.toJson()));
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      setState(() {});
      var data = jsonDecode(response.body);
      print("Response data: $data");

      // ignore: unused_local_variable
      var status = data["Status"];
    } else {
      throw Exception('Failed to end ride');
    }
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

      print('Upload success: ');
    } else {
      print('Upload failed with status ${res.statusCode}');
    }

    return r;
  }

  @override
  void initState() {
    // cityapi();
    genderapi();
    countriesapi();
    vehicleapi();
    // datetimecontroller.text = "Date of Birth";

    super.initState();
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
              onTap: () {
                Get.back();
              },
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
        title: SizedBox(
          height: MediaQuery.of(context).size.height * 0.065,
          child: Image.asset(
            'assets/Helpful.png',
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formkey,
            child: Container(
              // height: MediaQuery.of(context).size.height,
              // width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/helpbackgraound.png'),
                  alignment: Alignment.centerLeft,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          'registernow'.tr,
                          style: GoogleFonts.raleway(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Color(0xFF1272D3),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: ImageProfile(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          AuthTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'entername'.tr;
                              }
                              return null;
                            },
                            controller: Name,
                            hintText: 'fullname'.tr,
                          ),

                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          SizedBox(
                            height: Get.height * 0.075,
                            child: IntlPhoneField(
                              controller: mobile_number,
                              disableLengthCheck: true,
                              initialCountryCode: 'SA',
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                disabledBorder: const OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey)),
                              ),
                              languageCode: "en",
                              onSaved: (newValue) {},
                              onSubmitted: (p0) {
                                mobile_number.text = p0;
                              },
                              onCountryChanged: (country) {
                                setState(() {
                                  countryCode = country.dialCode;
                                });
                              },
                              validator: (value) {
                                if (!value!.isValidNumber()) {
                                  return 'entervalidno'.tr;
                                }
                                return null;
                              },
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          AuthTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'enteremail'.tr;
                              }
                              return null;
                            },
                            controller: email,
                            hintText: 'email'.tr,
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),

                          AuthTextField(
                            readOnly: true,
                            controller: datetimecontroller,
                            validator: (value) {
                              return null;
                            },
                            hintText: selectedDate == null
                                ? "dob".tr
                                : DateFormat('dd-M-yyyy').format(selectedDate),
                            suffixIcon: IconButton(
                              onPressed: () async {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext context) => Center(
                                    child: SizedBox(
                                      height: 200,
                                      child: CupertinoDatePicker(
                                        backgroundColor: Colors.white,
                                        initialDateTime:
                                            selectedDate ?? DateTime.now(),
                                        onDateTimeChanged: (DateTime newTime) {
                                          setState(() {
                                            selectedDate = newTime;
                                            datetimecontroller.text =
                                                DateFormat('dd-M-yyyy')
                                                    .format(newTime);
                                          });
                                        },
                                        use24hFormat: true,
                                        mode: CupertinoDatePickerMode.date,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ),

                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height * 0.088,
                          //   child: Padding(
                          //     padding:
                          //         const EdgeInsets.symmetric(horizontal: 20),
                          //     child: CupertinoTextField(
                          //       readOnly: true,
                          //       controller: datetimecontroller,
                          //       decoration: BoxDecoration(
                          //         border: Border.all(
                          //           color: Colors.black54,
                          //           width: 1.0,
                          //         ),
                          //         borderRadius: BorderRadius.circular(10),
                          //         color: Colors.transparent,
                          //       ),
                          //       prefix: const Padding(
                          //         padding: EdgeInsets.only(left: 20),
                          //         child: Icon(
                          //           CupertinoIcons.calendar,
                          //           color: CupertinoColors.black,
                          //         ),
                          //       ),
                          //       onTap: () {
                          //         showCupertinoModalPopup(
                          //           context: context,
                          //           builder: (BuildContext context) => Center(
                          //             child: SizedBox(
                          //               height: 200,
                          //               child: CupertinoDatePicker(
                          //                 backgroundColor: Colors.white,
                          //                 initialDateTime:
                          //                     selectedDate ?? DateTime.now(),
                          //                 onDateTimeChanged:
                          //                     (DateTime newTime) {
                          //                   setState(() {
                          //                     selectedDate = newTime;
                          //                     datetimecontroller.text =
                          //                         '${newTime.day.toString().padLeft(2, '0')}-${newTime.month.toString().padLeft(2, '0')}-${newTime.year}';
                          //                   });
                          //                 },
                          //                 use24hFormat: true,
                          //                 mode: CupertinoDatePickerMode.date,
                          //               ),
                          //             ),
                          //           ),
                          //         );
                          //       },
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),

                          InkWell(
                            onTap: () async {
                              selectedGender = null;
                              gender.clear();
                              await genderapi();
                              setState(() {});
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 1),
                              child: DropdownButtonFormField(
                                  decoration: checkval
                                      ? InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.black)),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 12,
                                                  vertical: 10),
                                        )
                                      : InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.black)),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 14,
                                                  vertical: 10),
                                        ),
                                  value: selectedGender,
                                  hint:  Text(
                                    'gender'.tr,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 10),
                                  ),
                                  items: gender
                                      .map<DropdownMenuItem<String>>(
                                          (Gender val) {
                                    return DropdownMenuItem<String>(
                                      
                                      value: val.id,
                                      child: Text(val.name.toString()),
                                    );
                                  }).toList(),
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 14),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedGender = newValue;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'selectgender'.tr;
                                    } else {
                                      return null;
                                    }
                                  }),
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          AuthTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'enterid'.tr;
                              }
                              return null;
                            },
                            controller: gvt_id,
                            hintText: 'nationalid'.tr,
                          ),

                          // Padding(
                          //  padding: const EdgeInsets.symmetric(horizontal: 20),
                          //   child:  customFormField(hinttext: "  ID 123-4567-8910"
                          //   ,

                          //  controller: gvt_id,

                          //   ),
                          // ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),

                          InkWell(
                            onTap: () async {
                              selectedVehicle = null;
                              vehicles.clear();
                              await vehicleapi();
                              setState(() {});
                            },
                            child: DropdownButtonFormField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        width: 1, color: Colors.black)),
                                contentPadding: checkval
                                    ? const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 12)
                                    : const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 10),
                              ),
                              value: selectedVehicle,
                              hint:  Text(
                                "vehicletype".tr,
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 10),
                              ),
                              items: vehicles.map<DropdownMenuItem<String>>(
                                  (vehicle val) {
                                return DropdownMenuItem<String>(
                                  value: val.id,
                                  child: Text(val.name.toString()),
                                );
                              }).toList(),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 14),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedVehicle = newValue;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'selectgender'.tr;
                                } else {
                                  return null;
                                }
                              },
                              elevation: 0,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),

                          AuthTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'entervehicle'.tr;
                              }
                              return null;
                            },
                            controller: v_number,
                            hintText: 'vehicleno'.tr,
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          AuthTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'enterliscenceno'.tr;
                              }
                              return null;
                            },
                            controller: L_No,
                            hintText: 'liscenceno'.tr,
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 1),
                            child: AuthTextField(
                              hintText: 'password'.tr,
                              keyboardType: TextInputType.text,
                              controller: Password,
                              obscureText: PasswordVisible,
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
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          AuthTextField(
                            hintText: 'repassword'.tr,
                            keyboardType: TextInputType.text,
                            controller: Re_Password,
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
                            validator: (value) {
                              if (Re_Password.text == value) {
                                return null;
                              } else {
                                return 'passnotmatch'.tr;
                              }
                            },
                            function: (value) {},
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),

                          InkWell(
                            onTap: () async {
                              selectedCountries = null;
                              countries.clear();
                              await countriesapi();
                              setState(() {});
                              dynamic generic = await searchableDropdown(
                                  context, constraints, countries);
                              selectedCountriesName = null;
                              if (generic != null && generic != '') {
                                print('Countries selected Id' + generic.id);
                                selectedCountries = generic.id;
                                selectedCountriesName =
                                    (generic.name == '') ? null : generic.name;
                                state.clear();
                                cities.clear();
                                await stateapi(generic.id);
                                selectedCity = null;
                                selectedCityName = null;
                                SelectedState = null;
                                SelectedStateName = null;
                                setState(() {});
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.height *
                                          0.001),
                              child: Container(
                                
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.8),
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.transparent,
                                ),
                                 width: MediaQuery.of(context).size.width * 0.9,
                              height:MediaQuery.of(context).size.height * 0.07,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        //"${selectedCountriesName?? "Country"}",
                                        "${(selectedCountriesName != null) ? (selectedCountriesName!.length > 30 ? ('${selectedCountriesName!.substring(0, 30)}...') : selectedCountriesName) : "country".tr}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: selectedCountriesName != null
                                                ? Colors.black
                                                : Colors.grey),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        size: 20,
                                        color: selectedCountriesName != null
                                            ? Colors.black
                                            : Colors.black,
                                      )
                                      
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),

                          InkWell(
                            onTap: () async {
                              SelectedState = null;
                              setState(() {});
                              dynamic generic = await searchableDropdown(
                                  context, constraints, state);
                              SelectedStateName = null;
                              if (generic != null && generic != '') {
                                SelectedState = generic.id;
                                SelectedStateName =
                                    (generic.name == '') ? null : generic.name;
                                cities.clear();
                                selectedCity = null;
                                selectedCityName = null;
                                await cityapi(generic.id);
                              }
                              setState(() {});
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width *
                                          0.001),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.8),
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.transparent,
                                ),
                                    width: MediaQuery.of(context).size.width * 0.9,
                              height:MediaQuery.of(context).size.height * 0.065,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        // "${SelectedStateName?? "State"}",
                                        "${(SelectedStateName != null) ? (SelectedStateName!.length > 15 ? ('${SelectedStateName!.substring(0, 15)}...') : SelectedStateName) : "state".tr}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: SelectedStateName != null
                                                ? Colors.black
                                                : Colors.grey),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        size: 20,
                                        color: SelectedStateName != null
                                            ? Colors.black
                                            : Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),

                          InkWell(
                            onTap: () async {
                              selectedCity = null;
                              // cities.clear();
                              setState(() {});
                              dynamic generic = await searchableDropdown(
                                  context, constraints, cities);
                              selectedCityName = null;
                              if (generic != null && generic != '') {
                                selectedCity = generic.id;
                                selectedCityName =
                                    (generic.name == '') ? null : generic.name;
                              }
                              setState(() {});
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width *
                                          0.001),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey, width: 0.8),
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.transparent,
                                ),
                                  width: MediaQuery.of(context).size.width * 0.9,
                              height:MediaQuery.of(context).size.height * 0.065,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.05),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        // "${selectedCityName?? "City"}",
                                        "${(selectedCityName != null) ? (selectedCityName!.length > 30 ? ('${selectedCityName!.substring(0, 30)}...') : selectedCityName) : "city".tr}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: selectedCityName != null
                                                ? Colors.black
                                                : Colors.grey),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        size: 20,
                                        color: selectedCityName != null
                                            ? Colors.black
                                            : Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          AuthTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'enteraddress'.tr;
                              }
                              return null;
                            },
                            controller: Address,
                            hintText: 'address'.tr,
                          ),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          CupertinoButton(
                              color: CupertinoColors.activeBlue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 120, vertical: 0.5),
                              borderRadius: BorderRadius.circular(8),
                              onPressed: () async {
                                String str = "";
                                if (_imageFile != null) {
                                  str = await uploadPicture(_imageFile!);
                                }

                                if (formkey.currentState!.validate()) {
                                  if (Password.text.toString() ==
                                      Re_Password.text.toString()) {
                                    Register register = Register();
                                    register.fullName = Name.text.toString();
                                    register.mobileNo =
                                        mobile_number.text.toString();
                                    register.email = email.text.toString();
                                    register.dateOfBirth = dateTime.toString();
                                    register.genderId =
                                        selectedGender.toString();
                                    register.identityNo =
                                        gvt_id.text.toString();
                                    register.vehicleTypeId =
                                        selectedVehicle.toString();
                                    register.vehicleNumber =
                                        v_number.text.toString();
                                    register.licenseNo = L_No.text.toString();
                                    register.password =
                                        Password.text.toString();
                                    register.password =
                                        Re_Password.text.toString();
                                    register.cityId = selectedCity.toString();
                                    register.address = Address.text.toString();
                                    str != ""
                                        ? register.profilePictureImagePath = str
                                            .toString()
                                            .split('=')[1]
                                            .split('"')[0]
                                        : "";

                                    await _register_api(register);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: ((context) {
                                        return const Registered();
                                      })),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                         SnackBar(
                                            content: Text(
                                                "passnotmatch".tr)));
                                  }

                                  checkval = true;
                                  setState(() {});
                                } else {
                                  checkval = false;
                                  setState(() {});
                                  ScaffoldMessenger.of(context).showSnackBar(
                                       SnackBar(
                                          content: Text(
                                              "entervaliddata".tr)));
                                }
                              },
                              child: Text(
                                "register".tr,
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.white),
                              )),

                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                Text("alreadyhaveacount".tr),
                              TextButton(
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: ((context) {
                                      return const Login();
                                    })),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.blue,
                                ),
                                child:  Text("signin".tr),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      }),
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
                onPressed: () {
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
        _heicImage = File(pickedFile.path);
        _imageFile = pickedFile;
      });
    } else {}
  }

  bool checkval = true;

  Widget ImageProfile() {
    return Stack(
      children: <Widget>[
        CircleAvatar(
            radius: 50.0,
            backgroundImage: _imageFile == null
                ? const AssetImage("assets/pp.jpg")
                : FileImage(File(_imageFile!.path)) as ImageProvider),
        Positioned(
          bottom: 5.0,
          right: 5.0,
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

  String validatorforformfield = "";
}

class AuthTextField extends StatelessWidget {
  final Function(String)? function;
  final bool? obscureText;
  final List<TextInputFormatter>? formatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? readOnly;
  const AuthTextField({
    super.key,
    this.hintText,
    this.suffixIcon,
    this.controller,
    this.validator,
    this.readOnly,
    this.formatters,
    this.obscureText,
    this.keyboardType,
    this.function,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: function,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      inputFormatters: formatters,
      readOnly: readOnly ?? false,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
          errorStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.red, fontSize: 12),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 12),
          disabledBorder: const OutlineInputBorder(),
          errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey)),
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey))),
    );
  }
}
