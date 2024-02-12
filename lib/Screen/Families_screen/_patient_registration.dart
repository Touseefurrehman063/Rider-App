// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/countrymodel.dart';
import 'package:flutter_riderapp/Models/nok_model.dart';
import 'package:flutter_riderapp/Models/patient_registration-model.dart';
import 'package:flutter_riderapp/Models/relations.dart';
import 'package:flutter_riderapp/Models/statemodel.dart';
import 'package:flutter_riderapp/Screen/Login/_signup.dart';
import 'package:flutter_riderapp/Screen/register_patient/register_patient.dart';
import 'package:flutter_riderapp/Widgets/Utils/toaster.dart';
import 'package:flutter_riderapp/Widgets/custom_dropdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riderapp/Models/city.dart';
import 'package:flutter_riderapp/Models/gender.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';

class PatientRegistration extends StatefulWidget {
  const PatientRegistration({super.key});

  @override
  State<PatientRegistration> createState() => _PatientRegistrationState();
}

class _PatientRegistrationState extends State<PatientRegistration> {
  DateTime dateTime = DateTime.now();
  final dateFormat = DateFormat('yyyy-MM-dd');
  DateTime selectedDate = DateTime.now();

  // ignore: non_constant_identifier_names
  TextEditingController Name = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController mobile_number = TextEditingController();
  TextEditingController email = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController gvt_id = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController City = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController Address = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController v_number = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController GuardianName = TextEditingController();
  // ignore: non_constant_identifier_names
  TextEditingController NOKName = TextEditingController();
  // ignore: non_constant_identifier_names
  final TextEditingController gvt_guardian_id = TextEditingController();
  TextEditingController datetimecontroller = TextEditingController();

// final GlobalKey _dropdownKey = GlobalKey();

  bool registered = false;
  FocusNode focusNode = FocusNode();

  final formkey = GlobalKey<FormState>();
  bool passToggle = true;

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
        value: null,
        child: Text("   gender".tr),
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
  String? selectedRelation;
  String? selectedNOK;
  String? selectedNOKName;
  String? selectedCountriesName;
  String? selectedCountries;
  // ignore: non_constant_identifier_names
  String? SelectedState;
  String? countryCode;
  String? selectedCityName;
  bool chk = false;
  // ignore: non_constant_identifier_names
  String? SelectedStateName;

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
            genderNameArray = selectedGender;
          });
        }
      } else {
        throw Exception('Failed to fetch data from the server.');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
  }

// city api
  List<String> cityNameArray = ['Select Vehicle'];
  List<CityModel> cities = [];
  Future<void> cityapi() async {
    final url = '$ip/api/RiderRegistrationRequest/GetCitiesIndependently';
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['Status'] != null &&
            data['Status'] == 1 &&
            data['Results'] != null) {
          for (var cityData in data['Results']) {
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
      // ignore: avoid_print
      print('Error: $e');
    }
  }

// Relation api
  List<String> relationNameArray = ['Select Relation'];
  List<RelationModel> relations = [];
  Future<void> relationapi() async {
    final url = '$ip/api/ddl/GetRelationshipTypes';
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // ignore: avoid_print
        print(data);
        if (data['Status'] != null &&
            data['Status'] == 1 &&
            data['Data'] != null) {
          for (var relationData in data['Data']) {
            relations.add(RelationModel.fromJson(relationData));
          }

          List<String> selectedRelation = ['Select Relation'];

          setState(() {
            relationNameArray = selectedRelation;
          });
        }
      } else {
        throw Exception('Failed to fetch data from the server.');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
  }

  List<String> countryNameArray = ['Select country'];
  List<CountryModel> countries = [];
  Future<void> countriesapi() async {
    final url = '$ip/api/ddl/GetCountries';
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
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
      // ignore: avoid_print
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
      // ignore: avoid_print
      print('Error: $e');
    }
  }

  Future<void> _register_api(PatientRegistrationModal patientregister) async {
    var url = '$ip/api/SignUp';
    var headers = {
      'Content-Type': 'application/json',
    };

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(patientregister.toJson()));

    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      setState(() {});
      var data = jsonDecode(response.body);

      print("Response data: $data");

      var status = data["Status"];
    } else {
      throw Exception('Failed to Register Patient');
    }
  }

//  NOKModel testing= NOKModel(id: '84385',name: 'attiq testing');

// NOK api
  // ignore: non_constant_identifier_names
  List<String> NOKNameArray = ['Select Relation'];
  // ignore: non_constant_identifier_names
  List<NOKModel> NOK = [];
  // ignore: non_constant_identifier_names
  Future<void> NOKapi() async {
    //  NOK.add(testing);
    setState(() {});
    final url = '$ip/api/ddl/GetNOKRelations';
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // ignore: avoid_print
        print(data);
        if (data['Status'] != null &&
            data['Status'] == 1 &&
            data['Data'] != null) {
          for (var relationData in data['Data']) {
            NOK.add(NOKModel.fromJson(relationData));
          }
          List<String> selectedNOK = ['Select Relation'];

          setState(() {
            NOKNameArray = selectedNOK;
          });
        }
      } else {
        throw Exception('Failed to fetch data from the server.');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error: $e');
    }
  }

  @override
  void initState() {
    // cityapi();
    genderapi();
    countriesapi();
    relationapi();
    NOKapi();
    // vehicleapi();

    super.initState();
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
            'registration'.tr,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                              height: Get.height * 0.07,
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
                                      borderSide:
                                          BorderSide(color: Colors.grey)),
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

                            mobile_number.text.isEmpty && chk == true
                                ? SizedBox(
                                    child: Column(
                                      children: [
                                        SizedBox(height: Get.height * 0.01),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Get.width * 0.05),
                                              child: Text(
                                                "entervalidno".tr,
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                  // fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
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
                            InkWell(
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: selectedDate ?? DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime.now(),
                                );

                                if (pickedDate != null &&
                                    pickedDate != selectedDate) {
                                  setState(() {
                                    selectedDate = pickedDate;
                                    datetimecontroller.text =
                                        DateFormat('dd-M-yyyy')
                                            .format(pickedDate);
                                  });
                                }
                              },
                              child: SizedBox(
                                child: AuthTextField(
                                  readOnly: false,
                                  controller: datetimecontroller,
                                  validator: (p0) {
                                    if (p0!.isEmpty) {
                                      return 'selectdob'.tr;
                                    }
                                    return null;
                                  },
                                  hintText: datetimecontroller.text.isEmpty
                                      ? "dob".tr
                                      : DateFormat('dd-M-yyyy')
                                          .format(selectedDate),
                                  suffixIcon: IconButton(
                                    onPressed: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate:
                                            selectedDate ?? DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                      );

                                      if (pickedDate != null &&
                                          pickedDate != selectedDate) {
                                        setState(() {
                                          selectedDate = pickedDate;
                                          datetimecontroller.text =
                                              DateFormat('dd-M-yyyy')
                                                  .format(pickedDate);
                                        });
                                      }
                                    },
                                    icon: const Icon(Icons.calendar_month),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),

                            InkWell(
                              onTap: () async {
                                selectedGender = null;
                                gender.clear();
                                await genderapi();
                                setState(() {});
                                dynamic generic = await searchableDropdown(
                                    context, constraints, gender);
                                if (generic != null && generic != '') {
                                  setState(() {
                                    selectedGender = generic.id;
                                  });
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                child: Container(
                                  decoration: checkval
                                      ? BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 0.8),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.transparent,
                                        )
                                      : BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 0.8),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.transparent,
                                        ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: MediaQuery.of(context).size.height *
                                      0.065,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.04),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          selectedGender != null
                                              ? gender
                                                  .firstWhere((element) =>
                                                      element.id ==
                                                      selectedGender)
                                                  .name
                                                  .toString()
                                              : 'gender'.tr,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: selectedGender != null
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          size: 20,
                                          color: selectedGender != null
                                              ? Colors.black
                                              : Colors.black,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            selectedGender == null && chk == true
                                ? SizedBox(
                                    child: Column(
                                      children: [
                                        SizedBox(height: Get.height * 0.01),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Get.width * 0.05),
                                              child: Text(
                                                "selectgender".tr,
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                  // fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            InkWell(
                              onTap: () async {
                                selectedRelation = null;
                                relations.clear();
                                await relationapi();
                                setState(() {});
                                dynamic generic = await searchableDropdown(
                                    context, constraints, relations);
                                if (generic != null && generic != '') {
                                  setState(() {
                                    selectedRelation = generic.id;
                                  });
                                }
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                child: Container(
                                  decoration: checkval
                                      ? BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 0.8),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.transparent,
                                        )
                                      : BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 0.8),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.transparent,
                                        ),
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: MediaQuery.of(context).size.height *
                                      0.065,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            MediaQuery.of(context).size.width *
                                                0.04),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          selectedRelation != null
                                              ? relations
                                                  .firstWhere((element) =>
                                                      element.id ==
                                                      selectedRelation)
                                                  .name
                                                  .toString()
                                              : 'relation'.tr,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: selectedRelation != null
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          size: 20,
                                          color: selectedRelation != null
                                              ? Colors.black
                                              : Colors.black,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                              selectedRelation == null && chk == true
                                ? SizedBox(
                                    child: Column(
                                      children: [
                                        SizedBox(height: Get.height * 0.01),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: Get.width * 0.05),
                                              child: Text(
                                                "selectrelation".tr,
                                                style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                  // fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox.shrink(),

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
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent,
                                ),
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.04,
                                      left: MediaQuery.of(context).size.width *
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
                          selectedCountries == null &&
                                  chk == true 
                              ? Column(
                                  children: [
                                    SizedBox(height: Get.height * 0.01),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.05),
                                          child: Text(
                                            "selectcountry".tr,
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                              // fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
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
                                await cityapi();
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
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent,
                                ),
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.065,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.04,
                                      left: MediaQuery.of(context).size.width *
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
                          SelectedState == null &&
                                  chk == true
                              ? Column(
                                  children: [
                                    SizedBox(height: Get.height * 0.01),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.05),
                                          child: Text(
                                            "selectstate".tr,
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                              // fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
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
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.transparent,
                                ),
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.065,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: MediaQuery.of(context).size.width *
                                          0.04,
                                      left: MediaQuery.of(context).size.width *
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
                          selectedCity == null &&
                                  chk == true 
                              ? Column(
                                  children: [
                                    SizedBox(height: Get.height * 0.01),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.05),
                                          child: Text(
                                            "selectcity".tr,
                                            style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 12,
                                              // fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              : const SizedBox.shrink(),
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
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            CupertinoButton(
                                color: CupertinoColors.activeBlue,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 120, vertical: 0.5),
                                borderRadius: BorderRadius.circular(8),
                                onPressed: () async {
                                     chk = true;
                                setState(() {});
                                  if (formkey.currentState!.validate()) {
                                    PatientRegistrationModal patientregister =
                                        PatientRegistrationModal();
                                      

                                    patientregister.firstName =
                                        Name.text.toString();
                                    patientregister.cellNumber =
                                        mobile_number.text.toString();
                                    patientregister.dateOfBirth =
                                        dateTime.toString();
                                    patientregister.email =
                                        email.text.toString();
                                    patientregister.relationshipTypeId =
                                        selectedRelation.toString();
                                    patientregister.stateOrProvinceId =
                                        SelectedState.toString();
                                    patientregister.cityId =
                                        selectedCity.toString();
                                    patientregister.address =
                                        Address.text.toString();
                                    patientregister.genderId =
                                        selectedGender.toString();
                                    patientregister.CNICNumber =
                                        gvt_id.text.toString();
                                    patientregister.countryId =
                                        selectedCountries.toString();
                                    patientregister.password =
                                        mobile_number.text.toString();
                                    patientregister.confirmPassword =
                                        mobile_number.text.toString();
                                    patientregister.patientTypeId =
                                        "BEB03D33-E8AA-E711-80C1-A0B3CCE147BA";
                                        

                                    print(patientregister.countryId);
                                    await _register_api(patientregister);
                                    Showtoaster().classtoaster(
                                        "Patient Register Succesfully");
                                    Get.to(() => const RegisterPatient());
                                  } else {
                                    Showtoaster().classtoaster(
                                        "Failed To register Patient");

                                    log("Failed");
                                  }
                                },
                                child: Text(
                                  "Register",
                                  style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: CupertinoColors.white),
                                )),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   children: [
                            //     const Text("Already have an account?"),
                            //     TextButton(
                            //       onPressed: () async {
                            //         Navigator.push(
                            //           context,
                            //           MaterialPageRoute(builder: ((context) {
                            //             return const Login();
                            //           })),
                            //         );
                            //       },
                            //       style: TextButton.styleFrom(
                            //         foregroundColor: Colors.blue,
                            //       ),
                            //       child: const Text("Sign in"),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }));
  }

  bool checkval = true;
}
