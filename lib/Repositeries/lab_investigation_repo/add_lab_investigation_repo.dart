import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/AppConstants.dart';
import 'package:flutter_riderapp/Components/images/Images.dart';
import 'package:flutter_riderapp/LocalDb/localDB.dart';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Models/appointmentdetail.dart';
import 'package:flutter_riderapp/Models/lab_packages/lab_packages_model.dart';
import 'package:flutter_riderapp/Models/lab_test_model/lab_test_model.dart';
import 'package:flutter_riderapp/Models/labtest_home_model/labtest_home_model.dart';
import 'package:flutter_riderapp/Models/services_model/services_model.dart';
import 'package:flutter_riderapp/Repositeries/upload_file/upload_file_repo.dart';
import 'package:flutter_riderapp/Screen/Appointments_Screen/_today_appoinments.dart';
import 'package:flutter_riderapp/Screen/ViewInformation/_view_information.dart';
import 'package:flutter_riderapp/Screen/register_patient/succesful_appointment.dart';
import 'package:flutter_riderapp/Screen/register_patient/web_view.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/Widgets/Utils/toast+manager.dart';
import 'package:flutter_riderapp/controllers/addres_controller/address_controller.dart';
import 'package:flutter_riderapp/controllers/google_maps_controller/google_maps_controller.dart';
import 'package:flutter_riderapp/controllers/labinvestigation_controller/add_labinvestigation.dart';
import 'package:flutter_riderapp/controllers/labinvestigation_controller/lab_investigation_controller.dart';
import 'package:flutter_riderapp/controllers/packages_controller/packages_controller.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class LabInvestigationRepo1 {
  static getLabs() async {
    var body = {
      "TypeBit": "2",
      "Latitude": "",
      "Longitude": "",
      "BranchId": "",
      "Token": "44717866-70BA-4223-8F97-45286B2FD599"
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getLabs),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          log('success');
        } else {
          log(result['Status']);
        }
      }
    } catch (e) {
      // log(e.toString());
    }
  }

  static getspeciality() async {
    var body = {
      "TypeBit": "8",
      "Latitude": "",
      "Longitude": "",
      "BranchId": "",
      "Token": await LocalDb().getToken(),
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getLabs),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          log('success');
        } else {
          log(result['Status']);
        }
      }
    } catch (e) {
      // log(e.toString());
    }
  }

  static getspecialityservices() async {
    LabInvestigationController1.i.updateIsServicesLoading(true);
    var body = {
      "TypeBit": "8",
      "Latitude": "",
      "Longitude": "",
      "BranchId": "",
      "Token": await LocalDb().getToken(),
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getLabs),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        Iterable data = result['Data'];
        // log(data);
        if (result['Status'] == 1) {
          List<servicesmodel> md = data
              .map(
                (e) => servicesmodel.fromJson(e),
              )
              .toList();
          LabInvestigationController1.i.updateIsServicesLoading(false);
          return md;
        } else {
          LabInvestigationController1.i.updateIsServicesLoading(false);
          log(result['Status']);
        }
      }
    } catch (e) {
      LabInvestigationController1.i.updateIsServicesLoading(false);
      log(e.toString());
    }
  }

  static getLabservices(int value) async {
    var body = {
      "TypeBit": value,
      "Latitude": "",
      "Longitude": "",
      "BranchId": "",
      "Token": await LocalDb().getToken(),
    };
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(Uri.parse(AppConstants.getLabs),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        Iterable data = result['Data'];
        // log(data);
        if (result['Status'] == 1) {
          List<servicesmodel> md = data
              .map(
                (e) => servicesmodel.fromJson(e),
              )
              .toList();
          // lst=data[0]['Id'];
          LabInvestigationController1.i.updateIsServicesLoading(false);

          return md;
        } else {
          log(result['Status']);
          LabInvestigationController1.i.updateIsServicesLoading(false);
        }
      }
    } catch (e) {
      LabInvestigationController1.i.updateIsServicesLoading(false);
      // ToastManager.showToast('someerroroccured'.tr);
    }
  }

  bool isLoadingData = false;
  bool isLoadingmoreData = false;
  int TotalRecordsData = 0;
  final List<User> _appointments = [];
  int Filterstatus = 0;
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
    } else {
      isLoadingmoreData = true;
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
        }

        isLoadingData = false;
        isLoadingmoreData = false;

        return _appointments;
      } catch (e) {
        isLoadingData = false;
        isLoadingmoreData = false;

        throw Exception('Some thing wents wrong');
      }
    } else {
      isLoadingData = false;
      isLoadingmoreData = false;

      throw Exception('Failed to load appointments');
    }
  }

  static Future getservices(lst, int value) async {
    var token = await LocalDb().getToken();
    var body = {"LabId": lst, "Token": token, "TypeBit": value};

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    try {
      var response = await http.post(
          Uri.parse(
            AppConstants.getLabTests,
          ),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        log('message');
        var result = jsonDecode(response.body);

        if (result['Status'] == 1) {
          LabTestsModel labTestsModel =
              LabTestsModel.fromJson(jsonDecode(response.body));
          return labTestsModel;
        } else {
          log(result['Status'].toString());
          log('failed');
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      // log('$e ===>');
    }
  }

  static Future getconsultservices(lst) async {
    var token = await LocalDb().getToken();
    var body = {"LabId": lst, "Token": token, "TypeBit": "8"};

    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    try {
      var response = await http.post(
          Uri.parse(
            AppConstants.getLabTests,
          ),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        log('message');
        var result = jsonDecode(response.body);

        if (result['Status'] == 1) {
          LabTestsModel labTestsModel =
              LabTestsModel.fromJson(jsonDecode(response.body));
          return labTestsModel;
        } else {
          log(result['Status'].toString());
          log('failed');
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log('$e ===>');
    }
  }

  static Future getLabTests(pid) async {
    var token = await LocalDb().getToken();
    var branchID = await LocalDb().getBranchId();
    log('token = $token');
    log('branchID =$branchID');
    var body = {
      "LabId": "",
      "Token": token,
      "IsGetAllSubServices": true,
      "TypeBit": "8",
      "PatientId": pid,
    };
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    try {
      var response = await http.post(
          Uri.parse(
            AppConstants.getLabTests,
          ),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        log('message');
        var result = jsonDecode(response.body);

        if (result['Status'] == 1) {
          LabTestsModelHome labTestsModel =
              LabTestsModelHome.fromJson(jsonDecode(response.body));
          return labTestsModel;
        } else {
          log(result['Status'].toString());
          log('failed');
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {}
  }

  // static Future getDiagnostics() async {
  //   var token = await LocalDb().getToken();
  //   var branchID = await LocalDb().getBranchId();
  //   log('token = $token');
  //   log('branchID =$branchID');
  //   var body = {"LabId": "", "Token": token};
  //   var headers = {
  //     'Authorization': 'Bearer $token',
  //     'Content-Type': 'application/json'
  //   };

  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //           AppConstants.getDiagnostics,
  //         ),
  //         body: jsonEncode(body),
  //         headers: headers);
  //     if (response.statusCode == 200) {
  //       log('message');
  //       var result = jsonDecode(response.body);

  //       if (result['Status'] == 1) {
  //         LabTestsModelHome labTestsModel =
  //             LabTestsModelHome.fromJson(jsonDecode(response.body));
  //         return labTestsModel;
  //       } else {
  //         log(result['Status'].toString());
  //         log('failed');
  //       }
  //     } else {
  //       log(response.statusCode.toString());
  //     }
  //   } catch (e) {
  //     log('$e ===>');
  //   }
  // }

//   static getDiagnosticCenter(String id) async {
//     var token = await LocalDb().getToken();
//     var branchID = await LocalDb().getBranchId();
//     log('token = $token');
//     log('branchID =$branchID');

//     var body = {
//       "DiagnosticId": id,
//       "TypeBit": "3",
//       "Latitude": "",
//       "Longitude": "",
//       "BranchId": "",
//       "Token": token
//     };
// //{"LabId": "", "Token": token};
//     var headers = {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json'
//     };

//     try {
//       var response = await http.post(
//           Uri.parse(
//             AppConstants.getDiagnosticscenter,
//           ),
//           body: jsonEncode(body),
//           headers: headers);
//       if (response.statusCode == 200) {
//         log('message');
//         var result = jsonDecode(response.body);

//         if (result['Status'] == 1) {
//           Iterable data = result['Data'];
//           LabInvestigationController1.i.updatediagnosticscenter(
//               data.map((e) => Diagnosticscenter.fromJson(e)).toList());
//         } else {
//           log(result['Status'].toString());
//           log('failed');
//         }
//       } else {
//         log(response.statusCode.toString());
//       }
//     } catch (e) {
//       log('$e ===>');
//     }
//   }

//   static getDiagnosticSlots(String digid, String centr, String date) async {
//     var token = await LocalDb().getToken();
//     var branchID = await LocalDb().getBranchId();
//     // var patientId = await LocalDb().getPatientId();
//     log('token = $token');
//     log('branchID =$branchID');

//     var body = {
//       "DiagnosticId": digid,
//       "DayDate": date.split(' ')[0],
//       "DiagnosticCenterId": centr,
//       "Token": token
//     };
// //{"LabId": "", "Token": token};
//     var headers = {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json'
//     };

//     try {
//       var response = await http.post(
//           Uri.parse(
//             AppConstants.getDiagnosticslots,
//           ),
//           body: jsonEncode(body),
//           headers: headers);
//       if (response.statusCode == 200) {
//         log('message');
//         var result = jsonDecode(response.body);

//         if (result['Status'] == 1) {
//           Iterable dt = result['Sessions'];

//           List<Diagnosticsession> data =
//               dt.map((e) => Diagnosticsession.fromJson(e)).toList();

//           LabInvestigationController1.i.updatediagnosticslots(data[0].slots!);
//         } else {
//           log(result['Status'].toString());
//           log('failed');
//         }
//       } else {
//         log(response.statusCode.toString());
//       }
//     } catch (e) {
//       log('$e ===>');
//     }
//   }

  // static bookimageboking(Bookdiagnosticbody body) async {
  //   var token = await LocalDb().getToken();

  //   var headers = {
  //     'Authorization': 'Bearer $token',
  //     'Content-Type': 'application/json'
  //   };

  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //           AppConstants.BookDiagnosticAppointment,
  //         ),
  //         body: jsonEncode(body),
  //         headers: headers);
  //     if (response.statusCode == 200) {
  //       log('message');
  //       var result = jsonDecode(response.body);

  //       if (result['Status'] == 1) {
  //         Iterable data = result['AppointmentDetail'];
  //         List<Appointmentdetail> responsedata =
  //             data.map((e) => Appointmentdetail.fromJson(e)).toList();
  //         ToastManager.showToast(result['ErrorMessage'],
  //             bgColor: Colors.greenAccent);
  //         await confirmdiagnostic(
  //             responsedata.first.diagnosticAppointmentId,
  //             responsedata.first.patientDiagnosticAppointmentId,
  //             responsedata.first.diagnosticCenterId,
  //             body);
  //         await showDialog(
  //             context: Get.context!,
  //             builder: (context) {
  //               return StatefulBuilder(builder: (context, setstate) {
  //                 return Material(
  //                   type: MaterialType.transparency,
  //                   color: Colors.transparent,
  //                   child: AlertDialog(
  //                     backgroundColor: const Color.fromARGB(0, 178, 169, 169),
  //                     content: Column(
  //                       children: [
  //                         SizedBox(
  //                           height: Get.height * 0.08,
  //                         ),
  //                         AppointSuccessfulOrFailedWidget(
  //                           isLabInvestigationBooking: false,
  //                           titleImage: false,
  //                           image: Images.correct,
  //                           successOrFailedHeader: 'Appointment Successful',
  //                           appoinmentFailedorSuccessSmalltext:
  //                               'Your Appointment has been successfully booked',
  //                           firstButtonText: 'viewAppointment'.tr,
  //                           secondButtonText: 'cancel'.tr,
  //                           onPressedFirst: () async {
  //                             Get.offAll(() => const DrawerScreen());

  //                             BottomBarController.i
  //                                 .navigateToPage(1, filterType: 2);
  //                             ScheduleController.i
  //                                 .ApplyFilterForAppointments(2);
  //                             ScheduleController.i.update();
  //                             BottomBarController.i.update();
  //                             ScheduleController.i.updateLatestAppointment(
  //                                 result['Data']['AppointmentId']);
  //                           },
  //                           onPressedSecond: () {
  //                             Get.back();
  //                           },
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 );
  //               });
  //             });
  //       } else {
  //         ToastManager.showToast(result['ErrorMessage']);
  //       }
  //     } else {
  //       log(response.statusCode.toString());
  //     }
  //   } catch (e) {
  //     log('$e ===>');
  //   }
  // }

  // static confirmdiagnostic(
  //   String diagnosticid,
  //   String patientappointmentid,
  //   String diagnosticscenterid,
  //   Bookdiagnosticbody bd,
  // ) async {
  //   var token = await LocalDb().getToken();
  //   var patientid = await LocalDb().getPatientId();

  //   var body = {
  //     "DiagnosticId": bd.diagnosticId,
  //     "PatientId": "$patientid",
  //     "DiagnosticAppointmentId": diagnosticid,
  //     "PatientDiagnosticAppointmentId": patientappointmentid,
  //     "PaymentMethodId": "5B1C687C-24CE-E911-80CE-A0B3CCE147C0",
  //     "VouncherCode": "",
  //     "Price": "",
  //     "DiagnosticCenterId": bd.diagnosticCenterId,
  //     "Token": token,
  //   };
  //   var headers = {
  //     'Authorization': 'Bearer $token',
  //     'Content-Type': 'application/json'
  //   };
  //   log(body.toString());
  //   try {
  //     var response = await http.post(
  //         Uri.parse(
  //           AppConstants.ConfirmDiagnosticAppointment,
  //         ),
  //         body: jsonEncode(body),
  //         headers: headers);
  //     if (response.statusCode == 200) {
  //       log('message');
  //       var result = jsonDecode(response.body);

  //       if (result['Status'] == 1) {
  //         String url = result['Data']['ReturnURL'];
  //         await Get.to(() => WebView(
  //               url: url,
  //             ));
  //       } else {
  //         ToastManager.showToast(result['ErrorMessage'],
  //             bgColor: Colors.redAccent);
  //       }
  //     } else {
  //       log(response.statusCode.toString());
  //     }
  //   } catch (e) {
  //     log('$e ===>');
  //   }
  // }
//   {
//     DiagnosticIdAppointmentId:"ca73374f-3b85-ea11-80ce-005056af756c",
// PatientId:"530bc9c6-5f7c-e811-80be-005056af7162",
// PatientDiagnosticAppointmentId:"ca73374f-3b85-ea11-80ce-005056af756c",
// BranchId: "5BD60354-FEFD-4BCC-A58D-B8E27D802E85",
// Token: "ABB358A1-301C-4BBD-B8B7-01A1D903F770"
// }

  getPackages() async {
    var branchId = await LocalDb().getBranchId();
    var body = {"BranchId": "$branchId", "Length": 100};
    var headers = {'Content-Type': 'application/json'};

    try {
      var response = await http.post(Uri.parse(AppConstants.getPackages),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        if (result['Status'] == 1) {
          Packages package = Packages.fromJson(result);
          log('packages data length ${package.data?.length}');
          return package.data;
        }
      } else {
        log(response.statusCode.toString());
      }
    } catch (e) {
      log(e.toString());
    }
  }

  bookLabInvestigationOrHomeSampling(String Patientid, dynamic Discount,
      dynamic Typevalue, String Referencenumber, String fromtime,
      {List<LabTestHome>? list,
      bool? isHerefromHomeSample = false,
      bool? isLabInvestigationBooking = false,
      bool? isHereFromReports = false}) async {
    var patientId = Patientid;
    var cont = LabInvestigationController1.i;
    var maps = LabAddressController.i;
    // var packages = PackagesController.i;
    var discount = Discount;
    var typevalue = Typevalue;
    var referenceno = Referencenumber;

    List jsonList = [];
    LabTests? list;
    // if (isLabInvestigationBooking == true) {
    //   cont.selectedLabTests = list ?? [];
    // }
    for (int i = 0; i < cont.selectedservicelist!.length; i++) {
      list = cont.selectedservicelist?[i];
      for (int j = 0; j < list!.dTOlabGroupDetail!.length; j++) {
        jsonList.add({
          'TypeBit': "8",
          "Id": list.dTOlabGroupDetail![j].id,
          "LabTestId": list.dTOlabGroupDetail![j].id,
          "Price": list.dTOlabGroupDetail![j].price,
          "ActualPrice": 0.0,
          "IsForSampleCollectionCharges": false,
          "IsForAdditionalCharges": false,
          "IsForUrgentCharges": false,
          "IsAdditionalChargesForPassenger": false,
          "IsForCovid": false,
          "IsForAdditionalChargesForCovid": false,
          "SubServiceQuantity": cont.quantitycont.toString(),
        });
        // tr.packages[0].dTOPackageGroupDetail![i].toJson()
      }
    }
    String? fileAttachment;
    if (cont.file != null) {
      fileAttachment =
          await UploadFileRepo().updatePicture(cont.file ?? File(''));
    }
    cont.selectedLabTests.map((e) => jsonList.add(e.toJson())).toList();
    log('The length of jsonList is = ${jsonList.length}');
    // packages.selectedLabPackages?.map((e) => jsonList.add(e.toJson())).toList();
    log('${cont.selectedDate.toString().split(' ').first} ${cont.selectedLabTests} ${cont.prescribedBy} ${cont.totalSum}  ${cont.formattedSelectedTime.toString().split(' ').first}');
    if (cont.selectedLabValue == 1) {
      LabAddressController.i.updateAddress('');
      maps.currentLocation = [];
    }
    log('selected payment is ${cont.selectedPaymentMethod!.paymentMethodValue.toString()} ${cont.selectedPaymentMethod!.id.toString()}');
    var loginToken = await LocalDb().getToken();
    // String formattedTime = cont.formattedSelectedTime
    //     .toString()
    //     .split(' ')
    //     .first; // Get the formatted time
    // String timeHHMMSS = DateFormat('HH:mm:ss').format(
    //     DateFormat('hh:mm:ss').parse(formattedTime)); // Format as HH:MM:SS
    // String timeOnly = timeHHMMSS.substring(0, 8);
    // var totalSum = packages.totalSum + await packages.sumUpGrandTotal();
    var body = {
      "AdditionalSubServices": [],
      "UserId": userprofile?.id ?? "",
      "Address": LabAddressController.address ?? '',
      "AddressDetail": LabAddressController.address ?? '',
      "AirlineId": "",
      "AirportId": "",
      "ConsentFormLink": "",
      "Date": cont.formattedDate(cont.selectedDate.toString()).split(' ').first,
      "Distance": "",
      "DoctorId": "",
      // cont.prescribedBy == 'Doctor' ? cont.selectedDoctor?.id ?? '' : '',
      "FlightDate": "",
      "FlightDestinationId": "",
      "FlightNo": "",
      // "FileAttachment": fileAttachment ?? '',
      "LabId": "",
      "LabTests": jsonList,
      "Latitude": maps.currentLocation!.isNotEmpty
          ? maps.currentLocation![0].latitude
          : '',
      "Longitude": maps.currentLocation!.isNotEmpty
          ? maps.currentLocation![0].longitude
          : '',
      // "OutDoorDoctor": "${cont.prescribedBy}",
      "PackageGroupDiscountRate": "",
      "PackageGroupDiscountType": "",
      "PackageGroupId": "",
      "PackageGroupName": "",
      "PaidAmount": "",
      "PassengerNameRecord": "",
      "PassportImage": "",
      "PassportNo": "",
      "PatientId": patientId,
      "PaymentMethodId": cont.selectedPaymentMethod?.id ?? '',
      "PaymentMethodValue":
          cont.selectedPaymentMethod?.paymentMethodValue ?? '',
      "SampleImage": "",
      "TicketImage": "",
      "Time": fromtime,
      "Token": "$loginToken",
      "VouncherCode": "",
      "Price": "${cont.totalSum}",
      "ToDate":
          "${cont.formattedDate(cont.selectedDate1.toString().split(' ').first)}",
      "ToTime": cont.formattedSelectedTimeto.toString(),
      "Discount": discount,
      "DiscountTypes": typevalue == "Percentage" ? 2 : 1,
      "TotalWithDiscount": cont.grandprice,
      "ReferenceType": "1",
      "ReferenceNumber": referenceno.toString(),
      "IsCombineMultiServices": 1,
      "PaymentStatus": cont.selectedstatusvalue.toString(),
      "IsFromRiderApp": "true",
      "iscombinemultiservices": true,
    };

    log(body.toString());
    log(fileAttachment.toString());
    // body['PaymentMethodValue']='5';
    var headers = {'Content-Type': 'application/json'};
    cont.updateIsLoading(true);
    try {
      var result = await http.post(
          Uri.parse(AppConstants.confirmLabTestPaymentUri),
          headers: headers,
          body: jsonEncode(body));
      if (result.statusCode == 200) {
        var response = jsonDecode(result.body);
        if (response['Status'] == 1) {
          log(response.toString());
          Get.to(() => SuccessFulAppointScreen(
              imagePath: cont.selectedLabValue == 1
                  ? 'assets/images/Frame2.png'
                  : Images.logo,
              isLabInvestigationBooking:
                  cont.selectedLabValue == 1 ? true : false,
              onPressedSecond: () {
                Get.back();
              },
              firstButtonText: 'viewAppointment'.tr,
              title: 'congratulations'.tr,
              appoinmentFailedorSuccessSmalltext: 'appointmentSuccessful'.tr,
              onPressedFirst: () {
                Get.offAll(() => TodayAppoinments(
                      empId: userprofile!.id!,
                    ));
              }));

          if (response['ErrorMessage'] == 'Successfully Booked') {
            // if (cont.selectedPaymentMethod?.paymentMethodValue == 5) {
            //   var url = response['Data']['transaction']['url'];
            //   log('$url');
            //   Get.to(() => WebView(
            //         url: url,
            //       ));
            // }
            Get.to(() => SuccessFulAppointScreen(
                imagePath: cont.selectedLabValue == 1
                    ? 'assets/images/Frame2.png'
                    : Images.logo,
                isLabInvestigationBooking:
                    cont.selectedLabValue == 1 ? true : false,
                onPressedSecond: () {
                  Get.back();
                },
                firstButtonText: 'viewAppointment'.tr,
                title: 'congratulations'.tr,
                appoinmentFailedorSuccessSmalltext: 'appointmentSuccessful'.tr,
                onPressedFirst: () {
                  Get.offAll(() => TodayAppoinments(
                        empId: userprofile!.id!,
                      ));
                  // if (isHereFromReports == true) {
                  //   Get.back();
                  // }
                  // BottomBarController.i.navigateToPage(1, filterType: 3);
                  // ScheduleController.i.ApplyFilterForAppointments(3);
                  // ScheduleController.i.updateSelectedService(1);
                  // ScheduleController.i.updateIndexOfAppointmentList(1);
                  // ScheduleController.i.update();
                  // BottomBarController.i.update();
                }));
          }
          cont.updateIsLoading(false);
        } else {
          LabInvestigationController1.i.selectedLabTests = [];
          // LabInvestigationController1.i.prescribedBy = null;
          LabInvestigationController1.i.totalSum = 0.0;
          LabInvestigationController1.i.selectedDate = DateTime.now();
          cont.updateIsLoading(false);
          var response = jsonDecode(result.body);
          log(response.toString());
          ToastManager.showToast('${response['ErrorMessage']}',
              bgColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor);
        }

        cont.updateIsLoading(false);
      } else {
        var response = jsonDecode(result.body);
        ToastManager.showToast('${response['ErrorMessage']}');
        cont.updateIsLoading(false);
        LabInvestigationController1.i.selectedDate = DateTime.now();
      }
    } catch (e) {
      // log(e.toString());
      // handleError(e);
      // ToastManager.showToast(e.toString());
      // cont.updateIsLoading(false);
      // LabInvestigationController1.i.selectedDate = DateTime.now();
    }
  }

  String formatDateWithTime(DateTime dateTime, {bool isEndOfDay = false}) {
    if (isEndOfDay) {
      return DateFormat("yyyy-MM-dd HH:mm:ss").format(
          DateTime(dateTime.year, dateTime.month, dateTime.day, 23, 59, 59));
    } else {
      return DateFormat("yyyy-MM-dd HH:mm:ss").format(
          DateTime(dateTime.year, dateTime.month, dateTime.day, 0, 0, 0));
    }
  }

  updatebookLabInvestigation(
      String Patientid,
      dynamic Discount,
      dynamic Typevalue,
      String branchlocationid,
      dynamic appoinmentno,
      String starttime,

      // String subservicename,

      {List<LabTestHome>? list}) async {
    var patientId = Patientid;
    var appointmentNo = appoinmentno;
    var cont = LabInvestigationController1.i;
    var maps = AddressController.i;
    // var packages = PackagesController.i;
    var discount = Discount;
    var typevalue = Typevalue;
    // var branchLocationId = branchlocationid;
    // var subServiceName = subservicename;

    List jsonList = [];
    LabTestHome? list;
    // if (isLabInvestigationBooking == true) {
    //   cont.selectedLabTests = list ?? [];
    // }
    for (int i = 0; i < cont.selectedLabTests.length; i++) {
      list = cont.selectedLabTests[i];

      jsonList.add({
        "SubServiceId": list.id,
        "SubServiceQuantity": list.quantity,
        "Price": list.actualPrice,
        'TypeBit': "8",
        "SubServiceName": list.name,
      });
      // tr.packages[0].dTOPackageGroupDetail![i].toJson()
    }
    String? fileAttachment;
    if (cont.file != null) {
      fileAttachment =
          await UploadFileRepo().updatePicture(cont.file ?? File(''));
    }
    // cont.selectedLabTests.map((e) => jsonList.add(e.toJson())).toList();
    log('The length of jsonList is = ${jsonList.length}');
    // packages.selectedLabPackages?.map((e) => jsonList.add(e.toJson())).toList();
    log('${cont.selectedDate.toString().split(' ').first} ${cont.selectedLabTests} ${cont.prescribedBy} ${cont.totalSum}  ${cont.formattedSelectedTime.toString().split(' ').first}');
    if (cont.selectedLabValue == 1) {
      AddressController.i.updateAddress('');
      maps.currentLocation = [];
    }
    log('selected payment is ${cont.selectedPaymentMethod!.paymentMethodValue.toString()} ${cont.selectedPaymentMethod!.id.toString()}');
    var loginToken = await LocalDb().getToken();
    // var totalS;um = packages.totalSum + await packages.sumUpGrandTotal();

    var body = {
      // "AdditionalSubServices": [],
      "PatientId": patientId,
      "StartDate":
          cont.formattedDate(cont.selectedDate.toString()).split(' ').first,
      "StartTime": starttime,
      "Address": AddressController.address ?? '',
      "AddressDetail": AddressController.address ?? '',

      "Latitude": maps.currentLocation!.isNotEmpty
          ? maps.currentLocation![0].latitude
          : '',
      "Longitude": maps.currentLocation!.isNotEmpty
          ? maps.currentLocation![0].longitude
          : '',
      "AppointmentNo": appointmentNo,
      "UserId": userprofile?.id ?? "",
      "BranchLocationId": branchlocationid,
      "AppointmentAmount": cont.totalprice,
      "AppointmentDiscountType": typevalue == "Percentage" ? 2 : 1,
      "AppointmentDiscount": discount,
      "AppointmentTotalWithDiscount":
          '${cont.discountamount.text == "0.0" || cont.discountamount.text.isEmpty || cont.discountamount.text == "0" ? cont.totalprice.toStringAsFixed(2) : cont.grandprice.toStringAsFixed(2)}',
      "SubServicesList": jsonList,
      // "IsFromRiderApp": "true",
      // "iscombinemultiservices": true,
    };

    log(body.toString());
    log(fileAttachment.toString());
    // body['PaymentMethodValue']='5';
    var headers = {'Content-Type': 'application/json'};
    cont.updateIsLoading(true);
    try {
      var result = await http.post(Uri.parse(AppConstants.updateLabTests),
          headers: headers, body: jsonEncode(body));
      if (result.statusCode == 200) {
        var response = jsonDecode(result.body);
        if (response['Id'] == 2) {
          log(response.toString());

          // User? user = User(
          //   UserName: "",
          //   Password: "",
          //   empId: "",
          //   start: "",
          //   StartDate: LabInvestigationController1.i.date,
          //   EndDate: "",
          //   patientName: LabInvestigationController1.i.username,
          //   test: LabInvestigationController1.i.test,
          //   address: LabInvestigationController1.i.Address,
          //   status: LabInvestigationController1.i.status1,
          //   patientid: LabInvestigationController1.i.patientid,
          //   message: "",
          //   ride_CancelRemarks: "",
          //   appointmentno: "",
          //   branchlocationid: LabInvestigationController1.i.branchid,
          //   Patientappoinmentid: "",
          //   LabNo: LabInvestigationController1.i.appointment,
          //   price: LabInvestigationController1.i.totalprice.toString(),
          //   url: "",
          //   imagePath: "",
          //   cNICNumber: "",
          //   latitude: "",
          //   longitude: "",
          //   vehicleno: "",
          //   dob: "",
          //   cellNumber: "",
          //   token: "",
          //   labTestChallanNo: "",
          //   time: LabInvestigationController1.i.time,
          //   Labid: "",
          //   inroutelat: "",
          //   inroutelon: "",
          //   paymentstatusname: LabInvestigationController1.i.paymentstatus,
          //   paymentstatusvalue: cont.selectedstatusvalue,
          //   visitno: LabInvestigationController1.i.visitno,
          //   PatientServiceAppointmentId:
          //       LabInvestigationController1.i.patientstatusid,
          //   subserviceid: list?.id,
          //   StatusValue: "",
          //   MRNo: "",
          //   LabName: "",
          //   LabTestIds: "",
          //   PrescribedBy: "",
          //   Action: "",
          //   ModifiedOn: "",
          //   PrescribeByDoctorId: "",
          //   PatientTypesHtmlValue: "",
          //   FlightNo: "",
          //   FlightDate: "",
          //   AirlineId: "",
          //   FlightDestinationId: "",
          //   PassengerNameRecord: "",
          //   StatusType: "",
          //   PaymentMethodId: "",
          //   LastProcessedBy: "",
          //   LastProcessedOn: "",
          //   IsNotCompleted: "",
          //   InRouteDeliveryBranchLocationId: "",
          //   AppointmentStatusCount: "",
          //   AppointmentStatus: "",
          //   InvoiceURL: "",
          //   TypeBit: "",
          //   IsAlreadyCheckedIn: "",
          //   TotalAppointmentFee: "",
          //   referencetype: "",
          //   amount: "",
          //   discounttype: "",
          //   discount: LabInvestigationController1.i.discount1,
          //   totalamount: "",
          //   iscombine: "",
          //   refNo: "",
          //   id: "",
          //   mRNo: "",
          //   email: "",
          //   switchUserId: "",
          //   switchByUser: "",
          //   isChildAccount: false,
          //   isSwitchAccount: false,
          //   username: "",
          //   fullName: "",
          //   firstName: "",
          //   displayname: "",
          //   branchName: "",
          //   organizationPicturePath: "",
          //   branchId: "",
          //   branchAddress: "",
          //   branchTelNo: "",
          //   branchEmail: "",
          //   userType: 0,
          //   errorMessage: "",
          //   workingSessionId: "",
          //   countryId: "",
          //   cityId: "",
          //   stateOrProvinceId: "",
          //   country: "",
          //   city: "",
          //   stateOrProvince: "",
          //   deviceToken: "",
          //   webToken: "",
          //   patientAddress: "",
          //   passport: "",
          //   isFlightDetail: 0,
          //   workingSessions: "",
          //   genderName: "",
          //   registrationDate: "",
          //   panelExpiryDate: "",
          //   panelOrganizationName: "",
          //   panelPackageName: "",
          //   panelPackageDiscount: "",
          //   panelPackageDiscountType: "",
          //   dateofbirth: "",
          //   maritalStatus: "",
          // );

          // List<apointmentdetail> test =
          //     LabInvestigationController1.i.appointments = [];
          // String StartDate = formatDateFromLastYear(
          //     DateTime.now().subtract(const Duration(days: 30)));
          // String EndDate = formatDateWithTime(DateTime.now(), isEndOfDay: true);
          // Get.offAll(() => ViewInformation(
          //     user: user,
          //     empId: userprofile!.id!,
          //     labid: "",
          //     startdate: StartDate,
          //     enddate: EndDate));
          // Get.back();
          Get.back();

          if (response['ErrorMessage'] == 'Successfully Booked') {
            // if (cont.selectedPaymentMethod?.paymentMethodValue == 5) {
            //   var url = response['Data']['transaction']['url'];
            //   log('$url');
            //   Get.to(() => WebView(
            //         url: url,
            //       ));
            // }
            User? user;
            late String StartDate;

            late String EndDate;
            StartDate = formatDateFromLastYear(
                DateTime.now().subtract(const Duration(days: 30)));
            EndDate = formatDateWithTime(DateTime.now(), isEndOfDay: true);
            Get.to(() => ViewInformation(
                  empId: userprofile!.id!,
                  user: user!,
                  labid: user.labTestChallanNo ?? "",
                  startdate: StartDate,
                  enddate: EndDate,
                ));
          }
          cont.updateIsLoading(false);
        } else {
          // LabInvestigationController1.i.selectedLabTests = [];
          // LabInvestigationController1.i.prescribedBy = null;
          LabInvestigationController1.i.totalSum = 0.0;
          LabInvestigationController1.i.selectedDate = DateTime.now();
          cont.updateIsLoading(false);
          var response = jsonDecode(result.body);
          log(response.toString());
          ToastManager.showToast('${response['ErrorMessage']}',
              bgColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor);
        }

        cont.updateIsLoading(false);
      } else {
        var response = jsonDecode(result.body);
        ToastManager.showToast('${response['ErrorMessage']}');
        cont.updateIsLoading(false);
        LabInvestigationController1.i.selectedDate = DateTime.now();
      }
    } catch (e) {
      // log(e.toString());
      // handleError(e);
      // ToastManager.showToast(e.toString());
      // cont.updateIsLoading(false);
      // LabInvestigationController1.i.selectedDate = DateTime.now();
    }
  }

  bookServicesHome(
      {List<LabTests>? list,
      bool? isserviceBooking = false,
      String? appointmentnotes}) async {
    var patientId = await LocalDb().getPatientId();
    var cont = LabInvestigationController1.i;
    var maps = AddressController.i;

    log('the patient id is $patientId');

    log(AddressController.address.toString());

    List jsonList = [];

    if (isserviceBooking == true) {
      cont.selectedservicelist = list;
    }
    cont.selectedservicelist!.map((e) => jsonList.add(e.toJson())).toList();
    log('${cont.selectedDate.toString().split(' ').first} ${cont.selectedservicelist} ${cont.ServicesBy} ${cont.totalSum}  ${cont.formattedSelectedTime.toString().split(' ').first}');
    if (isserviceBooking == true) {
      AddressController.i.updateAddress('');
    }

    log('selected payment is ${cont.selectedPaymentMethod1!.paymentMethodValue.toString()} ${cont.selectedPaymentMethod1!.id.toString()}');
    var loginToken = await LocalDb().getToken();
    var body = {
      "AdditionalSubServices": [],
      "Address": AddressController.address ?? '',
      "AddressDetail": "",
      "AirlineId": "",
      "AirportId": "",
      "ConsentFormLink": "",
      "Date": cont.selectedDate.toString().split(' ').first,
      "Distance": "",
      "DoctorId": cont.selectedDoctor?.id ?? '',
      "FlightDate": " ",
      "FlightDestinationId": "",
      "FlightNo": "",
      //"LabId": "d8340ed5-af5d-4f68-895b-0350114aab09",
      "LabTests": jsonList,
      "Latitude": maps.currentLocation!.isNotEmpty
          ? maps.currentLocation![0].latitude
          : '',
      "Longitude": maps.currentLocation!.isNotEmpty
          ? maps.currentLocation![0].longitude
          : '',
      "OutDoorDoctor": "${cont.ServicesBy}",
      "PackageGroupDiscountRate": "",
      "PackageGroupDiscountType": "",
      "PackageGroupId": "",
      "PackageGroupName": "",
      "PaidAmount": "${cont.totalSum1}",
      "PassengerNameRecord": "",
      "PassportImage": "",
      "PassportNo": "",
      "PatientId": "$patientId",
      "PaymentMethodId": cont.selectedPaymentMethod1?.id ?? '',
      "PaymentMethodValue":
          cont.selectedPaymentMethod1?.paymentMethodValue ?? '',
      "SampleImage": "",
      "TicketImage": "",
      "Time": cont.formattedSelectedTime.toString().split(' ').first,
      "Token": "$loginToken",
      "VouncherCode": "",
      "Price": "${cont.totalSum1}",
      "AppointmentNotes": appointmentnotes,
    };

    log(body.toString());
    // body['PaymentMethodValue']='5';

    var headers = {'Content-Type': 'application/json'};
    cont.updateIsLoading(true);
    cont.updateIsServicesLoading(true);
    try {
      var result = await http.post(
          Uri.parse(AppConstants.confirmLabTestPaymentUri),
          headers: headers,
          body: jsonEncode(body));
      if (result.statusCode == 200) {
        var response = jsonDecode(result.body);
        log(response.toString());
        if (response['Status'] == 1) {
          log(response.toString());
          Get.to(() => SuccessFulAppointScreen(
                imagePath: Images.services,
                firstButtonText: 'viewAppointment'.tr,
                title: 'congratulations'.tr,
                appoinmentFailedorSuccessSmalltext: 'serviceBooked'.tr,
                onPressedFirst: () {
                  Get.back();
                  Get.back();
                  // BottomBarController.i.navigateToPage(1, filterType: -1);
                  // ScheduleController.i.ApplyFilterForAppointments(-1);
                },
                onPressedSecond: (() {
                  Get.back();
                }),
              ));
        } else {
          Get.to(() => SuccessFulAppointScreen(
                title: 'congratulations'.tr,
                appoinmentFailedorSuccessSmalltext: 'serviceBooked'.tr,
                firstButtonText: 'viewAppointment'.tr,
                onPressedSecond: () {
                  Get.close(2);
                },
                onPressedFirst: () {
                  Get.close(2);
                  // BottomBarController.i.navigateToPage(1);
                },
              ));
        }
        LabInvestigationController1.i.selectedservicelist = [];
        LabInvestigationController1.i.ServicesBy = null;
        LabInvestigationController1.i.totalSum1 = 0.0;
        LabInvestigationController1.i.selectedDate = DateTime.now();

        if (response['ErrorMessage'] == 'Successfully Booked') {
          if (cont.selectedPaymentMethod1?.paymentMethodValue == 5) {
            var url = response['Data']['transaction']['url'];
            log('$url');
            Get.to(() => WebView(
                  url: url,
                ));
          }
        }
        cont.updateIsLoading(false);
        cont.updateIsServicesLoading(false);
      } else {
        var response = jsonDecode(result.body);
        ToastManager.showToast('${response['ErrorMessage']}');
        cont.updateIsLoading(false);
        cont.updateIsServicesLoading(false);
        LabInvestigationController1.i.selectedDate = DateTime.now();
      }
    } catch (e) {
      cont.updateIsLoading(false);
      cont.updateIsServicesLoading(false);
      LabInvestigationController1.i.selectedDate = DateTime.now();
    }
  }

//   bookspecialitisservices(
//       {List<LabTests>? list,
//       bool? isserviceBooking = false,
//       String? appointmentnotes}) async {
//     var patientId = await LocalDb().getPatientId();
//     var cont = LabInvestigationController1.i;
//     var maps = AddressController.i;
//     List jsonList = [];
//     if (isserviceBooking == true) {
//       cont.selectedconsultservice = list;
//     }
//     cont.selectedconsultservice!.map((e) => jsonList.add(e.toJson())).toList();
//     if (isserviceBooking == true) {
//       AddressController.i.updateAddress('');
//     }

// //  List jsonList = [];
// //     if (isserviceBooking == true) {
// //       cont.selectedLabTests = list;
// //     }
// //     cont.selectedLabTests!.map((e) => jsonList.add(e.toJson())).toList();
// //     log('${cont.selectedDate.toString().split(' ').first} ${cont.selectedLabTests} ${cont.prescribedBy} ${cont.totalSum}  ${cont.formattedSelectedTime.toString().split(' ').first}');
// //     if (isserviceBooking == true) {
// //       AddressController.i.updateAddress('');
// //     }
//     log('selected payment is ${cont.selectedPaymentMethod2!.paymentMethodValue.toString()} ${cont.selectedPaymentMethod2!.id.toString()}');
//     var loginToken = await LocalDb().getToken();
//     var body = {
//       "AdditionalSubServices": [],
//       "AirlineId": "",
//       "AirportId": "",
//       "ConsentFormLink": "",
//       "Date": cont.selectedDate.toString().split(' ').first,
//       "Distance": "",
//       "DoctorId": cont.selectedDoctor?.id ?? '',
//       "FlightDate": " ",
//       "FlightDestinationId": "",
//       "FlightNo": "",
//       //"LabId": "d8340ed5-af5d-4f68-895b-0350114aab09",
//       "LabTests": jsonList,
//       "Latitude": maps.currentLocation!.isNotEmpty
//           ? maps.currentLocation![0].latitude
//           : '',
//       "Longitude": maps.currentLocation!.isNotEmpty
//           ? maps.currentLocation![0].longitude
//           : '',
//       "OutDoorDoctor": "${cont.ServicesBy}",
//       "PackageGroupDiscountRate": "",
//       "PackageGroupDiscountType": "",
//       "PackageGroupId": "",
//       "PackageGroupName": "",
//       "PaidAmount": "${cont.totalSum2}",
//       "PassengerNameRecord": "",
//       "PassportImage": "",
//       "PassportNo": "",
//       "PatientId": "$patientId",
//       "PaymentMethodId": cont.selectedPaymentMethod2?.id ?? '',
//       "PaymentMethodValue":
//           cont.selectedPaymentMethod2?.paymentMethodValue ?? '',
//       "SampleImage": "",
//       "TicketImage": "",
//       "Time": cont.formattedSelectedTime.toString().split(' ').first,
//       "Token": "$loginToken",
//       "VouncherCode": "",
//       "Price": "${cont.totalSum2}",
//       "AppointmentNotes": appointmentnotes,
//       "SpecialityId": cont.doctorspeciality?.id,
//       "IsOnlineAppointment": cont.Status,
//     };

//     log(body.toString());
//     // body['PaymentMethodValue']='5';

//     var headers = {'Content-Type': 'application/json'};
//     cont.updateIsLoading(true);
//     try {
//       var result = await http.post(
//           Uri.parse(AppConstants.confirmLabTestPaymentUri),
//           headers: headers,
//           body: jsonEncode(body));
//       if (result.statusCode == 200) {
//         var response = jsonDecode(result.body);
//         if (response['Status'] == 1) {
//           log(response.toString());
//           Get.to(() => SuccessFulAppointScreen(
//                 title: 'Congratulations',
//                 appoinmentFailedorSuccessSmalltext:
//                     'Your Appointment Has been Booked Successfully',
//                 onPressedFirst: (() {
//                   Get.to(() => SuccessFulAppointScreen(
//                         title: 'congratulations'.tr,
//                         appoinmentFailedorSuccessSmalltext: 'serviceBooked'.tr,
//                         onPressedFirst: () {
//                           Get.offUntil(
//                             MaterialPageRoute(
//                                 builder: (_) => doctorconsultation(
//                                       title: 'doctorconsultation'.tr,
//                                     )),
//                             (route) => false,
//                           );
//                         },
//                       ));
//                 }),
//               ));
//         } else {
//           ToastManager.showToast('pleasetryagain'.tr);
//         }
//         LabInvestigationController1.i.selectedconsultservice = [];
//         LabInvestigationController1.i.Status = null;
//         // LabInvestigationController1.i.selectedPaymentMethod2 = null;
//         LabInvestigationController1.i.totalSum2 = 0.0;
//         LabInvestigationController1.i.selectedDate = DateTime.now();

//         if (response['ErrorMessage'] == 'Successfully Booked') {
//           if (cont.selectedPaymentMethod2?.paymentMethodValue == 5) {
//             var url = response['Data']['transaction']['url'];
//             log('$url');
//             Get.to(() => WebView(
//                   url: url,
//                 ));
//           }
//         }
//         cont.updateIsLoading(false);
//       } else {
//         ToastManager.showToast('${result.statusCode}');

//         cont.updateIsLoading(false);
//         LabInvestigationController1.i.selectedDate = DateTime.now();
//       }
//     } catch (e) {
//       handleError(e);
//       cont.updateIsLoading(false);
//       LabInvestigationController1.i.selectedDate = DateTime.now();
//     }
//   }

  // static getspecialities() async {
  //   var patientId = await LocalDb().getPatientId();
  //   var body = {
  //     "PatientId": patientId,
  //     "BranchId": await LocalDb().getBranchId(),
  //     "Token": await LocalDb().getToken(),
  //     "Search": ""
  //   };
  //   var headers = {'Content-Type': 'application/json'};
  //   try {
  //     var response = await http.post(Uri.parse(AppConstants.getSpecialities),
  //         body: jsonEncode(body), headers: headers);
  //     if (response.statusCode == 200) {
  //       var result = jsonDecode(response.body);
  //       if (result['Status'] == 1) {
  //         Specialities specialities =
  //             Specialities.fromJson(jsonDecode(response.body));
  //         log('${specialities.toString()} specialities');
  //         return specialities;
  //       } else {
  //         log(result['Status']);
  //       }
  //     }
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  // static getDoctors() async {
  //   var body = {"DoctorId": "", "Token": ""};
  //   var headers = {'Content-Type': 'application/json'};

  //   try {
  //     var response = await http.post(Uri.parse(AppConstants.doctorsListURI),
  //         body: jsonEncode(body), headers: headers);
  //     if (response.statusCode == 200) {
  //       var result = jsonDecode(response.body);
  //       if (result['Status'] == 1) {
  //         DoctorsResponse response = DoctorsResponse.fromJson(result);
  //         return response.doctors;
  //       } else {
  //         ToastManager.showToast('${result['ErrorMessage']}');
  //       }
  //     } else {
  //       // ignore: unused_local_variable
  //       // var result = jsonDecode(response.body);
  //       // ToastManager.showToast('${result.statusCode}');
  //     }
  //   } catch (e) {
  //     ToastManager.showToast('couldNotFetchDoctors'.tr);
  //   }
  // }
}
