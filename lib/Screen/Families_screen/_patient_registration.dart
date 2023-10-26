import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/countrymodel.dart';
import 'package:flutter_riderapp/Models/nok_model.dart';
import 'package:flutter_riderapp/Models/patient_registration-model.dart';
import 'package:flutter_riderapp/Models/relations.dart';
import 'package:flutter_riderapp/Models/statemodel.dart';
import 'package:flutter_riderapp/Screen/Login/_signup.dart';
import 'package:flutter_riderapp/Widgets/custom_dropdown.dart';
import 'package:flutter_riderapp/Widgets/searchabledropdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riderapp/Models/Register.dart';
import 'package:flutter_riderapp/Models/city.dart';
import 'package:flutter_riderapp/Models/gender.dart';
// ignore: unused_import
import 'package:flutter_riderapp/Screen/Login/_login.dart';
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

  TextEditingController Name = TextEditingController();
  TextEditingController mobile_number = TextEditingController();
  TextEditingController email = TextEditingController();
  final TextEditingController gvt_id = TextEditingController();
  TextEditingController City = TextEditingController();
  TextEditingController Address = TextEditingController();
  TextEditingController v_number = TextEditingController();
  TextEditingController GuardianName = TextEditingController();
  TextEditingController NOKName = TextEditingController();
  final TextEditingController gvt_guardian_id = TextEditingController();
  

// final GlobalKey _dropdownKey = GlobalKey();

  bool registered = false;
  FocusNode focusNode = FocusNode();

  final formkey = GlobalKey<FormState>();
  bool passToggle = true;

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
  String? selectedRelation;
  String? selectedNOK;
  String? selectedNOKName;
   String? selectedCountriesName;
  String? selectedCountries;
  String? SelectedState;
  String? countryCode;
  String? selectedCityName;
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

//  NOKModel testing= NOKModel(id: '84385',name: 'attiq testing');

// NOK api
  List<String> NOKNameArray = ['Select Relation'];
  List<NOKModel> NOK = [];
  Future<void> NOKapi() async {
    //  NOK.add(testing);
    setState(() {});
    final url = '$ip/api/ddl/GetNOKRelations';
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
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
    // TODO: implement initState
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
            'Registration',
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
                                  return 'Enter your full name';
                                }
                                return null;
                              },
                              controller: Name,
                              hintText: 'Full Name',
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
                                  return 'Please enter a valid number';
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
                                return 'Enter Your Email';
                              }
                              return null;
                            },
                            controller: email,
                            hintText: 'Email',
                          ),
 SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),

                          AuthTextField(
                            readOnly: true,
                            controller: TextEditingController(
                                    text: dateFormat.format(dateTime),
                                  ),
                            validator: (value) {
                              return null;
                            },
                            // ignore: unnecessary_null_comparison
                            hintText: selectedDate == null
                                ? "Date of birth"
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
                                         onDateTimeChanged:
                                                (DateTime newTime) {
                                              setState(() => dateTime = newTime);
                                            
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
                              child: SizedBox(
                                
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.075,
                                child: SizedBox(
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
                                                      horizontal: 14,
                                                      vertical: 18),
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
                                                      vertical: 13),
                                            ),
                                      value: selectedGender,
                                      hint: const Text(
                                        '  Gender',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 12),
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
                                          return 'Please select a gender';
                                        } else {
                                          return null;
                                        }
                                      }),
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
                                return 'Enter ID Number';
                              }
                              return null;
                            },
                            controller: gvt_id,
                            hintText: 'ID 01-2345-6789',
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
                                        "${(selectedCountriesName != null) ? (selectedCountriesName!.length > 30 ? ('${selectedCountriesName!.substring(0, 30)}...') : selectedCountriesName) : "Country"}",
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
                                        "${(SelectedStateName != null) ? (SelectedStateName!.length > 15 ? ('${SelectedStateName!.substring(0, 15)}...') : SelectedStateName) : "State"}",
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
                                        "${(selectedCityName != null) ? (selectedCityName!.length > 30 ? ('${selectedCityName!.substring(0, 30)}...') : selectedCityName) : "City"}",
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
                                return 'Enter Your Address';
                              }
                              return null;
                            },
                            controller: Address,
                            hintText: 'Address',
                          ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Center(
                              child: Text(
                                'Guardian',
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            InkWell(
                              onTap: () async {
                                selectedRelation = null;
                                relations.clear();
                                await relationapi();
                                setState(() {});
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.065,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 0.5),
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.transparent,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.98,
                                    height:
                                        MediaQuery.of(context).size.height * 0.05,
                                    child: DropdownButtonFormField(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 15),
                                      ),
                                      value: selectedRelation,
                                      hint: const Text("Relation",style: TextStyle(fontSize: 14,color: Colors.grey),),
                                      items: relations
                                          .map<DropdownMenuItem<String>>(
                                              (RelationModel val) {
                                        return DropdownMenuItem<String>(
                                          value: val.id,
                                          child: Text(val.name.toString(),style: const TextStyle(fontSize: 14),),
                                        );
                                      }).toList(),
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedRelation = newValue;
                                        });
                                      },
                                      elevation: 0,
                                      menuMaxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.5,
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
                                return 'Enter Gaurdians Name';
                              }
                              return null;
                            },
                            controller: GuardianName,
                            hintText: 'Name',
                          ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Center(
                              child: Text(
                                'Next of Kin',
                                style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            InkWell(
                              onTap: () async {
                                selectedNOK = null;
                                NOK.clear();
                                await NOKapi();
                                setState(() {});
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.065,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 0.5),
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.transparent,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.98,
                                    height:
                                        MediaQuery.of(context).size.height * 0.05,
                                    child: DropdownButtonFormField(
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            EdgeInsets.symmetric(horizontal: 15),
                                      ),
                                      value: selectedNOK,
                                      hint: const Text("Relation",style: TextStyle(fontSize: 14,color: Colors.grey),),
                                      items: NOK.map<DropdownMenuItem<String>>(
                                          (NOKModel val) {
                                        return DropdownMenuItem<String>(
                                          value: val.id,
                                          child: Text(val.name.toString(),style: const TextStyle(fontSize: 14),),
                                        );
                                      }).toList(),
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 18),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedNOK = newValue;
                                        });
                                      },
                                      elevation: 0,
                                      menuMaxHeight:
                                          MediaQuery.of(context).size.height *
                                              0.5,
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
                                return 'Enter Next Of Kin Name';
                              }
                              return null;
                            },
                            controller: NOKName,
                            hintText: 'Name',
                          ),
                            SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                          AuthTextField(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Enter ID Number';
                              }
                              return null;
                            },
                            controller: gvt_guardian_id,
                            hintText: 'ID 01-2345-6789',
                          ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            InkWell(
                              onTap: () async {
                                NOK.clear();
                                NOKapi();
                                dynamic generic = await searchabledropdown(
                                    context, constraints, NOK);
                                selectedNOK = generic.id;
                                selectedNOKName = 'ddfds';
                                selectedNOKName =
                                    (generic.name == '') ? null : generic.name;
                                setState(() {});
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.065,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 0.5),
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.transparent,
                                    ),
                                    width:
                                        MediaQuery.of(context).size.width * 0.98,
                                    height:
                                        MediaQuery.of(context).size.height * 0.05,
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
                                            selectedNOKName ?? "Select Role",
                                            style: const TextStyle(color: Colors.grey,fontSize: 14),
                                          ),
                                          const Icon(
                                            Icons.arrow_drop_down,
                                            size: 25,
                                            color: Colors.black,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
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
                                  if (formkey.currentState!.validate()) {
                                    PatientRegistrationModal register =
                                        PatientRegistrationModal();
          
                                    register.firstName = Name.text.toString();
                                    register.cellNumber =
                                        mobile_number.text.toString();
                                    register.dateOfBirth = dateTime.toString();
                                    register.genderId = selectedGender.toString();
                                    register.CNICNumber = gvt_id.text.toString();
                                    register.countryId =
                                        selectedCountries.toString();
                                    print(register.countryId);
          
                                    // register.fullName=Name.text.toString();
                                    // register.mobileNo=mobile_number.text.toString();
                                    // register.email=email.text.toString();
                                    // register.dateOfBirth=dateTime.toString();
                                    // register.genderId=selectedGender.toString();
                                    // register.identityNo=gvt_id.text.toString();
                                    // register.vehicleTypeId=selectedVehicle.toString();
                                    // register.vehicleNumber=v_number.text.toString();
                                    // register.cityId=selectedCity.toString();
                                    // register.address=Address.text.toString();
          
                                    //await  _register_api(register);
          
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: ((context) {
                                    //     return const Registered();
                                    //   })),
                                    // );
                                  } else {}
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text("Already have an account?"),
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
                                  child: const Text("Sign in"),
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
        }));
  }
  bool checkval = true;
}
