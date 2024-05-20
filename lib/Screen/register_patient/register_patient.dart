import 'dart:convert';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/AppConstants.dart';
import 'package:flutter_riderapp/Components/image_container/image_container.dart';
import 'package:flutter_riderapp/Components/images/Images.dart';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Models/patient_model/patient_model.dart';
import 'package:flutter_riderapp/Screen/Appointments_Screen/_appointments_history.dart';
import 'package:flutter_riderapp/Screen/Login/_signup.dart';
import 'package:flutter_riderapp/Screen/ViewInformation/edit_patient.dart';
import 'package:flutter_riderapp/Screen/register_patient/add_lab_investigation.dart';
import 'package:flutter_riderapp/Screen/register_patient/lab_investigation.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/data/Notification_repo/auth_repo.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class RegisterPatient extends StatefulWidget {
  const RegisterPatient({super.key});

  @override
  State<RegisterPatient> createState() => _RegisterPatientState();
}

class _RegisterPatientState extends State<RegisterPatient> {
  bool isLoadingData = false;
  bool isLoadingmoreData = false;
  User? user2;
  int TotalRecordsData = 0;
  String StartDate = formatDate(DateTime.now());
  // ignore: non_constant_identifier_names
  String EndDate = formatDate(DateTime.now());
  // ignore: non_constant_identifier_names
  List<dynamic> transferredList = [];
  TextEditingController searchController = TextEditingController();
  Future<List<PatientModel>> getPatients(
      String empId,

      // ignore: non_constant_identifier_names
      String? search,
      String? regular,
      String length,
      String? start) async {
    if (start == 0) {
      isLoadingData = true;
      setState(() {});
    } else {
      isLoadingmoreData = true;
      setState(() {});
    }

    var url = '$ip/api/account/GetPatient';
    var headers = {
      'Content-Type': 'application/json',
    };

    var requestBody = {
      "Start": 0,
      "Length": 1000,
      "search": search,
      "Regular": 1,
      "UserId": userprofile!.id!
    };
    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(requestBody));
    // ignore: avoid_print
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      try {
        // var data = jsonDecode(response.body);
        // ignore: avoid_print
        // print("Response data: $data");
        // List<PatientModel> ulist = [];
        // if (data['value'] != null) {
        //   TotalRecordsData = data['value'].toInt();
        // }
        // if (data != null) {
        //   var decode = data["Data"];

        //   if (start == 0) {
        //     _appointments.clear();
        //   }
        //   for (var element in decode) {
        //     var patientModel = PatientModel.fromJson(element);
        //     _appointments.add(patientModel);
        //   }
        // }
        // ignore: avoid_print
        // print(ulist);

        Map<String, dynamic> apiResponse = jsonDecode(response.body);
        List<dynamic> dataList = apiResponse['Data'];

        for (var dataObject in dataList) {
          transferredList.add(dataObject);
        }

        isLoadingData = false;
        isLoadingmoreData = false;
        setState(() {});
        return _appointments;
      } catch (e) {
        isLoadingData = false;
        isLoadingmoreData = false;
        setState(() {});
        throw Exception('Failed to load Patients');
      }
    } else {
      isLoadingData = false;
      isLoadingmoreData = false;
      setState(() {});
      throw Exception('Failed to load Patients');
    }
  }

  final ScrollController _scrollController = ScrollController();
  List<PatientModel> _appointments = [];

  String start = "0";
  String regular = "1";
  String search = "";

  callvback() async {
    _appointments = await getPatients(userprofile!.id!, start,
        AppConstants.maximumDataTobeFetched2, regular, search);
    setState(() {});
  }

  @override
  void initState() {
    if (_appointments.isEmpty) {
      callvback();
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
        inAsyncCall: isLoadingData,
        blurEffectIntensity: 4,
        progressIndicator: const SpinKitSpinningLines(
          color: Color(0xFF1272d3),
          size: 60,
        ),
        dismissible: false,
        opacity: 0.4,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Color(0xff0F64C6),
                )),
            title: Text(
              'Patient Vault'.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.175,
                color: const Color(0xFF1272D3),
              ),
            ),
            centerTitle: true,
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/helpbackgraound.png'),
                  alignment: Alignment.centerLeft),
            ),
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.all(15.0),
                    //   child: AuthTextField(
                    //     controller: searchController,
                    //     hintText: 'Search',
                    //     function: (p0) {
                    //       getPatients(
                    //           userprofile!.id!,
                    //           start,
                    //           AppConstants.maximumDataTobeFetched2,
                    //           regular,
                    //           searchController.text);
                    //       setState(() {});
                    //     },
                    //   ),
                    // ),
                    Expanded(
                        child: ListView.builder(
                      controller: _scrollController,
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: ((transferredList.isNotEmpty)
                          ? transferredList.length
                          : 0),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 15, left: 15),
                          child: Card(
                            color: const Color(0xFF1272D3),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                                title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            " MR. No | ${transferredList[index]['MRNo']}",
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: Get.width * 0.17,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.edit,
                                                    color: Colors.white),
                                                onPressed: () async {
                                                  await AuthRepo()
                                                      .getPatientBasicInfo(
                                                          transferredList[index]
                                                              ['Id']);
                                                  Get.to(() => EditPatientNew(
                                                      pid:
                                                          transferredList[index]
                                                              ['Id']));
                                                },
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.01,
                                              ),
                                              Center(
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    Get.to(AddLabInvestigation(
                                                      patientid:
                                                          transferredList[index]
                                                              ['Id'],
                                                    ));
                                                  },
                                                  child: Image.asset(
                                                    Images.add,
                                                    width: 20,
                                                    height: 20,
                                                    // color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        transferredList[index]['Name'],
                                        style: GoogleFonts.poppins(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.04,
                                )
                                // Align(
                                //   alignment: Alignment.bottomCenter,
                                //   child: ElevatedButton(
                                //       onPressed: () async {
                                //         Get.to(AddLabInvestigation(
                                //           patientid: transferredList[index]
                                //               ['Id'],
                                //         ));
                                //       },
                                //       style: ElevatedButton.styleFrom(
                                //         backgroundColor: Colors.white,
                                //         fixedSize: const Size(380, 4),
                                //         shape: RoundedRectangleBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(15),
                                //         ),
                                //       ),
                                //       child: Center(
                                //         child: Image.asset(
                                //           Images.add,
                                //           width: 20,
                                //           height: 20,
                                //           color: Colors.blue,
                                //         ),
                                //       )),
                                // ),
                              ],
                            )),
                          ),
                        );
                      },
                    ))
                  ],
                )),
          ),
        ));
  }
}
