import 'dart:convert';

import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/AppConstants.dart';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Screen/Appointments_Screen/_appointments_history.dart';
import 'package:flutter_riderapp/Screen/Nodata/Nodata.dart';
import 'package:flutter_riderapp/Screen/labqueue/collected_labqueue.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Labqeue extends StatefulWidget {
  const Labqeue({super.key});

  @override
  State<Labqeue> createState() => _LabqeueState();
}

class _LabqeueState extends State<Labqeue> {
    bool isLoadingData = false;
     bool isLoadingmoreData = false;
     int TotalRecordsData = 0;
     String StartDate = formatDate(DateTime.now());
          // ignore: non_constant_identifier_names
          String EndDate = formatDate(DateTime.now());
   // ignore: non_constant_identifier_names
  Future<List<User>> getappointments(String empId, String StartDate,
      // ignore: non_constant_identifier_names
      String EndDate, int length, int start) async {
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
      'length': length.toString(),
      'start': start.toString(),
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

  final ScrollController _scrollController = ScrollController();
    List<User> _appointments = [];
 
      int start=0;



callvback()async
{
  _appointments = await getappointments(userprofile!.id!, StartDate.toString().split(" ")[0], EndDate.toString().split(" ")[0],AppConstants.maximumDataTobeFetched, start);
setState(() {
  
});
}
  @override
 void initState() {
   if(_appointments.isEmpty)
    {
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
              'labqeue'.tr,
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
                     Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: ((_appointments.isNotEmpty)
                                ? _appointments.length
                                : 0),
                            itemBuilder: (context, index) {
                              
                                User user = _appointments[index];
                                        
                                
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 15, left: 15),
                                    child: Card(
                                      color: const Color(0xFF1272D3),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15),
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
                                                Text(
                                                  '${DateFormat('d MMMM y').format(DateTime.parse(user.StartDate!))} | ${_appointments[index].time ?? "" } | "+971 2345 6789" | "Mr # 0001',
                                                  style: const TextStyle(
                                                      fontSize: 8,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  user.patientName ?? "",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                               
                                                
                                               
                                                
                                              ],
                                            ),
                                            
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                Get.to(const NoDataFound());
                                              
                                                
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
                                                'samplecollection'.tr,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                      // child: ListTile(
                                        
                                      //   title: Text(user.patientName ?? "",style: GoogleFonts.poppins(fontSize: 20,color: Colors.white,),),
                                      //   subtitle: Text('Test  | ${user.test ?? ""}' ,style: GoogleFonts.poppins(fontSize: 12,color: Colors.white,)),
                                        
                                      // ),
                                    ),
                                  );
                                },
                              
                              
                           
                        
                ))],
                
            )),
          ),

        ));
  }
}

