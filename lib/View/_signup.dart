
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/countrymodel.dart';
import 'package:flutter_riderapp/Models/statemodel.dart';
import 'package:flutter_riderapp/Widgets/Utils/toaster.dart';
import 'package:flutter_riderapp/Widgets/custom_dropdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riderapp/Models/Register.dart';
import 'package:flutter_riderapp/Models/city.dart';
import 'package:flutter_riderapp/Models/gender.dart';
import 'package:flutter_riderapp/Models/vehicle.dart';
// ignore: unused_import
import 'package:flutter_riderapp/View/_login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riderapp/View/_registered.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:http/http.dart'as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:image/image.dart' as img;
import 'package:flutter_riderapp/Widgets/CustomFormField.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';







class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  vehicle? Vehicle;

  late File _heicImage;
  String hintText="";



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


  TextEditingController Name=TextEditingController();
  TextEditingController mobile_number=TextEditingController();
  TextEditingController email=TextEditingController();
  TextEditingController datetimecontroller=TextEditingController();
   final TextEditingController gvt_id = TextEditingController();
  final MaskTextInputFormatter maskFormatter = MaskTextInputFormatter(
    mask: 'XXX-XXXX-XXXXXXXX-X',
    filter: {"X": RegExp(r'[0-9]')},
  );
  TextEditingController v_type=TextEditingController();
  TextEditingController L_No=TextEditingController();
  TextEditingController Password=TextEditingController();
  TextEditingController Re_Password=TextEditingController();
  TextEditingController City=TextEditingController();
  TextEditingController Address=TextEditingController();
   TextEditingController v_number=TextEditingController();

// final GlobalKey _dropdownKey = GlobalKey();

  bool passwordVisible = true;
  bool PasswordVisible=true;
  bool registered=false;
   FocusNode focusNode = FocusNode();


  final formkey=GlobalKey<FormState>();
  bool passToggle=true;

  bool isPasswordMatch() {
    String password = Password.text;
    String rePassword =  Re_Password.text;
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

List<DropdownMenuItem<String>> get dropdownItems{
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
List<DropdownMenuItem<String>> get vehicleItems{
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
      var body={
        "StateORProvinceId":id,
      };
      print('To post Body of City API : $body');
      print('To post headers of City API : $headers');
      var response = await http.post(
          Uri.parse(url),headers: headers,
          body: jsonEncode(body)
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print((data['Status'] == 1 && data['Status'] != null && data['Data'] != null));
        if (data['Status'] != null && data['Status'] == 1 && data['Data'] != null) {

          for (var cityData in data['Data']) {
            cities.add(CityModel.fromJson(cityData));
          }
          List<String> selectedCity = ['Select City'];


          setState(() {

            cityNameArray = selectedCity ;

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
List<int>  genderIdArray= [];
  List<Gender> gender = [];

Future<void> genderapi() async {
  final url = '$ip/api/RiderRegistrationRequest/GetGenders';
  final headers = {'Content-Type': 'application/json'};

  try {
    final response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['Status'] != null && data['Status'] == 1 && data['Data'] != null) {
      

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
List<int>  vechileIdArray= [];
  List<vehicle> vehicles = [];

Future<void> vehicleapi() async {
  final url = '$ip/api/RiderRegistrationRequest/GetVehicleTypes';
  final headers = {'Content-Type': 'application/json'};

  try {
    final response = await http.post(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data['Status'] != null && data['Status'] == 1 && data['Results'] != null) {
      

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
      if (data['Status'] != null && data['Status'] == 1 && data['Data'] != null) {


        for (var countryData in data['Data']) {
          countries.add(CountryModel.fromJson(countryData));
        }

        List<String> selectedCountries = ['Select Country'];


        setState(() {

          countryNameArray = selectedCountries ;

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
    var body={
      "CountryId":id,
    };
    print(body);
    print(headers);
    var response = await http.post(
      Uri.parse(url),headers: headers,
      body: jsonEncode(body)
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(data);
      if (data['Status'] != null && data['Status'] == 1 && data['Data'] != null) {


        for (var stateData in data['Data']) {
          state.add(StateModel.fromJson(stateData));
        }

        List<String> selectedState = ['Select State'];

        setState(() {

          stateNameArray = selectedState ;

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

 
  final response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(register.toJson()));
  print("Response: ${response.body}");

  if (response.statusCode == 200) {
    setState(() {
      
    });
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
   
    dynamic data =jsonDecode( await res.stream.bytesToString());
    r=data["Path"];
    
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
    datetimecontroller.text = "Date of Birth";
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(    
         shadowColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0.0,
          title: SizedBox(
        
                                height: MediaQuery.of(context).size.height*0.065,
            
              child: Image.asset(
                'assets/Helpful.png',
                width: MediaQuery.of(context).size.width/2,
               
              ),
            ),
        
       leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios_new,color: Color(0xff0F64C6),)),),
      body: LayoutBuilder(
        builder: (context,constraints) {
          return Form(
            key:formkey,
            child: Container(
               height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
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
                      Text(
                        'Register Now',
                        style: GoogleFonts.raleway(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Color(0xFF1272D3),
                          ),
                        ),
                      ),
                      ImageProfile()
                   
                    ],
                  
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                  ),
                  
                Expanded(
                       
                  child: SingleChildScrollView(
                    child: Column(
                      
                      children: [
                        
                        
                        
                          
                  
                       SizedBox(
                        height: MediaQuery.of(context).size.height*0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child:  customFormField(hinttext: "  Full Name",
                          val: Name.text.toString(),
                          controller: Name,

                        ),
                      ),


                              SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                              ),

SizedBox(
  
  width:MediaQuery.of(context).size.width*0.895,
child:IntlPhoneField(
  initialCountryCode: 'SA',
  controller: mobile_number,
  disableLengthCheck: true,
  keyboardType: TextInputType.number,
  decoration: InputDecoration(
    disabledBorder: const OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.black54),
    ),
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
  ),
  languageCode: "en",
  onSaved: (newValue) {},
  onSubmitted: (p0) {},
  onCountryChanged: (country) {
    setState(() {});
  },
  validator: (phoneField) {
    if (phoneField!.number.isEmpty) {
      return 'Please select a country';
    }
    return null;
  },
),),

                          
                  
                     SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                              ),
                        Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 20),
                          child:  customFormField(hinttext: "  Email",
                         
                         controller: email,
                          
                          ),
                        ),
                          
                  
                       
                          SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                              ),
                
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.088,
                  child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CupertinoTextField(
        
        readOnly: true,
        controller: datetimecontroller,
      
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black54,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        prefix: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Icon(
            CupertinoIcons.calendar,
            color: CupertinoColors.black,
          ),
        ),
        onTap: () {
          showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => Center(
              child: SizedBox(
                height: 200,
                child: CupertinoDatePicker(
                  backgroundColor: Colors.white,
                  initialDateTime: selectedDate ?? DateTime.now(),
                  onDateTimeChanged: (DateTime newTime) {
                    setState(() {
                      selectedDate = newTime;
                      datetimecontroller.text =
                          '${newTime.day.toString().padLeft(2, '0')}-${newTime.month.toString().padLeft(2, '0')}-${newTime.year}';
                    });
                  },
                  use24hFormat: true,
                  mode: CupertinoDatePickerMode.date,
                ),
              ),
            ),
          );
        },
      ),
    ),
                ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                        
                 InkWell(
                  onTap: ()async {
                    selectedGender=null;
                    gender.clear();
                    await genderapi();
                   setState(() {
                      
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                        width:MediaQuery.of(context).size.width*0.895,
                        
                           height: MediaQuery.of(context).size.height*0.1,
                      
                      child: SizedBox(
                        
                      
                        
                        child: DropdownButtonFormField(
                           decoration: 
                           
                           checkval?  InputDecoration(
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(width: 1,color: Colors.black)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14,vertical: 20),
                          ):InputDecoration(
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(width: 1,color: Colors.black)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 14,vertical: 13),
                          ),
                          
                       
                              value: selectedGender,
                        hint:const Text('  Gender' ,style: TextStyle(
                          color: Colors.black
                        ),),
                              items: gender
                                .map<DropdownMenuItem<String>>((Gender val) {
                                  return DropdownMenuItem<String>(
                                    value: val.id,
                                    child: Text(val.name.toString()),
                                  );
                              }).toList(),
                              style: const TextStyle(color: Colors.black, fontSize: 18),
                              onChanged: (String? newValue) {
                      setState(() {
                      selectedGender = newValue;
                      });
                              },
                               validator: (value) {
                          
                                if (value == null || value.isEmpty) {
                                  return 'Please select a gender';
                                }
                                else 
                                {
                                  
                                  return null;
                                }
                               }
                             
                    
                        
                       
                        
                      ),
                      
                      ),
                    ),
                  ),
                ),
                
                        

                 
                
                          SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                              ),
FormField(
  builder: (FormFieldState<String> state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: '  ID 01-2345-6789',
          hintStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 0.8,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          errorText: validatorforformfield.isNotEmpty ? validatorforformfield : null,
        ),
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
        controller: gvt_id,
        autofocus: true,
        onChanged: (value) {
          final sanitizedValue = value.replaceAll(RegExp(r'[^0-9]'), '');

          if (sanitizedValue.length == 10) {
            if (sanitizedValue.substring(0, 2) == '01' &&
                sanitizedValue.substring(2, 7) == '23456' &&
                sanitizedValue.substring(7) == '6789') {
              validatorforformfield = ""; // Input is valid
              gvt_id.text =
                  '${sanitizedValue.substring(0, 2)}-${sanitizedValue.substring(2, 7)}-${sanitizedValue.substring(7)}';
            } else {
              // validatorforformfield = "Invalid Format";
            }
          } else {
            // validatorforformfield = "Enter Valid Number";
          }
        },
      ),
    );
  },
),
 


                  
                           
                        // Padding(
                        //  padding: const EdgeInsets.symmetric(horizontal: 20),
                        //   child:  customFormField(hinttext: "  ID 123-4567-8910"
                        //   ,
                          
                         
                        //  controller: gvt_id,
                       
                          
                        //   ),
                        // ),

                         SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                              ),
                         
                 InkWell(
                  onTap: ()async {
                    selectedVehicle=null;
                    vehicles.clear();
                    await vehicleapi();
                    setState(() {
                      
                    });
                  },
                  child: SizedBox(
                   
                    width: MediaQuery.of(context).size.width*0.89,
                    height: MediaQuery.of(context).size.height*0.1,

                    child: DropdownButtonFormField(
                       decoration:  InputDecoration(
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(width: 1,color: Colors.black)),
                          contentPadding:checkval? const EdgeInsets.symmetric(horizontal: 14,vertical: 20): const EdgeInsets.symmetric(horizontal: 14,vertical: 14),
                        ),
                          value: selectedVehicle,
                    hint:const Text("  Vehicle Type",style: TextStyle(color:Colors.black),),
                          items: vehicles
                            .map<DropdownMenuItem<String>>((vehicle val) {
                              return DropdownMenuItem<String>(
                                value: val.id,
                                child: Text(val.name.toString()),
                              );
                          }).toList(),
                          style: const TextStyle(color: Colors.black, fontSize: 18),
                          onChanged: (String? newValue) {
                  setState(() {
                  selectedVehicle = newValue;
                  });
                          },
                           validator: (value) {
                          
                                if (value == null || value.isEmpty) {
                                  return 'Please select a gender';
                                }
                                else 
                                {
                                  
                                  return null;
                                }
                               },
                          elevation: 0,
                  
                  ),
                  ),
                ),

                         SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                              ),
                        SizedBox(
                            //  height: MediaQuery.of(context).size.height*0.065,
                          child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 20),
                            child:  customFormField(hinttext: "  Vehicle Number",
                            val: v_number.text.toString(),
                           controller: v_number,
                            
                            ),
                          ),
                        ),
                      
                         SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                              ),
                        SizedBox(
                            //  height: MediaQuery.of(context).size.height*0.065,
                          child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 20),
                            child:  customFormField(hinttext: "   Liscence No.",
                            val: L_No.text.toString(),
                           controller: L_No,
                            
                            ),
                          ),
                        ),
                          
                  
                      
                             SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),

                      
                        child: TextFormField(
                        decoration: InputDecoration(
                          hintText: '   Password',
hintStyle: const TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black,
                              width: 0.5,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
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
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        controller: Password,
                        obscureText: PasswordVisible,
                                        ),
                      )
,
                      SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
                      ),
                  FormField(
  builder: (FormFieldState<String> state) {
    return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: '   Re-Password',
                  hintStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 0.8,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                ),
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
                controller: Re_Password,
                obscureText: passwordVisible,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height*0.01,),
            if (!isPasswordMatch())
              const Padding(
                padding: EdgeInsets.symmetric(horizontal:24.0),
                child: Row(
                  children: [
                    Text(
                      '   Passwords do not match!',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
          ],
    );
  },
),

 SizedBox(
                    height: MediaQuery.of(context).size.height*0.01,
                              ),

                            

InkWell(
  onTap: ()async {
    selectedCountries=null;
    countries.clear();
    await countriesapi();
    setState(() {
    });
    dynamic generic = await  searchableDropdown(
            context,
            constraints,
            countries
    );
    selectedCountriesName = null;
    if (generic != null && generic != '')
          {
            print('Countries selected Id'+ generic.id);
            selectedCountries=generic.id;
            selectedCountriesName=(generic.name == '') ? null : generic.name;
            state.clear();
            cities.clear();
            await stateapi(generic.id);
            selectedCity=null;
            selectedCityName=null;
            SelectedState=null;
            SelectedStateName=null;
            setState(() {
            });
          }
  },
  child:
  Padding(
    padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.height*0.03),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.8),
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.transparent,
      ),
      width: MediaQuery.of(context).size.width*0.99,
      height: MediaQuery.of(context).size.height*0.088,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.075),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(
              //"${selectedCountriesName?? "Country"}",
              "${ (selectedCountriesName !=null) ?  (selectedCountriesName!.length > 30 ? ('${selectedCountriesName!.substring(0, 30)}...') : selectedCountriesName ) :"Country"}",
              style: TextStyle(
                  fontSize: 17,
                  color:  selectedCountriesName != null ? Colors.black : Colors.black),
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 25,
              color: selectedCountriesName != null ? Colors.black : Colors.black,
            )
          ],
        ),
      ),
    ),
  ),
),


SizedBox(
  height: MediaQuery.of(context).size.height*0.02,
),

InkWell(
  onTap: ()async {
    SelectedState=null;
    setState(() { });
    dynamic generic = await  searchableDropdown(
            context,
            constraints,
            state
    );
    SelectedStateName = null;
    if (generic != null && generic != '') {
          SelectedState=generic.id;
          SelectedStateName=(generic.name == '') ? null : generic.name;
          cities.clear();
          selectedCity=null;
          selectedCityName=null;
          await cityapi(generic.id);
    }
    setState(() {
    });

  },
  child:
  Padding(
    padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width*0.054),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.8),
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.transparent,
      ),
      width: MediaQuery.of(context).size.width*0.99,
      height: MediaQuery.of(context).size.height*0.088,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.075),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(
             // "${SelectedStateName?? "State"}",
            "${(SelectedStateName !=null) ? (SelectedStateName!.length > 15 ? ('${SelectedStateName!.substring(0, 15)}...' ) : SelectedStateName ) :"State" }",
              style: TextStyle(
                  fontSize: 17,
                  color:  SelectedStateName != null ? Colors.black : Colors.black),
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 25,
              color: SelectedStateName != null ? Colors.black :Colors.black,
            )
          ],
        ),
      ),
    ),
  ),
),


SizedBox(
  height: MediaQuery.of(context).size.height*0.02,
),

InkWell(
  onTap: ()async {
    selectedCity=null;
   // cities.clear();
    setState(() { });
    dynamic generic = await  searchableDropdown(
            context,
            constraints,
            cities
    );
    selectedCityName = null;
    if (generic != null && generic != '') {
          selectedCity=generic.id;
          selectedCityName=(generic.name == '') ? null : generic.name;
    }
    setState(() {
    });
  },
  child:
  Padding(
    padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.width*0.054),
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 0.8),
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.transparent,
      ),
      width: MediaQuery.of(context).size.width*0.99,
      height: MediaQuery.of(context).size.height*0.088,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.075),
        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(
             // "${selectedCityName?? "City"}",
              "${(selectedCityName !=null) ? (selectedCityName!.length > 30 ? ('${selectedCityName!.substring(0, 30)}...'  ) : selectedCityName):"City"}",
              style: TextStyle(
                  fontSize: 17,
                  color:  selectedCityName != null ? Colors.black : Colors.black),
            ),
            Icon(
              Icons.arrow_drop_down,
              size: 25,
              color: selectedCityName != null ? Colors.black : Colors.black,
            )
          ],
        ),
      ),
    ),
  ),
),

                
                  
                         
                           SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                              ),
                        SizedBox(
                            //  height: MediaQuery.of(context).size.height*0.065,
                          child: Padding(
                           padding: const EdgeInsets.symmetric(horizontal: 20),
                            child:  customFormField(hinttext: "   Address",
                            val: Address.text.toString(),
                           controller: Address,
                            
                            ),
                          ),
                        ),
                          
                
                
                
                       SizedBox(
                    height: MediaQuery.of(context).size.height*0.02,
                              ),
                              CupertinoButton(color:CupertinoColors.activeBlue,  padding: const EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                borderRadius: BorderRadius.circular(8), 
                              
                              onPressed: ()async{
                                
                                String str="";
                                if(_imageFile!=null)
                                {
  str=await uploadPicture(_imageFile!);

                                }
                               
     if(formkey.currentState!.validate()){
     
          if(Password.text.toString()==Re_Password.text.toString()){
                                  Register register= Register();
                                register.fullName=Name.text.toString();
                                register.mobileNo=mobile_number.text.toString();
                                register.email=email.text.toString();
                                register.dateOfBirth=dateTime.toString();
                                register.genderId=selectedGender.toString();
                                register.identityNo=gvt_id.text.toString();
                                register.vehicleTypeId=selectedVehicle.toString();
                                register.vehicleNumber=v_number.text.toString();
                                register.licenseNo=L_No.text.toString();
                                register.password=Password.text.toString();
                                register.password=Re_Password.text.toString();
                                register.cityId=selectedCity.toString();
                                register.address=Address.text.toString();
                                str!=""? register.profilePictureImagePath=str.toString().split('=')[1].split('"')[0]:"";
          
                                
          
          
                          
                              await  _register_api(register);
                              
                                  Navigator.push(
                            context,
                            MaterialPageRoute(builder: ((context) {
                              return const Registered();
                            })),
                          );
                              }
                               else{
                                Showtoaster().classtoaster("Password doesn't Match");
                              }
   
                       checkval=true;
      setState((){});          
          }else{
            checkval=false;
            setState(() {
              
            });
             Showtoaster().classtoaster("Please enter valid data");
                            
          }
                             
          
          
          
                              }, child: Text("Register",style: GoogleFonts.poppins(
                                fontSize: 16,fontWeight: FontWeight.bold,color: CupertinoColors.white
                                
                              
                              ),
                             
                              )),
                              
                             
                               
                  
                        
                  
                   SizedBox(
                    height: MediaQuery.of(context).size.height*0.03,
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
          );
        }
      ),

    
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
           style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton.icon(
                icon: const Icon(Icons.camera),
                onPressed: () {
                  TakePhoto(ImageSource.camera);
                   Navigator.pop(context);
                },
                label: Text("camera",
                style: GoogleFonts.raleway(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),
                ),
              ),
              TextButton.icon(
                icon: const Icon(Icons.image),
                onPressed: () {
                  TakePhoto(ImageSource.gallery);
                   Navigator.pop(context);
                },
                label: Text("Gallery",
                
                style: GoogleFonts.raleway(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),
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
  } else {
  }
}


bool checkval=true;


 Widget ImageProfile() {
    return Stack(
      children: <Widget>[
        CircleAvatar(
            radius: 50.0,
            backgroundImage: _imageFile == null
                ?  const AssetImage("assets/pp.jpg")
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

String validatorforformfield="";


  }

  

