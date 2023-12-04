import 'dart:async';
import 'dart:convert';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Screen/Dashboard/_dashboard.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_riderapp/AppConstants.dart';
import 'package:flutter_riderapp/Screen/ViewInformation/_view_information.dart';

import '../../Models/User.dart';
import '../../Utilities.dart';

// ignore: must_be_immutable
class AppointmentHistory extends StatefulWidget {
  String empId;

  AppointmentHistory({required this.empId, Key? key}) : super(key: key);

  @override
  State<AppointmentHistory> createState() => _AppointmentHistoryState();
}

class _AppointmentHistoryState extends State<AppointmentHistory> {
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // ignore: non_constant_identifier_names
  String Status = "";
  // ignore: unused_field
  late Future<List<User>> _appointmentsFuture;
  final List<User> _appointments = [];
  final dateFormat = DateFormat('yyyy-MM-dd');
  DateTime dateTime = DateTime.now().subtract(const Duration(days: 30));
  DateTime dateTime2 = DateTime.now();
  // ignore: non_constant_identifier_names
  int Selectedoption = 0;
  // ignore: non_constant_identifier_names
  DateTime? _Selected_Start_Date;
  // ignore: non_constant_identifier_names
  DateTime? _Selected_End_Date;
  String selectedStatusFilter = "";

  // ignore: unused_element
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(1200));

    if (picked != null && picked != _Selected_Start_Date) {
      setState(() {
        _Selected_Start_Date = picked;
      });
    }
  }

  // ignore: unused_element
  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != _Selected_End_Date) {
      setState(() {
        _Selected_End_Date = picked;
      });
    }
  }

  int start = 0;
  // ignore: non_constant_identifier_names
  int TotalRecordsData = 0;
  final ScrollController _scrollController = ScrollController();
  // ignore: non_constant_identifier_names
  late String StartDate;
  // ignore: non_constant_identifier_names
  late String EndDate;
  bool isLoadingData = false;
  bool isLoadingmoreData = false;
  @override
  void initState() {
    isLoadingData = false;
    isLoadingmoreData = false;
    setState(() {});

    StartDate = formatDateFromLastYear(
        DateTime.now().subtract(const Duration(days: 30)));
    EndDate = formatEndOfMonth(DateTime.now());
    resetAllDataValues();
    _appointmentsFuture = getappointments(widget.empId, StartDate, EndDate,
        AppConstants.maximumDataTobeFetched, start);
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {});
    });
    _scrollController.addListener(() {
      // var nextPageTrigger = 0.8 * _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        var isCallToFetchData = SetStartToFetchNextData();
        if (isCallToFetchData == true) {
          _appointmentsFuture = getappointments(widget.empId, StartDate,
              EndDate, AppConstants.maximumDataTobeFetched, start);
          setState(() {});
        }
      }
    });
    super.initState();
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

  // ignore: non_constant_identifier_names
  Future<List<User>> getappointments(
      String empId,
      // ignore: non_constant_identifier_names
      String StartDate,
      // ignore: non_constant_identifier_names
      String EndDate,
      int length,
      int start) async {
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
    };

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(requestBody));
    // print("Response: ${response.body}");

    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);
        // print("Response data: $data");
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
          setState(() {});
        }

        isLoadingData = false;
        isLoadingmoreData = false;
        setState(() {});
        return _appointments;
      } catch (e) {
        isLoadingData = false;
        isLoadingmoreData = false;
        setState(() {});
        throw Exception('Some thing wents wrong');
      }
    } else {
      isLoadingData = false;
      isLoadingmoreData = false;
      setState(() {});
      throw Exception('Failed to load appointments');
    }
  }

  final items = [
    const Icon(
      Icons.notifications,
      size: 30,
      color: Colors.white,
    ),
    const Icon(Icons.home, size: 30, color: Colors.white),
    const Icon(Icons.person, size: 30, color: Colors.white),
  ];
  int index = 1;

  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
        inAsyncCall: isLoadingData,
        blurEffectIntensity: 4,
        progressIndicator: const SpinKitSpinningLines(
          color: Color(0xff1272d3),
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
              'appointmenhistory'.tr,
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
                        selectedStatusFilter = "";
                        setState(() {});
                      } else if (value == 2) {
                        selectedStatusFilter = "Pending";
                        setState(() {});
                      } else if (value == 3) {
                        selectedStatusFilter = "Completed";
                        setState(() {});
                      } else if (value == 4) {
                        selectedStatusFilter = "Cancelled";
                        setState(() {});
                      } else if (value == 5) {
                        selectedStatusFilter = "Refunded";
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
                      child: Text('Pending'),
                    ),
                    const PopupMenuItem<int>(
                      value: 3,
                      child: Text('Completed'),
                    ),
                    const PopupMenuItem<int>(
                      value: 4,
                      child: Text('Cancelled'),
                    ),
                    const PopupMenuItem<int>(
                      value: 5,
                      child: Text('Refunded'),
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
          // bottomNavigationBar: CurvedNavigationBar(
          //   items: items,
          //   index: index,
          //   onTap: (int selectedIndex) {
          //     setState(() {
          //       index = selectedIndex;
          //                   if (selectedIndex == 1) {
          //         // Navigate to the Dashboard screen when Home icon is clicked
          //         Navigator.pop(context);
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
                  alignment: Alignment.centerLeft),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 27.0),
                      child: Text(
                        'from'.tr,
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.75,
                    ),
                    Text(
                      'to'.tr,
                      style: GoogleFonts.poppins(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: CupertinoTextField(
                              readOnly: true,
                              controller: TextEditingController(
                                text: dateFormat.format(dateTime),
                              ),
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(7),
                                color: CupertinoColors.white,
                              ),
                              prefix: const Icon(
                                Icons
                                    .calendar_month, // You can replace this with your desired icon
                                color: CupertinoColors.black,
                              ),
                              style: const TextStyle(
                                fontSize: 14,
                                color: CupertinoColors.black,
                              ),
                              onTap: () {
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext context) => Center(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: CupertinoDatePicker(
                                          backgroundColor: Colors.white,
                                          initialDateTime: dateTime,
                                          onDateTimeChanged:
                                              (DateTime newTime) {
                                            setState(() => dateTime = newTime);
                                          },
                                          use24hFormat: true,
                                          mode: CupertinoDatePickerMode.date,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          // child: TextFormField(
                          // readOnly: true,
                          //                onTap: () => _selectStartDate(context),
                          //                decoration: InputDecoration(
                          // labelText: _selectStartDate.toString(),
                          // prefixIcon: Icon(Icons.calendar_month)
                          //                ),
                          //                controller: TextEditingController(text: _Selected_Start_Date != null ? formatter.format(_Selected_Start_Date!):''),
                          // ),
                        )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.3,
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: CupertinoTextField(
                            placeholder: 'Select date',
                            readOnly: true,
                            controller: TextEditingController(
                              text: dateFormat.format(dateTime2),
                            ),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(10),
                              color: CupertinoColors.white,
                            ),
                            prefix: const Icon(
                              Icons
                                  .calendar_month, // You can replace this with your desired icon
                              color: CupertinoColors.black,
                            ),
                            style: const TextStyle(
                              fontSize: 14,
                              color: CupertinoColors.black,
                            ),
                            onTap: () {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext context) => Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: SizedBox(
                                            height: 200,
                                            child: CupertinoDatePicker(
                                              backgroundColor: Colors.white,
                                              initialDateTime: dateTime2,
                                              onDateTimeChanged:
                                                  (DateTime newTime) {
                                                setState(
                                                    () => dateTime2 = newTime);
                                              },
                                              use24hFormat: true,
                                              mode:
                                                  CupertinoDatePickerMode.date,
                                            ),
                                          ),
                                        ),
                                      ));
                            },
                          ),
                        ),
                      ),
                    ),
                    //          GestureDetector(
                    // onTap: () {
                    //   getappointments(widget.empId, dateTime.toString().split(' ').first, dateTime2.toString().split(' ').first, 50, 0);
                    //   print('Image tapped');
                    // },
                    //             child: SizedBox(
                    //               width: MediaQuery.of(context).size.width*0.09,
                    //               height: MediaQuery.of(context).size.height*0.09,
                    //               child: Image.asset("assets/search.png",
                    //               ),
                    //             ),
                    //           )
                    GestureDetector(
                      onTap: () async {
                        StartDate = formatDate(dateTime);
                        EndDate = formatDate(dateTime2);
                        resetAllDataValues();
                        // ignore: unused_local_variable
                        List<User> fetchedAppointments = await getappointments(
                          widget.empId,
                          formatDate(dateTime),
                          formatDate(dateTime2),
                          AppConstants.maximumDataTobeFetched,
                          0,
                        );
                        // setState(() {
                        //   _appointmentsFuture = Future.value(fetchedAppointments);
                        // });
                        // print('Image tapped');
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.09,
                        height: MediaQuery.of(context).size.height * 0.09,
                        child: Image.asset(
                          "assets/search.png",
                        ),
                      ),
                    )
                  ],
                ),

                // Expanded(
                //   child: FutureBuilder<List<User>>(
                //     future: _appointmentsFuture,
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return const Center(
                //           child: CircularProgressIndicator(),
                //         );
                //       } else if (snapshot.hasError) {
                //         return Center(
                //           child: Text('Error: ${snapshot.error}'),
                //         );
                //       } else {
                //         List<User> appointments = snapshot.data ?? [];
                //
                //         if (appointments.isEmpty) {
                //           return const Center(
                //             child: Text('No appointments.'),
                //           );
                //         }
                // ignore: unnecessary_null_comparison
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
                                                  fontWeight: FontWeight.bold),
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
                                                      text: user.test ?? "",
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
                                                              FontWeight.bold),
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                user.address ??
                                                                    "",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        12,
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
                                                            empId: widget.empId,
                                                            user: user,
                                                            labid:
                                                                user.labTestChallanNo ??
                                                                    "",
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
                                                borderRadius: BorderRadius.circular(
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
                                                  fontWeight: FontWeight.bold),
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
                                                      text: user.test ?? "",
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
                                                              FontWeight.bold),
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                user.address ??
                                                                    "",
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        12,
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
                                                            empId: widget.empId,
                                                            user: user,
                                                            labid:
                                                                user.labTestChallanNo ??
                                                                    "",
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
                                                borderRadius: BorderRadius.circular(
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
                          color: Color(0xff1272d3),
                          size: 60,
                        ),
                      )
                    : Container()

                //       }
                //     },
                //   ),
                // ),
              ],
            ),
          ),
        ));
  }
}

String formatDateFromLastYear(DateTime dateTime) {
  DateTime lastYear = DateTime(dateTime.year - 1, dateTime.month, dateTime.day);
  return DateFormat("yyyy-MM-dd").format(lastYear);
}

// String formatEndOfMonth(DateTime dateTime) {
//   DateTime lastDayOfMonth = DateTime(dateTime.year, dateTime.month + 1, 0);
//   return DateFormat("yyyy-MM-dd").format(lastDayOfMonth);
// }
String formatEndOfMonth(DateTime dateTime) {
  DateTime lastDayOfMonth = DateTime(dateTime.year, dateTime.month + 1, 0);
  return DateFormat("yyyy-MM-dd")
      .format(lastDayOfMonth.add(const Duration(days: 1)));
}

String formatDate(DateTime dateTime) {
  return DateFormat("yyyy-MM-dd").format(dateTime);
}
