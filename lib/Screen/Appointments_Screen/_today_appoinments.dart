import 'dart:async';
import 'dart:convert';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Screen/Dashboard/_dashboard.dart';
import 'package:flutter_riderapp/Screen/Login/_signup.dart';
import 'package:flutter_riderapp/controllers/edit_patient_controller.dart';
import 'package:flutter_riderapp/controllers/labinvestigation_controller/lab_investigation_controller.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_riderapp/Screen/ViewInformation/_view_information.dart';

import '../../AppConstants.dart';
import '../../Models/User.dart';
import '../../Utilities.dart';

// ignore: must_be_immutable
class TodayAppoinments extends StatefulWidget {
  String empId;

  TodayAppoinments({required this.empId, Key? key}) : super(key: key);

  @override
  State<TodayAppoinments> createState() => _TodayAppoinmentsState();
}

class _TodayAppoinmentsState extends State<TodayAppoinments> {
  // ignore: unused_field

  late Future<List<User>> _appointmentsFuture;
  List<User> _appointments = [];
  bool isLoadingData = false;
  bool isLoadingmoreData = false;
  String selectedStatusFilter = "";

  int start = 0;
  // ignore: non_constant_identifier_names
  int TotalRecordsData = 0;
  // ignore: non_constant_identifier_names
  int Selectedoption = 0;
  // ignore: non_constant_identifier_names
  String Status = "";
  final ScrollController _scrollController = ScrollController();
  // ignore: non_constant_identifier_names
  String EndDate = "";
  // ignore: non_constant_identifier_names
  String StartDate = "";

  callvback() async {
    _appointments = await getappointments(widget.empId, StartDate, EndDate,
        AppConstants.maximumDataTobeFetched, start);
  }

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    isLoadingData = false;
    isLoadingmoreData = false;
    setState(() {});
    super.initState();
    StartDate = formatDateWithTime(DateTime.now());
    EndDate = formatDateWithTime(DateTime.now(), isEndOfDay: true);
    Filterstatus = 0;
    start = 0;
    resetAllDataValues();
    if (_appointments.isEmpty) {
      callvback();
    }

    // Timer.periodic(const Duration(seconds: 2), (timer) {
    //   setState(() {});
    // });

    _scrollController.addListener(() {
      // var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        var isCallToFetchData = SetStartToFetchNextData();
        if (isCallToFetchData == true) {
          // ignore: non_constant_identifier_names
          String StartDate = formatDateWithTime(DateTime.now());
          String EndDate = formatDateWithTime(DateTime.now(), isEndOfDay: true);
          _appointmentsFuture = getappointments(widget.empId, StartDate,
              EndDate, AppConstants.maximumDataTobeFetched, start);
          setState(() {});
        }
      }
    });
  }

  resetAllDataValues() {
    start = 0;
    TotalRecordsData = 0;
    _appointments.clear();
  }

  // ignore: non_constant_identifier_names
  SetStartToFetchNextData() {
    if ((start + AppConstants.maximumDataTobeFetched) < TotalRecordsData) {
      start = start + AppConstants.maximumDataTobeFetched;
      return true;
    } else {
      return false;
    }
  }

  int Filterstatus = 0;
  // ignore: non_constant_identifier_names
  Future<List<User>> getappointments(
    String empId,
    String StartDate,
    // ignore: non_constant_identifier_names
    String EndDate,
    int length,
    int start,
  ) async {
    if (start == 0) {
      isLoadingData = true;
      setState(() {});
    } else {
      isLoadingmoreData = true;
      setState(() {});
    }

    var url = '$ip/api/account/GetAppointmentRequestList';
    var headers = {
      'Content-Type': 'application/json',
    };

    var requestBody = {
      'UserId': empId,
      'StartDate': StartDate,
      'EndDate': EndDate,
      'length': length,
      'start': start,
      'HistoryFilterStatus': Filterstatus,
      'Search': searchController.text,
    };
    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(requestBody));
    // ignore: avoid_print
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        // ignore: avoid_print
        print("Response data: $data");
        List<User> ulist = [];
        if (data['TotalRecord'] != null) {
          TotalRecordsData = data['TotalRecord'].toInt();
        }
        if (data != null) {
          var decode = data["Data"];
          ulist = List<User>.from(decode.map((e) => User.fromJson(e)));
          if (start == 0) {
            _appointments.clear();
          }
          for (var element in ulist) {
            _appointments.add(element);
          }
        }
        // ignore: avoid_print
        print(ulist);

        isLoadingData = false;
        isLoadingmoreData = false;
        setState(() {});
        return ulist;
      } catch (e) {
        isLoadingData = false;
        isLoadingmoreData = false;
        setState(() {});
        throw Exception('Failed to load appointments');
      }
    } else {
      isLoadingData = false;
      isLoadingmoreData = false;
      setState(() {});
      throw Exception('Failed to load appointments');
    }
  }

  final items = [
    const Icon(Icons.notifications, size: 30, color: Colors.white),
    const Icon(Icons.home, size: 30, color: Colors.white),
    const Icon(Icons.person, size: 30, color: Colors.white),
  ];
  int index = 1;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
          bottomNavigationBar: const Mycustomnavbar(),
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
              'todayappointment'.tr,
              textAlign: TextAlign.center,
              style: GoogleFonts.raleway(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 1.175,
                color: const Color(0xFF1272D3),
              ),
            ),
            actions: [
              InkWell(
                onTap: () {},
                child: PopupMenuButton<int>(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  onSelected: (value) {
                    setState(() {
                      if (value == 1) {
                        Filterstatus = 0;
                        getappointments(
                            widget.empId, StartDate, EndDate, 25, start);

                        setState(() {});
                      } else if (value == 2) {
                        Filterstatus = 1;
                        getappointments(
                            widget.empId, StartDate, EndDate, 25, start);
                        setState(() {});
                      } else if (value == 3) {
                        Filterstatus = 2;
                        getappointments(
                            widget.empId, StartDate, EndDate, 25, start);
                        setState(() {});
                      } else if (value == 4) {
                        Filterstatus = 3;
                        getappointments(
                            widget.empId, StartDate, EndDate, 25, start);
                        setState(() {});
                      } else if (value == 5) {
                        Filterstatus = 4;
                        getappointments(
                            widget.empId, StartDate, EndDate, 25, start);
                        setState(() {});
                      } else if (value == 6) {
                        Filterstatus = 5;
                        getappointments(
                            widget.empId, StartDate, EndDate, 25, start);
                        setState(() {});
                      } else if (value == 7) {
                        Filterstatus = 6;
                        getappointments(
                            widget.empId, StartDate, EndDate, 25, start);
                        setState(() {});
                      } else if (value == 8) {
                        Filterstatus = 7;
                        getappointments(
                            widget.empId, StartDate, EndDate, 25, start);
                        setState(() {});
                      } else if (value == 9) {
                        Filterstatus = 8;
                        getappointments(
                            widget.empId, StartDate, EndDate, 25, start);
                        setState(() {});
                      } else if (value == 10) {
                        Filterstatus = 9;
                        getappointments(
                            widget.empId, StartDate, EndDate, 25, start);
                        setState(() {});
                      } else if (value == 11) {
                        Filterstatus = 10;
                        getappointments(
                            widget.empId, StartDate, EndDate, 25, start);
                        setState(() {});
                      } else if (value == 12) {
                        Filterstatus = 11;
                        getappointments(
                            widget.empId, StartDate, EndDate, 25, start);
                        setState(() {});
                      } else if (value == 13) {
                        Filterstatus = 12;
                        getappointments(
                            widget.empId, StartDate, EndDate, 25, start);
                        setState(() {});
                      } else if (value == 14) {
                        Filterstatus = 13;
                        getappointments(
                            widget.empId, StartDate, EndDate, 25, start);
                        setState(() {});
                      } else if (value == 15) {
                        Filterstatus = 14;
                        getappointments(
                            widget.empId, StartDate, EndDate, 25, start);
                        setState(() {});
                      } else if (value == 16) {
                        Filterstatus = 15;
                        getappointments(
                            widget.empId, StartDate, EndDate, 25, start);
                        setState(() {});
                      } else if (value == 17) {
                        Filterstatus = 16;
                        getappointments(
                            widget.empId, StartDate, EndDate, 25, start);
                        setState(() {});
                      }
                    });
                  },
                  itemBuilder: (BuildContext context) => [
                    const PopupMenuItem<int>(
                      value: 1,
                      child: Text('All'),
                    ),
                    const PopupMenuItem<int>(
                      value: 2,
                      child: Text('Pending Payments'),
                    ),
                    const PopupMenuItem<int>(
                      value: 3,
                      child: Text('Booked'),
                    ),
                    const PopupMenuItem<int>(
                      value: 4,
                      child: Text('Completed'),
                    ),
                    const PopupMenuItem<int>(
                      value: 5,
                      child: Text('Cancelled'),
                    ),
                    const PopupMenuItem<int>(
                      value: 6,
                      child: Text('Refunded'),
                    ),
                    const PopupMenuItem<int>(
                      value: 7,
                      child: Text('Provider assigned'),
                    ),
                    const PopupMenuItem<int>(
                      value: 8,
                      child: Text('In progress'),
                    ),
                    const PopupMenuItem<int>(
                      value: 9,
                      child: Text('Consent Received'),
                    ),
                    const PopupMenuItem<int>(
                      value: 10,
                      child: Text('Removed'),
                    ),
                    const PopupMenuItem<int>(
                      value: 11,
                      child: Text('In Route'),
                    ),
                    const PopupMenuItem<int>(
                      value: 12,
                      child: Text('Sample Delivered'),
                    ),
                    const PopupMenuItem<int>(
                      value: 13,
                      child: Text('Sample Collected'),
                    ),
                    const PopupMenuItem<int>(
                      value: 14,
                      child: Text('Ride Started'),
                    ),
                    const PopupMenuItem<int>(
                      value: 15,
                      child: Text('Ride Arrived'),
                    ),
                    const PopupMenuItem<int>(
                      value: 16,
                      child: Text('Phone Called'),
                    ),
                    const PopupMenuItem<int>(
                      value: 17,
                      child: Text('Pending'),
                    ),
                  ],
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Image.asset(
                      "assets/filter.png",
                      // color: Colors.white,
                      width: Get.width * 0.06,
                    ),
                  ),
                ),
              ),
            ],
            centerTitle: true,
          ),
          //  bottomNavigationBar: CurvedNavigationBar(
          //   items: items,
          //   index: index,
          //   onTap: (int selectedIndex) {
          //     setState(() {
          //       index = selectedIndex;
          //                   if (selectedIndex == 1) {
          //         // Navigate to the Dashboard screen when Home icon is clicked
          //         Navigator.pushReplacement(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => Dashboard(
          //               userName: UserName.toString(),
          //               empId: widget.empId,
          //             ),
          //           ),
          //         );
          //       }

          //     });
          //   },
          //   height: 70,
          //   backgroundColor: Colors.transparent,
          //   animationDuration: const Duration(milliseconds: 300),
          //   color: Colors.blue,
          // ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/helpbackgraound.png'),
                alignment: Alignment.centerLeft,
              ),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: AuthTextField(
                      controller: searchController,
                      hintText: 'Search',
                      function: (p0) {
                        getappointments(
                            widget.empId, StartDate, EndDate, 25, start);
                      },
                    ),
                  ),
                  (((_appointments != null) ? _appointments.length : 0) != 0)
                      ? Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            // ignore: unnecessary_null_comparison
                            itemCount: ((_appointments != null)
                                ? _appointments.length
                                : 0),
                            itemBuilder: (context, index) {
                              User user = _appointments[index];

                              if (user.status == selectedStatusFilter) {
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${DateFormat('d MMMM y').format(DateTime.parse(user.StartDate!))} | ${_appointments[index].time ?? ""}',
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    user.status ?? "",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  //user.status
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                user.patientName
                                                        ?.toString()
                                                        .trim() ??
                                                    "",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 5),
                                              Text.rich(
                                                TextSpan(
                                                  text: "test".tr,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            user.test.trim() ??
                                                                "",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              user.address == ""
                                                  ? const SizedBox.shrink()
                                                  : Text.rich(
                                                      TextSpan(
                                                        text: "addres".tr,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        children: [
                                                          TextSpan(
                                                              text:
                                                                  user.address ??
                                                                      "",
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)),
                                                        ],
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.04),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                EditPatientController.i
                                                    .UpdatePatientId(
                                                        user.patientid);
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewInformation(
                                                              empId:
                                                                  widget.empId,
                                                              user: user,
                                                              labid:
                                                                  user.labTestChallanNo ??
                                                                      "",
                                                              startdate:
                                                                  StartDate,
                                                              enddate: EndDate,
                                                            )));

                                                await getappointments(
                                                    widget.empId,
                                                    StartDate,
                                                    EndDate,
                                                    25,
                                                    start);
                                                setState(() {});
                                                debugPrint(widget.empId);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                fixedSize: const Size(380, 4),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15), // Set the border radius here
                                                ),
                                              ),
                                              child: Text(
                                                'viewinformation'.tr,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                                    // child: ListTile(

                                    //   title: Text(user.patientName ?? "",style: GoogleFonts.poppins(fontSize: 20,color: Colors.white,),),
                                    //   subtitle: Text('Test  | ${user.test ?? ""}' ,style: GoogleFonts.poppins(fontSize: 12,color: Colors.white,)),

                                    // ),
                                  ),
                                );
                              } else if (selectedStatusFilter == "") {
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ListTile(
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${DateFormat('d MMMM y').format(DateTime.parse(user.StartDate!))} | ${_appointments[index].time ?? ""}',
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    user.status ?? "",
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  //user.status
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                user.patientName
                                                        ?.toString()
                                                        .trim() ??
                                                    "",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(height: 5),
                                              Text.rich(
                                                TextSpan(
                                                  text: "test".tr,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: [
                                                    TextSpan(
                                                        text:
                                                            user.test.trim() ??
                                                                "",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal)),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              user.address == ""
                                                  ? const SizedBox.shrink()
                                                  : Text.rich(
                                                      TextSpan(
                                                        text: "addres".tr,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        children: [
                                                          TextSpan(
                                                              text:
                                                                  user.address ??
                                                                      "",
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)),
                                                        ],
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Get.width * 0.04),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ViewInformation(
                                                              empId:
                                                                  widget.empId,
                                                              user: user,
                                                              labid:
                                                                  user.labTestChallanNo ??
                                                                      "",
                                                              startdate:
                                                                  StartDate,
                                                              enddate: EndDate,
                                                            )));
                                                await getappointments(
                                                    widget.empId,
                                                    StartDate,
                                                    EndDate,
                                                    25,
                                                    start);
                                                setState(() {});
                                                debugPrint(widget.empId);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                fixedSize: const Size(380, 4),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15), // Set the border radius here
                                                ),
                                              ),
                                              child: Text(
                                                'viewinformation'.tr,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                                    // child: ListTile(

                                    //   title: Text(user.patientName ?? "",style: GoogleFonts.poppins(fontSize: 20,color: Colors.white,),),
                                    //   subtitle: Text('Test  | ${user.test ?? ""}' ,style: GoogleFonts.poppins(fontSize: 12,color: Colors.white,)),

                                    // ),
                                  ),
                                );
                              } else {
                                const SizedBox.shrink();
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        )
                      : Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Center(
                              child: Text('appointmentsnotfound'.tr),
                            ),
                          ),
                        ),
                  (isLoadingmoreData == true)
                      ? const Padding(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          child: SpinKitSpinningLines(
                            color: Color(0xFF1272d3),
                            size: 60,
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ),
        ));
  }
}

String formatEndOfMonth(DateTime dateTime) {
  DateTime lastDayOfMonth = DateTime(dateTime.year, dateTime.month + 1, 0);
  return DateFormat("yyyy-MM-dd")
      .format(lastDayOfMonth.add(const Duration(days: 1)));
}

String formatDateWithTime(DateTime dateTime, {bool isEndOfDay = false}) {
  if (isEndOfDay) {
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(
        DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59));
  } else {
    return DateFormat("yyyy-MM-dd HH:mm:ss")
        .format(DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0));
  }
}
