import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/AppConstants.dart';
import 'package:flutter_riderapp/Components/images/Images.dart';
import 'package:flutter_riderapp/Components/images/custom_container/custom_container.dart';
import 'package:flutter_riderapp/Models/appointmentdetail.dart';
import 'package:flutter_riderapp/Models/checkinresponse.dart';
import 'package:flutter_riderapp/Models/checkintry.dart';
import 'package:flutter_riderapp/Models/consent_model/consent_model.dart';
import 'package:flutter_riderapp/Models/in_routeModel.dart';
import 'package:flutter_riderapp/Models/lab_investigation_model/lab_investigation_model.dart';
import 'package:flutter_riderapp/Models/labsmodel.dart';
import 'package:flutter_riderapp/Models/payment_method.dart';
import 'package:flutter_riderapp/Models/sample_delivered.dart';
import 'package:flutter_riderapp/Models/samplebody.dart';
import 'package:flutter_riderapp/Models/samplecollectedmodel.dart';
import 'package:flutter_riderapp/Models/samplecollectionresponse.dart';
import 'package:flutter_riderapp/Screen/Appointments_Screen/_today_appoinments.dart';
import 'package:flutter_riderapp/Screen/Dashboard/_dashboard.dart';
import 'package:flutter_riderapp/Screen/ViewInformation/edit_patient.dart';
import 'package:flutter_riderapp/Screen/register_patient/lab_investigation.dart';
import 'package:flutter_riderapp/Widgets/Custombutton.dart';
import 'package:flutter_riderapp/Widgets/Customdropdown.dart';
import 'package:flutter_riderapp/Widgets/Utils/toaster.dart';
import 'package:flutter_riderapp/controllers/consent_controller/consent_controller.dart';
import 'package:flutter_riderapp/controllers/edit_patient_controller.dart';
import 'package:flutter_riderapp/controllers/labinvestigation_controller/lab_investigation_controller.dart';
import 'package:flutter_riderapp/data/Notification_repo/auth_repo.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:flutter_riderapp/helpers/pdf_view/pdf_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Models/User.dart';
import 'package:http/http.dart' as http;
import '../../Utilities.dart';
import 'package:location/location.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart' as urllauncher;

// ignore: must_be_immutable
class ViewInformation extends StatefulWidget {
  User user;
  String labid;

  String empId;
  String startdate;
  String enddate;

  ViewInformation(
      {required this.user,
      required this.empId,
      required this.labid,
      required this.startdate,
      required this.enddate,
      Key? key})
      : super(key: key);

  @override
  State<ViewInformation> createState() => _ViewInformationState();
}

class _ViewInformationState extends State<ViewInformation> {
  String? Selectpayment;
  String? SelectLab;
  String? selectedLabsName;
  LabsModel? _selectedlab;
  List<LabsModel> Labs = [];
  bool isLoading = false;
  List<PaymentMethod> payments = [];
  List<apointmentdetail> appointments = [];
  InrouteModel Inroute = InrouteModel();
  List<PatientServicelist> lst1 = [];
  List<MiscellaneousServicesList> lst2 = [];
  double distance = 0.0;
  double time = 0.0;
  bool ispaymentselected = false;
  String status = "";
  String paymentstatus = "";
  List<String> paymentNameArray = ['Select Vehicle'];
  List<String> labsNameArray = ['selectlab'.tr];
  List<String> appointmentNameArray = ['appointment detail'];
  final RxString _selectedOption = 'no'.tr.obs;
  int _polylineCount = 1;
  final GoogleMapPolyline _googleMapPolyline =
      GoogleMapPolyline(apiKey: "AIzaSyB07oKE_GD9xHgPEHrielmn1__vD3OsaYs");
  LatLng _currentLatLng = const LatLng(0.0, 0.0);
  final Completer<GoogleMapController> _controller = Completer();
  final Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};

  // String EndDate = "";
  // ignore: non_constant_identifier_names
  // String StartDate = "";
  var StartDate = formatDateWithTime(DateTime.now());
  var EndDate = formatDateWithTime(DateTime.now(), isEndOfDay: true);
  int TotalRecordsData = 0;
  List<User> appointments1 = [];

  // ignore: non_constant_identifier_names
  void getappointments(
      String empId,
      // String StartDate,
      // // ignore: non_constant_identifier_names
      // String EndDate,

      int length,
      int start) async {
    if (start == 0) {
      // isLoadingData = true;
      // setState(() {});
    } else {
      // isLoadingmoreData = true;
      // setState(() {});
    }
    // var StartDate = formatDateWithTime(DateTime.now());
    // var EndDate = formatDateWithTime(DateTime.now(), isEndOfDay: true);

    var url = '$ip/api/account/GetAppointmentRequestList';
    var headers = {
      'Content-Type': 'application/json',
    };

    var requestBody = {
      'UserId': empId,
      'StartDate': widget.startdate,
      'EndDate': widget.enddate,
      'length': length,
      'start': start,
    };
    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(requestBody));
    // ignore: avoid_print
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      try {
        var data = jsonDecode(response.body);

        // Accessing each appointment in the data array
        List<dynamic> appointments = data["Data"];
        for (var appointment in appointments) {
          var labno = appointment["LabNo"];
          if (labno == widget.user.LabNo) {
            paymentstatus = appointment["PaymentStatusName"];
            setState(() {});
            // Do something with paymentstatus
          }
        }
      } catch (e) {
        // isLoadingData = false;
        // isLoadingmoreData = false;
        setState(() {});
        throw Exception('Failed to load appointments');
      }
    } else {
      // isLoadingData = false;
      // isLoadingmoreData = false;
      setState(() {});
      throw Exception('Failed to load appointments');
    }
  }

  _getPolylinesWithLocation(riderloc, LatLng generic) async {
    distance = Geolocator.distanceBetween(
      double.parse(_currentLatLng.latitude.toString()),
      double.parse(_currentLatLng.longitude.toString()),
      double.parse(ltlg[0].latitude.toString()),
      double.parse(ltlg[0].longitude.toString()),
    );
    double speed = 5.0 / 60.0;
    double timeInHours = distance / speed;
    time = timeInHours / 60;
    time = time / 60.0;
    if (time > 60.0) {
      temptime = time / 60;
    }
    distance = (distance / 1000) * 1.6;
    setState(() {});
    if (_selectedlab != null) {
      distance = Geolocator.distanceBetween(
        double.parse(_currentLatLng.latitude.toString()),
        double.parse(_currentLatLng.longitude.toString()),
        double.parse(generic.latitude.toString()),
        double.parse(generic.longitude.toString()),
      );
      double speed = 7.0 / 60.0;
      double timeInHours = distance / speed;
      time = timeInHours / 60;
      time = time / 60.0;
      if (time > 60.0) {
        temptime = time / 60;
      }
      distance = (distance / 1000) * 1.6;
      setState(() {});
      _markers.add(
        Marker(
          markerId: const MarkerId('Lab Location'),
          position: generic,
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
          infoWindow: const InfoWindow(title: 'Lab Location'),
        ),
      );
    }

    List<LatLng>? coordinates =
        await _googleMapPolyline.getCoordinatesWithLocation(
            origin: riderloc, destination: generic, mode: RouteMode.driving);
    List<List<PatternItem>> patterns = <List<PatternItem>>[
      <PatternItem>[], //line
      <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)], //dash
      <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)], //dot
      <PatternItem>[
        //dash-dot
        PatternItem.dash(30.0),
        PatternItem.gap(20.0),
        PatternItem.dot,
        PatternItem.gap(20.0)
      ],
    ];
    _addPolyline(List<LatLng>? coordinates) {
      PolylineId id = PolylineId("poly$_polylineCount");
      Polyline polyline = Polyline(
          polylineId: id,
          patterns: patterns[0],
          color: Colors.blueAccent,
          points: coordinates!,
          width: 10,
          onTap: () {});
      setState(() {
        _polylines[id] = polyline;
        _polylineCount++;
      });
    }

    setState(() {
      _polylines.clear();
    });
    _addPolyline(coordinates);
  }

  _getPolylinesWithLocationforlab(riderloc, LatLng generic) async {
    distance = Geolocator.distanceBetween(
      double.parse(_currentLatLng.latitude.toString()),
      double.parse(_currentLatLng.longitude.toString()),
      double.parse(widget.user.inroutelat.toString()),
      double.parse(widget.user.inroutelon.toString()),
    );
    double speed = 20.0 / 60.0;
    double timeInHours = distance / speed;
    time = timeInHours / (60.0);
    time = time / 60.0;
    if (time > 60.0) {
      temptime = time / 60;
    }
    distance = (distance / 1000) * 1.6;
    setState(() {});

    _markers.add(
      Marker(
        markerId: const MarkerId('Lab Location'),
        position: generic,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        infoWindow: const InfoWindow(title: 'Lab Location'),
      ),
    );

    List<LatLng>? coordinates =
        await _googleMapPolyline.getCoordinatesWithLocation(
            origin: riderloc, destination: generic, mode: RouteMode.driving);

    List<List<PatternItem>> patterns = <List<PatternItem>>[
      <PatternItem>[], //line
      <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)], //dash
      <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)], //dot
      <PatternItem>[
        //dash-dot
        PatternItem.dash(30.0),
        PatternItem.gap(20.0),
        PatternItem.dot,
        PatternItem.gap(20.0)
      ],
    ];
    _addPolyline(List<LatLng>? coordinates) {
      PolylineId id = PolylineId("$timeInHours");
      Polyline polyline = Polyline(
          polylineId: id,
          patterns: patterns[0],
          color: Colors.blueAccent,
          points: coordinates!,
          width: 10,
          onTap: () {
            Showtoaster().classtoaster(timeInHours.toString());
          });

      setState(() {
        _polylines[id] = polyline;
        _polylineCount++;
      });
    }

    setState(() {
      _polylines.clear();
    });
    _addPolyline(coordinates);
  }

  Location location = Location();
  final Set<Marker> _markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  String googleAPiKey = "AIzaSyB07oKE_GD9xHgPEHrielmn1__vD3OsaYs";
  final Set<Polyline> _polyline = HashSet<Polyline>();
  List<LatLng> ltlg = [];
  String dropdownvalue = 'percentage'.tr;
  String? dsct;
  TextEditingController discount = TextEditingController();

  // List of items in our dropdown menu
  var item1 = [
    'percentage'.tr,
    'amount'.tr,
  ];

  var isWidgetVisible = true.obs;

  void toggleWidgetVisibility() {
    isWidgetVisible.value = !isWidgetVisible.value;
  }

  functions() async {
    ltlg.add(LatLng(double.parse(widget.user.latitude.toString()),
        double.parse(widget.user.longitude.toString())));
// widget.user.latitude ==null && widget.user.longitude== null?"":
    print(widget.user.latitude);
    print(widget.user.longitude);
    _markers.add(
      Marker(
        markerId: const MarkerId('Patient Location'),
        position: ltlg[0],
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: const InfoWindow(title: 'Patient Location'),
      ),
    );

    _polyline.add(Polyline(
      polylineId: const PolylineId("2"),
      visible: true,
      //latlng is List<LatLng>
      points: ltlg,
      color: Colors.blue,
    ));
    setState(() {});

    //  await _getPolyline();
  }

  Future<void> paymentapi() async {
    final url = '$ip/api/Account/GetPaymentMethods';
    final headers = {'Content-Type': 'application/json'};

    var requestBody = {"userId": widget.empId, "IsMobile": true};
    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Iterable list = data["Data"];
        if (data['Status'] != null &&
            data['Status'] == 1 &&
            data['Data'] != null) {
          payments = list.map((e) => PaymentMethod.fromJson(e)).toList();

          List<String> selectedPayment = ['paymentmethod'.tr];

          setState(() {
            paymentNameArray = selectedPayment;
          });
        }
      } else {
        throw Exception('Failed to fetch data from the server.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> labsapi() async {
    final url = '$ip/api/Account/GetBranchLocations';
    final headers = {'Content-Type': 'application/json'};

    var requestBody = {"userId": widget.empId};
    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Iterable list = data["Data"];
        if (data['Status'] != null &&
            data['Status'] == 1 &&
            data['Data'] != null) {
          Labs = list.map((e) => LabsModel.fromJson(e)).toList();

          List<String> selectedlabs = ['Labs'];

          setState(() {
            labsNameArray = selectedlabs;
          });
        }
      } else {
        throw Exception('Failed to fetch data from the server.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> appointmentserviceapi() async {
    final url = '$ip/api/account/GetAppointmentServicesDetail';
    final headers = {'Content-Type': 'application/json'};
    var requestBody = {
      "BranchLocationId": widget.user.branchlocationid ?? "",
      "UserId": widget.empId,
      "PatientId": widget.user.patientid,
      "AppointmentNo": widget.user.LabNo
    };
    try {
      final response = await http.post(Uri.parse(url),
          headers: headers, body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        Iterable list = data["Data"];
        if (data['Status'] != null &&
            data['Status'] == 1 &&
            data['Data'] != null) {
          appointments = list.map((e) => apointmentdetail.fromJson(e)).toList();

          List<String> appointmentDetail = ['appointment detail'];

          print(appointments);
          setState(() {
            appointmentNameArray = appointmentDetail;
          });
        }
      } else {
        throw Exception('Failed to fetch data from the server.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  double calculateTotalPrice(List<apointmentdetail> appointmentDetails) {
    double totalPrice = 0.0;
    for (apointmentdetail detail in appointmentDetails) {
      totalPrice += detail.price;
    }
    return totalPrice;
  }

  callback() async {
    // await checkinapi();
    if (widget.user.status == "Booked") {
      // await checkinapi();
      await getsampleapi();
    }
  }

  getloc() async {
    await _getCurrentLocation();
  }

  @override
  void initState() {
    super.initState();
    status = widget.user.status;
    paymentstatus = widget.user.paymentstatusname;

    getloc();
    functions();
    callback();
    paymentapi();
    appointmentserviceapi();

//     if(widget.user.status=="Ride Started" && widget.user.status=="Ride Arrived"){
// _getPolylinesWithLocation(_currentLatLng,ltlg);
//     }
  }

  // _addPolyLine() {
  //   PolylineId id = PolylineId("poly");
  //   Polyline polyline = Polyline(
  //       polylineId: id, color: Colors.blue, points: polylineCoordinates);
  //   polylines[id] = polyline;
  //   setState(() {});
  // }

  // _getPolyline() async {
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //       googleAPiKey,
  //       PointLatLng(_currentLatLng.latitude, _currentLatLng.longitude),
  //       const PointLatLng(33.6844,73.0479),
  //       travelMode: TravelMode.driving,
  //       wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
  //   if (result!=null) {
  //     result.points.forEach((PointLatLng point) {
  //       polylineCoordinates.add(LatLng(point.latitude, point.longitude));
  //     });
  //   }
  //   await _addPolyLine();
  //   setState(() {

  //   });
  // }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      print("ERROR$error");
    });
    return await Geolocator.getCurrentPosition();
  }

  whatsapp() async {
    var contact = "+923115754479";
    var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
    var iosUrl =
        "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";
    try {
      if (Platform.isIOS) {
        await urllauncher.launchUrl(Uri.parse(iosUrl));
      } else {
        await urllauncher.launchUrl(Uri.parse(androidUrl));
      }
    } on Exception {
      const Text('WhatsApp is not installed.');
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    // ignore: unnecessary_null_comparison
    if (locationData != null) {
      _currentLatLng =
          LatLng(locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
      if (widget.user.status == "In Route") {
        _getPolylinesWithLocationforlab(
            _currentLatLng,
            LatLng(double.parse(widget.user.inroutelat.toString() ?? ""),
                double.parse(widget.user.inroutelon.toString() ?? "")));
      }
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(double.parse(locationData.latitude.toString()),
            double.parse(locationData.longitude.toString())),
        zoom: 14,
      );

      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {});

      _markers.add(
        Marker(
          markerId: const MarkerId('current_location'),
          position: _currentLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: const InfoWindow(title: 'Rider location'),
        ),
      );

      ltlg.add(_currentLatLng);
      if (widget.user.status!.toString().trim().toLowerCase() != "pending") {
        if (widget.user.status!.toString() == "In Route") {
          _getPolylinesWithLocationforlab(
              _currentLatLng,
              LatLng(double.parse(widget.user.inroutelat.toString()),
                  double.parse(widget.user.inroutelon.toString())));
        } else if (widget.user.status!.toString() == "Ride Started" ||
            widget.user.status!.toString() == "Booked") {
          _getPolylinesWithLocation(
              _currentLatLng, LatLng(ltlg[0].latitude, ltlg[0].longitude));
        }
      } else if (widget.user.status!.toString() == "Pending") {
        _getPolylinesWithLocation(
            _currentLatLng, LatLng(ltlg[0].latitude, ltlg[0].longitude));
      }
      setState(() {});
    }
    print("Location Data: $locationData");
    print("Current LatLng: $_currentLatLng");
    print("Markers: $_markers");
  }

  double timeInHours = 0.0;
  double temptime = 0.0;
  bool cancelchk = false;

  final TextEditingController _remarksController = TextEditingController();
  bool chk = false;
  bool isRideStarted = false;
  bool isRideCancel = false;
  bool isRideComplete = false;
  bool isRideEnd = false;
  bool ischeckin = false;
  bool isRideCanceled = false;
  bool issamplecollected = false;

  bool isRideInProgress() {
    return isRideStarted && !isRideCancel;
  }

  String? message;

  late Future<List<checkintry>> checkin;
  String? msg;
  checkinapi() async {
    var url = '$ip/api/Booking/CheckInPatientAppointment';
    var header = {
      'Content-Type': 'application/json',
    };

    PatientCheckIn patientcheckinobj =
        PatientCheckIn(patientId: widget.user.patientid);
    List<PatientCheckIn> lst = [];
    lst.add(patientcheckinobj);
    lst[0].checkInTypeId = "9cac3d33-e8aa-e711-80c1-a0b3cce147ba";
    // ignore: unused_local_variable
    PatientCheckIn patientserviceobj =
        PatientCheckIn(patientId: widget.user.patientid);

    for (apointmentdetail detail in appointments) {
      PatientServicelist tempobj = PatientServicelist();
      tempobj.subServiceId = detail.subServiceId;
      tempobj.charges = detail.price.toString();
      tempobj.isAutoNumberGenerationEnabled = false;
      tempobj.typeBit = widget.user.TypeBit.toString();
      tempobj.totalCharges = detail.price.toString();
      tempobj.subServiceCount = 1;
      tempobj.preference = 1;
      tempobj.specimenName = "Serum";
      tempobj.vatpercentage = detail.vatpercentage;
      tempobj.vatamount = detail.vatamount;

      if (appointments.contains(detail)) {
        lst1.add(tempobj);
      }
    }

    checkintry checkin = checkintry(
        patientCheckIn: lst,
        userId: widget.empId,
        branchLocationIds: widget.user.branchlocationid,
        paymentNo: widget.user.LabNo,
        patientServicelist: lst1);

    final response = await http.post(Uri.parse(url),
        headers: header, body: jsonEncode(checkin));
    print(checkin);
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Response data: $data");

      // Assuming you have a status field in the response indicating ride start success
      var status = data["Status"];
      dynamic detail = data["Detail"];
      var id = data["Detail"]["id"];
      dynamic beddetails = data["Detail"]["BedDetails"];
      dynamic message = data["Detail"]["errorMesage"];
      dynamic checkindept = data["Detail"]["CheckInDepartment"];
      if (status != null && status == 1 && detail != null) {
        if (id == -1) {
          ischeckin = false;
          Showtoaster().classtoaster("Please try again");
        } else if (id == -3) {
          ischeckin = false;
          Showtoaster().classtoaster(
              "Patient is under observation due to ${beddetails ?? ""} Please correct informaton and re-print MRCard");
        } else if (id == -2) {
          ischeckin = false;
          Showtoaster().classtoaster("Patient already Checkedin");
        } else if (id == -35) {
          ischeckin = false;
          Showtoaster().classtoaster("${message ?? ""}");
        } else if (id == -5) {
          ischeckin = false;
          Showtoaster().classtoaster("Bed Details");
        } else if (id == -7) {
          ischeckin = false;
          Showtoaster().classtoaster(
              "Patient is in dead state, you are not able to checkin again.!");
        } else if (id == -9) {
          ischeckin = false;
          Showtoaster().classtoaster("Please Try Again");
        } else if (id == -11) {
          ischeckin = false;
          Showtoaster().classtoaster("Invalid Voucher Coupons");
        } else if (id == -18) {
          ischeckin = false;
          Showtoaster().classtoaster(
              "Please enable Auto number generation for service count greater than zero!");
        } else if (id == -17) {
          ischeckin = false;
          Showtoaster().classtoaster("Appointment is not Booked for Today");
        } else if (id == -23) {
          ischeckin = false;
          Showtoaster().classtoaster(
              "Allowed rebooking restriction for ${checkindept ?? ""}");
        } else if (id == -19) {
          ischeckin = false;
          Showtoaster().classtoaster(
              "User Session is closed. please Open user session.");
        } else if (id == -20) {
          ischeckin = false;
          Showtoaster().classtoaster(
              'Patient panel organization package contract is expired or deactivated.');
        } else {
          checkinreponselist.add(checkinresponse.fromJson(detail));
          Fluttertoast.showToast(
              msg: msg ?? "Checkin Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          widget.user.status = "Booked";

          ischeckin = true;
          setState(() {});
          debugPrint(response.body);
        }
      } else {
        ischeckin = false;
        debugPrint("Data is null");
      }
    } else {
      throw Exception('Failed to checkin');
    }
  }

  List<checkinresponse> checkinreponselist = [];
  // ignore: unused_field

  // late Future<List<checkintry>> checkin;

  checkinapidoctor() async {
    var url = '$ip/api/Booking/CheckInPatientAppointment';
    var header = {
      'Content-Type': 'application/json',
    };
    apointmentdetail? detail;
    PatientCheckIn patientcheckinobj =
        PatientCheckIn(patientId: widget.user.patientid);
    List<PatientCheckIn> lst = [];
    lst.add(patientcheckinobj);
    lst[0].checkInTypeId = "0F02A4F2-4787-47DF-BADD-32807F6C13ED";
    lst[0].chargerate = "";
    lst[0].paidamount = "";
    lst[0].smssendto = 0;
    lst[0].isonline = 0;
    lst[0].patientserviceappointmentid = "";

    // ignore: unused_local_variable
    PatientCheckIn patientserviceobj =
        PatientCheckIn(patientId: widget.user.patientid);

    for (apointmentdetail detail in appointments) {
      MiscellaneousServicesList obj = MiscellaneousServicesList();
      obj.subServiceId = detail.subServiceId;
      obj.charges = detail.price.toString();
      obj.isAutoNumberGenerationEnabled = false;
      obj.typeBit = "0";
      obj.totalCharges = detail.price.toString();
      obj.subServiceCount = 1;
      obj.preference = 1;
      obj.specimenName = "Serum";
      obj.vatpercentage = detail.vatpercentage;
      obj.vatamount = detail.vatamount;

      if (appointments.contains(detail)) {
        lst2.add(obj);
      }
    }

    checkintry checkin = checkintry(
      patientCheckIn: lst,
      isbooking: "1",
      paymentNo: widget.user.LabNo,
      doctorCheckInType: "3",
      typebit: widget.user.TypeBit.toString(),
      paymentmethodid: payments.toString(),
      miscellaneousserviceslist: lst2,
      userId: widget.empId,
      branchLocationIds: widget.user.branchlocationid,
    );

    final response = await http.post(Uri.parse(url),
        headers: header, body: jsonEncode(checkin));
    print(checkin);
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Response data: $data");

      // Assuming you have a status field in the response indicating ride start success
      var status = data["Status"];
      dynamic detail = data["Detail"];
      var id = data["Detail"]["id"];
      dynamic beddetails = data["Detail"]["BedDetails"];
      dynamic message = data["Detail"]["errorMesage"];
      dynamic checkindept = data["Detail"]["CheckInDepartment"];
      if (status != null && status == 1 && detail != null) {
        if (id == -1) {
          ischeckin = false;
          Showtoaster().classtoaster("Please try again");
        } else if (id == -3) {
          ischeckin = false;
          Showtoaster().classtoaster(
              "Patient is under observation due to ${beddetails ?? ""} Please correct informaton and re-print MRCard");
        } else if (id == -2) {
          ischeckin = false;
          Showtoaster().classtoaster("Patient already Checkedin");
        } else if (id == -35) {
          ischeckin = false;
          Showtoaster().classtoaster("${message ?? ""}");
        } else if (id == -5) {
          ischeckin = false;
          Showtoaster().classtoaster("Bed Details");
        } else if (id == -7) {
          ischeckin = false;
          Showtoaster().classtoaster(
              "Patient is in dead state, you are not able to checkin again.!");
        } else if (id == -9) {
          ischeckin = false;
          Showtoaster().classtoaster("Please Try Again");
        } else if (id == -11) {
          ischeckin = false;
          Showtoaster().classtoaster("Invalid Voucher Coupons");
        } else if (id == -18) {
          ischeckin = false;
          Showtoaster().classtoaster(
              "Please enable Auto number generation for service count greater than zero!");
        } else if (id == -17) {
          ischeckin = false;
          Showtoaster().classtoaster("Appointment is not Booked for Today");
        } else if (id == -23) {
          ischeckin = false;
          Showtoaster().classtoaster(
              "Allowed rebooking restriction for ${checkindept ?? ""}");
        } else if (id == -19) {
          ischeckin = false;
          Showtoaster().classtoaster(
              "User Session is closed. please Open user session.");
        } else if (id == -20) {
          ischeckin = false;
          Showtoaster().classtoaster(
              'Patient panel organization package contract is expired or deactivated.');
        } else {
          checkinreponselist.add(checkinresponse.fromJson(detail));
          Fluttertoast.showToast(
              msg: msg ?? "Checkin Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          widget.user.status = "Booked";

          ischeckin = true;
          setState(() {});
          debugPrint(response.body);
        }
      } else {
        ischeckin = false;
        debugPrint("Data is null");
      }
    } else {
      throw Exception('Failed to checkin');
    }
  }

  // List<checkinresponse> checkinreponselist = [];

  late Future<List<User>> _startride;

  Future<void> startRide() async {
    var url = '$ip/api/account/StartRide';
    var headers = {
      'Content-Type': 'application/json',
    };

    var requestBody = {
      "PatientId": widget.user.patientid,
      "BranchLocationId": widget.user.branchlocationid,
      "LabNo": widget.user.LabNo,
      "RiderLatitude": _currentLatLng.latitude,
      "RiderLongitude": _currentLatLng.longitude,
      "RiderAddress": "",
      "RiderRemarks": "ok",
      "UserId": widget.empId,
      "RiderLocationURL":
          "https://maps.google.com/?q=${_currentLatLng.latitude},${_currentLatLng.longitude}"
    };
    _getPolylinesWithLocation(
        _currentLatLng, LatLng(ltlg[0].latitude, ltlg[0].longitude));

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(requestBody));
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Response data: $data");

      // Assuming you have a status field in the response indicating ride start success
      var status = data["Status"];
      String message = data["ErrorMessage"];
      if (status != null && status == 1) {
        widget.user.status = "Ride Started";
        isRideStarted = true;
        Fluttertoast.showToast(
            msg: msg ?? message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        widget.user.status = "Pending";

        isRideStarted = false;
        Showtoaster().classtoaster(message);
      }
    } else {
      throw Exception('Failed to start ride');
    }
  }

  Future<void> CancelRide(User user, String remarks) async {
    var url = '$ip/api/account/CancelRide';
    var headers = {
      'Content-Type': 'application/json',
    };

    var requestBody = {
      "PatientId": user.patientid,
      "BranchLocationId": user.branchlocationid,
      "AppointmentNo": user.LabNo,
      "RideCancelRemarks": remarks,
      "UserId": widget.empId,
      "RiderLocationURL":
          "https://maps.google.com/?q=${_currentLatLng.latitude},${_currentLatLng.longitude}"
    };

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(requestBody));
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      setState(() {});
      var data = jsonDecode(response.body);
      print("Response data: $data");

      var status = data["Status"];
      if (status != null && status == 1) {
        widget.user.status = "Pending";
        isRideCanceled = true;
        isRideCancel = true;
      } else {
        isRideCancel = false;
        debugPrint("Data is null");
      }
    } else {
      throw Exception('Failed to Cancel ride');
    }
  }

  Future<void> EndRide(User user) async {
    var url = '$ip/api/account/EndRide';
    var headers = {
      'Content-Type': 'application/json',
    };

    var requestBody = {
      'LabNo': widget.user.LabNo,
      'PatientAppointmentId': user.Patientappoinmentid,
      "PatientId": user.patientid,
      "BranchLocationId": user.branchlocationid,
      "UserId": user.empId,
      "RiderLocationURL":
          "https://maps.google.com/?q=${_currentLatLng.latitude},${_currentLatLng.longitude}"
    };

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(requestBody));
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      setState(() {});
      var data = jsonDecode(response.body);
      print("Response data: $data");

      var status = data["Status"];
      String message = data["Message"];
      if (status != null && status == 1) {
        widget.user.status = "Ride Arrived";
        isRideEnd = true;
        Fluttertoast.showToast(
            msg: msg ?? message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        widget.user.status = "Ride Started";
        isRideEnd = false;
        Showtoaster().classtoaster(message);
        // debugPrint("Data is empty");
      }
    } else {
      throw Exception('Failed to end ride');
    }
  }

  Future<void> CompleteRide(User user) async {
    var url = '$ip/api/account/CompleteRide';
    var headers = {
      'Content-Type': 'application/json',
    };
    var requestBody = {
      "PatientId": widget.user.patientid,
      "BranchLocationId": widget.user.branchlocationid,
      "LabNo": widget.user.LabNo,
      "RiderLatitude": _currentLatLng.latitude,
      "RiderLongitude": _currentLatLng.longitude,
      "RiderAddress": "",
      "RiderRemarks": "ok",
      "UserId": widget.empId,
      "RiderLocationURL":
          "https://maps.google.com/?q=${_currentLatLng.latitude},${_currentLatLng.longitude}"
    };

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(requestBody));
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Response data: $data");

      var status = data["Status"];
      if (status != null && status == 1) {
        isRideComplete = true;
      } else {
        isRideComplete = false;
        debugPrint("Data is null");
      }
    } else {
      throw Exception('Failed to end ride');
    }
  }

  Future<void> InRouteapi() async {
    var url = '$ip/api/account/InRouteSampleDelivery';
    var headers = {
      'Content-Type': 'application/json',
    };
    InrouteModel bdody = InrouteModel(
        patientId: widget.user.patientid,
        userId: widget.empId,
        branchLocationId: widget.user.branchlocationid,
        labNo: widget.user.LabNo,
        inRouteDeliveryBranchLocationId: SelectLab);
    dynamic route = bdody.toJson();

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(route));
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Response data: $data");

      // Assuming you have a status field in the response indicating ride start success
      var status = data["Status"];

      setState(() {});
      if (status != null && status == 1) {
      } else {
        debugPrint("Data is null");
      }
    } else {
      throw Exception('Failed');
    }
  }

  // ignore: body_might_complete_normally_nullable
  Future<String?> sampledeliveredapi() async {
    var url = '$ip/api/account/SampleDelivery';
    var headers = {
      'Content-Type': 'application/json',
    };
    sampledeliveredModel bdody = sampledeliveredModel(
        patientId: widget.user.patientid,
        userId: widget.empId,
        branchLocationId: widget.user.branchlocationid,
        labNo: widget.user.LabNo,
        deliveryBranchLocationId: SelectLab,
        riderLatitude: _currentLatLng.latitude,
        riderLongitude: _currentLatLng.longitude);
    dynamic route = bdody.toJson();

    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(route));
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Response data: $data");

      // Assuming you have a status field in the response indicating ride start success
      var status = data["Status"];
      message = data["Message"];

      setState(() {});

      if (status != null && status == 1) {
        return message;
      } else {
        debugPrint("Data is null");
      }
    } else {
      throw Exception('Failed');
    }
  }

  int fileCount = 1;

  Future<void> getsampleapi() async {
    var url = '$ip/api/Account/GetSampleCollectionServicesList';
    var headers = {
      'Content-Type': 'application/json',
    };

    samplebody bdody = samplebody();
    bdody = samplebody(
      patientId: widget.user.patientid,
      userId: widget.empId,
      branchLocationId: widget.user.branchlocationid,
      labNo: checkinreponselist.isNotEmpty
          ? checkinreponselist[0].labNo.toString().split(';')[0]
          : widget.user.labTestChallanNo,
      visitNo: checkinreponselist.isNotEmpty
          ? checkinreponselist[0].visitNo
          : widget.user.visitno,
      appointmentNo: widget.user.LabNo,
      price: lst1.isNotEmpty ? lst1.last.totalCharges : "",
    );

    dynamic bd = bdody.toJson();
    log(bd.toString());
    final response =
        await http.post(Uri.parse(url), headers: headers, body: jsonEncode(bd));
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print("Response data: $data");

      // Assuming you have a status field in the response indicating ride start success
      var status = data["Status"];
      Iterable bdy = data["Data"];
      samplecollectionresponselst =
          bdy.map((e) => samplecollectionresponse.fromJson(e)).toList();
      setState(() {});
      if (status != null && status == 1) {
        isRideStarted = true;
      } else {
        isRideStarted = false;
        debugPrint("Data is null");
      }
    } else {
      throw Exception('Failed');
    }
  }

  List<samplecollectionresponse> samplecollectionresponselst = [];
  List<ListLabServiceDataDetail> listlabsamplelst = [];

  Future<void> samplecollectionapi() async {
    var url = '$ip/api/account/SampleCollectionSubmitProcess';
    var headers = {
      'Content-Type': 'application/json',
    };
    for (var val in samplecollectionresponselst) {
      listlabsamplelst.add(ListLabServiceDataDetail(
          srNo: 1,
          patientLabCheckInId: val.patientLabCheckInId ?? "",
          patientId: widget.user.patientid,
          departmentId: val.departmentId ?? "",
          subDepartmentId: val.subDepartmentId ?? "",
          userId: widget.empId,
          designationId: val.designationId ?? "",
          roleId: val.roleId ?? "",
          isInPatient: true,
          patientVisitNo: samplecollectionresponselst.isNotEmpty
              ? samplecollectionresponselst.last.visitNo
              : checkinreponselist.last.visitNo ?? "",
          subserviceName: val.subServiceName ?? "",
          prescribedbyName: val.prescribedBy ?? "",
          charges: samplecollectionresponselst.isNotEmpty
              ? samplecollectionresponselst.last.price
              : lst1.last.charges ?? "",
          prescribedQuantity: 6,
          totalCharges: samplecollectionresponselst.isNotEmpty
              ? samplecollectionresponselst.last.totalAmount
              : lst1.last.totalCharges ?? "",
          visitTime: val.visitTime ?? "",
          total: val.totalAmount ?? "",
          patientStatusId: val.patientStatusId ?? "",
          subServiceId: val.subServiceId ?? "",
          patientStatusValue: val.patientStatusValue ?? "",
          serviceTotal: 1.1,
          isOutsideSample: true,
          outSourcedBranchId: val.branchId ?? "",
          outSideSampleComments: val.outSourcedBranchName ?? "",
          consumtionItems: null,
          html: val.html ?? "",
          prescribedBy: val.prescribedBy ?? "",
          patientEntitled: 14,
          autoNumberGenerated: val.autoNumberGenerated ?? "",
          autoNumberGenerationLabelText:
              val.autoNumberGenerationLabelText ?? ""));
    }

    samplecollectedModel bdody = samplecollectedModel(
        isInvestigationQueue: true,
        patientId: widget.user.patientid,
        visitNo: samplecollectionresponselst.isNotEmpty
            ? samplecollectionresponselst.last.visitNo
            : checkinreponselist.last.visitNo ?? "",
        statusBit: 4,
        departmentId: samplecollectionresponselst.last.departmentId ?? "",
        subDepartmentId: samplecollectionresponselst.last.subDepartmentId ?? "",
        doctorId: "",
        subServiceId: samplecollectionresponselst.isNotEmpty
            ? samplecollectionresponselst.last.subServiceId
            : lst1.last.subServiceId ?? "",
        roleId: samplecollectionresponselst.last.roleId ?? "",
        designationId: samplecollectionresponselst.last.designationId ?? "",
        userId: widget.empId,
        patientCheckInId:
            samplecollectionresponselst.last.patientLabCheckInId ?? "",
        listLabServiceDataDetail: listlabsamplelst,
        paidAmount: 1,
        subDepartmentManualCodeString:
            samplecollectionresponselst.last.subDepartmentManualCodeString ??
                "",
        sampleCollectionStickerCount: 1,
        autoNumberGenerated:
            samplecollectionresponselst.last.autoNumberGenerated ?? "",
        autoNumberGenerationLabelText:
            samplecollectionresponselst.last.autoNumberGenerationLabelText ??
                "",
        sessionUserId: widget.empId);
    dynamic sample = bdody.toJson();
    print(sample);
    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(sample));
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      print("Response data: $data");

      // Assuming you have a status field in the response indicating ride start success
      collectionstatus = data["Status"];

      if (collectionstatus != 0 && collectionstatus == 1) {
        isRideStarted = true;
      } else {
        isRideStarted = false;
        debugPrint("Data is null");
      }
      setState(() {});
    } else {
      throw Exception('Failed');
    }
  }

  int collectionstatus = 0;
  final items = [
    const Icon(Icons.notifications, size: 30),
    const Icon(
      Icons.home,
      size: 30,
      color: Colors.white,
    ),
    const Icon(Icons.person, size: 30),
  ];

  int index = 1;

  static const CameraPosition _kGoogle = CameraPosition(
    target: LatLng(33.586203, 73.085603),
    zoom: 14.4746,
  );
  bool isAddedLoading = false;
  Future<void> AddConsentForm(list) async {
    var url = '$ip/api/account/AddConsentForms';
    var headers = {
      'Content-Type': 'application/json',
    };

    // var requestBody = body;
    final requestBody = {
      "PatientConsentToSaveData": list,
    };
    final response = await http.post(Uri.parse(url),
        headers: headers, body: jsonEncode(requestBody));
    print("Response: ${response.body}");

    if (response.statusCode == 200) {
      setState(() {});
      var data = jsonDecode(response.body);
      print("Response data: $data");

      var status = data["Status"];
      String message = data["ErrorMessage"];
      if (status != null && status == 2) {
        widget.user.status = "Consent Received";
        setState(() {});
        // isRideEnd = true;
        Fluttertoast.showToast(
            msg: msg ?? message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        Get.back();
      } else {
        widget.user.status = "Ride Arrived";
        // isRideEnd = false;
        Showtoaster().classtoaster(message);
        // debugPrint("Data is empty");
      }
    } else {
      throw Exception('Failed to end ride');
    }
  }

  Future<String> uploadPicture(File file) async {
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

  Future<void> consentDialog(BuildContext context) async {
    List<ConsentModel> files = [];
    files.add(ConsentModel(
        attachmentPath: null,
        remarks: '',
        consentFormStatus: "1",
        userId: widget.empId,
        patientId: widget.user.patientid,
        paymentNumber: widget.user.LabNo));
    await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              height: Get.height * 0.7,
              width: Get.width * 0.8,
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.5,
                        width: Get.width * 0.8,
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: files.length,
                          itemBuilder: (context, index) {
                            return FilePickerCard(
                              fileModel: files[index],
                              onFileSelected: (filePath) {
                                setState(() {
                                  files[index].attachmentPath = filePath;
                                });
                              },
                              onTextChanged: (text) {
                                setState(() {
                                  files[index].remarks = text;
                                });
                              },
                              onAcceptRejectChanged: (value) {
                                setState(() {
                                  files[index].consentFormStatus = value;
                                });
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              files.add(ConsentModel(
                                  attachmentPath: null,
                                  remarks: '',
                                  consentFormStatus: "1",
                                  userId: widget.empId,
                                  patientId: widget.user.patientid,
                                  paymentNumber: widget.user.LabNo));
                            });
                          },
                          child: Text(
                            "Add more +",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.05),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  setState(() {
                                    isAddedLoading = true;
                                  });
                                  List<ConsentModel> data = [];
                                  // Iterate through files list and create a map for each entry
                                  for (var file in files) {
                                    {
                                      ConsentModel entry = ConsentModel(
                                          attachmentPath: file.attachmentPath ??
                                              'No file selected',
                                          remarks: file.remarks,
                                          consentFormStatus:
                                              file.consentFormStatus ??
                                                  'Not specified',
                                          userId: file.userId,
                                          paymentNumber: file.paymentNumber,
                                          patientId: file.patientId);
                                      data.add(entry);
                                    }
                                  }

                                  if (data[0].attachmentPath !=
                                          "No file selected" ||
                                      data[0].remarks != "") {
                                    for (int i = 0; i < data.length; i++) {
                                      if (files[i].attachmentPath != null) {
                                        File file = File(files[i]
                                            .attachmentPath!); // Convert String filePath to File object
                                        String imagePath =
                                            await uploadPicture(file);
                                        print(
                                            'Uploaded image path: $imagePath');
                                        // Update the attachmentPath in the files list with the API response imagePath
                                        files[i].attachmentPath = imagePath;
                                        // Handle imagePath as needed
                                      } else {
                                        print('File path is null');
                                      }
                                    }
                                    await AddConsentForm(files);
                                    setState(() {
                                      isAddedLoading = false;
                                    });
                                    // now call 2 api
                                  } else {
                                    Showtoaster()
                                        .classtoaster("Please Fill all Fields");
                                  }
                                } catch (e) {
                                  setState(() {
                                    isAddedLoading = false;
                                  });
                                  Showtoaster()
                                      .classtoaster("Something Went wrong");
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.kDarkBlue,
                                fixedSize: const Size(380, 4),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Text(
                                'Submit',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: ColorManager.kWhiteColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showStartRideDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              // Set your desired size here
              size: const Size(700, 600),
            ),
            child: CupertinoAlertDialog(
              title: Column(
                children: [
                  Text(
                    'ridestatus'.tr,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: Text('wanttostart'.tr),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          widget.user.status = 'Ride Started';

                          setState(() {});
                          isRideCancel = false;
                          isRideEnd = false;

                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await startRide();
                            setState(() {
                              isLoading = false;
                            });
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                          }

                          chk = true;
                          if (isRideStarted) {
                            setState(() {
                              message = 'ridestarted'.tr;
                            });
                          }
                          setState(() {});

                          Navigator.of(context).pop();
                          // Navigator.push(
                          //   context, MaterialPageRoute(builder: (context)=> ViewInformation(user:widget.user)));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.kDarkBlue,
                          fixedSize: const Size(100, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            // Set the border radius here
                          ),
                        ),
                        child: Text('yes'.tr),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // User tapped on No

                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          fixedSize: const Size(100, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            // Set the border radius here
                          ),
                        ),
                        child: Text('no'.tr),
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }

  _showarrivedDialog(String text, bool arrive, bool sample) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              // Set your desired size here
              size: const Size(700, 600),
            ),
            child: CupertinoAlertDialog(
              title: Column(
                children: [
                  Text(
                    'ridestatus'.tr,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: Text(text.tr),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (arrive) {
                            widget.user.empId = userprofile!.id;
                            widget.user.status = 'Ride Arrived';

                            await EndRide(widget.user);
                            setState(() {
                              isLoading = true;
                            });
                            try {
                              await appointmentserviceapi();
                              setState(() {
                                isLoading = false;
                              });
                            } catch (e) {
                              setState(() {
                                isLoading = false;
                              });
                            }

                            setState(() {
                              isLoading = false;
                            });

                            // isRideEnd=true;

                            //  chk=true;
                            if (isRideStarted) {
                              setState(() {
                                message = '';
                              });
                            }
                          } else if (sample) {
                            try {
                              setState(() {
                                isLoading = true;
                              });

                              await samplecollectionapi();
                              setState(() {
                                isLoading = false;
                              });
                            } catch (e) {
                              setState(() {
                                isLoading = false;
                              });
                            }
                            if (collectionstatus == 1 || ischeckin == true) {
                              setState(() {
                                message = '';
                                widget.user.status = "Sample Collected";
                              });
                            }
                          }
                          Navigator.of(context).pop();
                          // Navigator.push(
                          //   context, MaterialPageRoute(builder: (context)=> ViewInformation(user:widget.user)));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.kDarkBlue,
                          fixedSize: const Size(100, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            // Set the border radius here
                          ),
                        ),
                        child: Text('yes'.tr),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await EndRide(widget.user);
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          fixedSize: const Size(100, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            // Set the border radius here
                          ),
                        ),
                        child: Text('no'.tr),
                      ),
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }

  Color activeIconColor = Colors.white;
  Color inactiveIconColor = Colors.grey;
  void _launchGoogleMaps(
      double destinationLatitude, double destinationLongitude) async {
    final String googleMapsUrl =
        "https://www.google.com/maps/dir/?api=1&destination=$destinationLatitude,$destinationLongitude";

    if (await canLaunch(googleMapsUrl)) {
      await launch(googleMapsUrl);
    } else {
      throw 'Could not launch Google Maps';
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalAppointmentPrice = calculateTotalPrice(appointments);
    return BlurryModalProgressHUD(
        inAsyncCall: isLoading,
        blurEffectIntensity: 4,
        progressIndicator: const SpinKitSpinningLines(
          color: Color(0xfff1272d3),
          size: 60,
        ),
        dismissible: false,
        opacity: 0.4,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Scaffold(
            bottomNavigationBar: const Mycustomnavbar(),
            backgroundColor: Colors.blue,
            body: SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 1,
                child: Column(children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Stack(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 01,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Scaffold(
                            floatingActionButtonLocation:
                                FloatingActionButtonLocation.centerFloat,
                            floatingActionButton: distance != 0.0
                                ? Container(
                                    child: time > 60.0
                                        ? Text(
                                            "${distance.toStringAsFixed(1)} km , ${temptime.toStringAsFixed(1)} hrs",
                                            style: GoogleFonts.poppins(
                                                color: Colors.orange,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : Text(
                                            "${distance.toStringAsFixed(1)} km , ${time.toStringAsFixed(1)} mins",
                                            style: GoogleFonts.poppins(
                                                color: Colors.orange,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                  )
                                : const SizedBox(),
                            body: GoogleMap(
                              initialCameraPosition: _kGoogle,
                              mapType: MapType.normal,
                              myLocationEnabled: true,
                              myLocationButtonEnabled: false,
                              compassEnabled: true,
                              onMapCreated: (GoogleMapController controller) {
                                _controller.complete(controller);

                                getUserCurrentLocation().then((value) async {
                                  print("${value.latitude} ${value.longitude}");

                                  // marker added for current users location
                                  _markers.add(Marker(
                                    markerId: const MarkerId("2"),
                                    position:
                                        LatLng(value.latitude, value.longitude),
                                    infoWindow: const InfoWindow(
                                      title: 'My Current Location',
                                    ),
                                  ));

                                  // specified current users location
                                  CameraPosition cameraPosition =
                                      CameraPosition(
                                    target:
                                        LatLng(value.latitude, value.longitude),
                                    zoom: 14,
                                  );

                                  final GoogleMapController controller =
                                      await _controller.future;
                                  controller.animateCamera(
                                      CameraUpdate.newCameraPosition(
                                          cameraPosition));
                                  setState(() {});
                                });
                              },
                              markers: _markers,
                              polylines: Set<Polyline>.of(_polylines.values),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.04,
                              left: MediaQuery.of(context).size.width * 0.04,
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              color: Color(0xff0F64C6),
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.03,
                          left: MediaQuery.of(context).size.width * 0.34,
                          child: Center(
                            child: Image.asset(
                              Images.logo,
                              height:
                                  MediaQuery.of(context).size.height * 0.075,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: SizedBox(
                    width: MediaQuery.of(context).size.width * 1,
                    height: MediaQuery.of(context).size.height,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width * 0.78,
                      child: Card(
                        color: ColorManager.kDarkBlue,
                        elevation: 0,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: Get.width * 0.01),
                                      child: Text(
                                        '${DateFormat('d MMMM y').format(DateTime.parse(widget.user.StartDate!))} | ${widget.user.time ?? ""}',
                                        style: const TextStyle(
                                            fontSize: 10,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.person,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(width: 10),
                                        SizedBox(
                                          width: Get.width * 0.55,
                                          child: Text(
                                            widget.user.patientName
                                                    ?.toString()
                                                    .trim() ??
                                                "",
                                            style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.edit_document,
                                          color: Colors.white,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Flexible(
                                          child: Text.rich(
                                            TextSpan(
                                              text: "Test  | ",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text: widget.user.test
                                                          ?.toString()
                                                          .trim() ??
                                                      "",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // overflow:
                                            //     TextOverflow.ellipsis,
                                            // maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Icon(Icons.pin_drop,
                                            color: Colors.white),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Text.rich(
                                            TextSpan(
                                              text: "Address  | ",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                              children: [
                                                TextSpan(
                                                    text: widget.user.address ??
                                                        "",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                trailing: Column(
                                  children: [
                                    Text(
                                      widget.user.status ?? "",
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.white),
                                    ),
                                    if (widget.user.status == "Ride Arrived" ||
                                        widget.user.status ==
                                            "Consent Received" ||
                                        widget.user.status == "Booked" ||
                                        widget.user.status ==
                                            "Sample Collected" ||
                                        widget.user.status ==
                                            "Sample Delivered" ||
                                        widget.user.status == "In Route")
                                      SizedBox(
                                        height: Get.height * 0.04,
                                        child: IconButton(
                                          icon: const Icon(Icons.edit,
                                              color: Colors.white),
                                          onPressed: () async {
                                            await AuthRepo()
                                                .getPatientBasicInfo(
                                                    widget.user.patientid);
                                            Get.to(() => EditPatientNew(
                                                pid: widget.user.patientid));
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                              if (widget.user.status == "Ride Arrived" ||
                                  widget.user.status == "Consent Received" ||
                                  widget.user.status == "Booked" ||
                                  widget.user.status == "Sample Collected" ||
                                  widget.user.status == "Sample Delivered" ||
                                  widget.user.status == "In Route")
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: Get.width * 0.08),
                                      child: InkWell(
                                        onTap: () {
                                          LabInvestigationController.i
                                              .clearpage();
                                          Get.to(LabInvestigations(
                                            patientid: widget.user.patientid,
                                          ));
                                        },
                                        child: Image.asset(
                                          Images.add,
                                          scale: 6,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              SizedBox(
                                height: Get.height * 0.02,
                              ),

                              if (widget.user.status == "Pending")
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.05),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        chk = true;
                                        isRideCancel = false;
                                        isRideEnd = false;
                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewInformation(user:widget.user)));
                                        _showStartRideDialog();
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
                                        'startride'.tr,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ),
                              // SizedBox(
                              //   height:
                              //       MediaQuery.of(context).size.height *
                              //           0.02,
                              // ),

                              if (widget.user.status == "Ride Started")
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.05),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // if(chk)
                                      SizedBox(
                                        width: Get.width * 0.43,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              showDialog<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    content: SizedBox(
                                                      height: Get.height * 0.23,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(""),
                                                              Text('cancelride'
                                                                  .tr),
                                                              InkWell(
                                                                  onTap: () {
                                                                    Get.back();
                                                                  },
                                                                  child: const Icon(
                                                                      CupertinoIcons
                                                                          .clear)),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  Get.height *
                                                                      0.02),
                                                          TextFormField(
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'remarks'.tr,
                                                              enabledBorder: const OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.black)),
                                                              disabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              border: const OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.black)),
                                                            ),
                                                            controller:
                                                                _remarksController,
                                                            // placeholder:
                                                            //     'enterremarks'
                                                            //         .tr,
                                                          ),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.03,
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                Get.width * 0.7,
                                                            child:
                                                                CupertinoButton(
                                                              color:
                                                                  Colors.blue,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          15.0)),
                                                              child: Text(
                                                                'ok'.tr,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                widget.user
                                                                        .status =
                                                                    "Ride Started";
                                                                if (_remarksController
                                                                    .text
                                                                    .isNotEmpty) {
                                                                  chk = false;
                                                                  String
                                                                      remarks =
                                                                      _remarksController
                                                                          .text;
                                                                  isRideCancel =
                                                                      true;
                                                                  if (isRideCancel) {
                                                                    setState(
                                                                        () {
                                                                      message =
                                                                          'Ride Cancel successfully!';
                                                                    });
                                                                  }
                                                                  await CancelRide(
                                                                      widget
                                                                          .user,
                                                                      remarks);
                                                                  isRideCancel =
                                                                      true;
                                                                  setState(
                                                                      () {});
                                                                  _remarksController
                                                                      .clear();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                } else {
                                                                  Showtoaster()
                                                                      .classtoaster(
                                                                          "pleaseenterremarks"
                                                                              .tr);
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              fixedSize: const Size(120, 4),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    15), // Set the border radius here
                                              ),
                                            ),
                                            child: Text(
                                              "cancel".tr,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                      ),
                                      const SizedBox(
                                        width: 0.01,
                                      ),
                                      if (!isRideEnd && !isRideCancel)
                                        SizedBox(
                                          width: Get.width * 0.43,
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                await _showarrivedDialog(
                                                    'arrivedatlocation',
                                                    true,
                                                    false);

                                                if (isRideEnd) {
                                                  setState(() {
                                                    message = '';
                                                  });
                                                }
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                fixedSize: const Size(120, 4),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                              child: Text(
                                                "arrived".tr,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              )),
                                        ),
                                    ],
                                  ),
                                ),
                              if (widget.user.status == "Ride Started")
                                SizedBox(
                                  height: Get.height * 0.05,
                                ),
                              if (widget.user.status == "Ride Arrived")
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.05),
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> ViewInformation(user:widget.user)));
                                        consentDialog(context);
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
                                        'Add Consent'.tr,
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ),

                              //Here

                              if (widget.user.status == "Consent Received")
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.05),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // if(chk)
                                      SizedBox(
                                        width: Get.width * 0.43,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              showDialog<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                    ),
                                                    content: SizedBox(
                                                      height: Get.height * 0.23,
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              const Text(""),
                                                              Text('cancelride'
                                                                  .tr),
                                                              InkWell(
                                                                  onTap: () {
                                                                    Get.back();
                                                                  },
                                                                  child: const Icon(
                                                                      CupertinoIcons
                                                                          .clear)),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                              height:
                                                                  Get.height *
                                                                      0.02),
                                                          TextFormField(
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'remarks'.tr,
                                                              enabledBorder: const OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.black)),
                                                              disabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              border: const OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                          width:
                                                                              1,
                                                                          color:
                                                                              Colors.black)),
                                                            ),
                                                            controller:
                                                                _remarksController,
                                                            // placeholder:
                                                            //     'enterremarks'
                                                            //         .tr,
                                                          ),
                                                          SizedBox(
                                                            height: Get.height *
                                                                0.03,
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                Get.width * 0.7,
                                                            child:
                                                                CupertinoButton(
                                                              color:
                                                                  Colors.blue,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          15.0)),
                                                              child: Text(
                                                                'ok'.tr,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                widget.user
                                                                        .status =
                                                                    "Ride Started";
                                                                if (_remarksController
                                                                    .text
                                                                    .isNotEmpty) {
                                                                  chk = false;
                                                                  String
                                                                      remarks =
                                                                      _remarksController
                                                                          .text;
                                                                  isRideCancel =
                                                                      true;
                                                                  if (isRideCancel) {
                                                                    setState(
                                                                        () {
                                                                      message =
                                                                          'Ride Cancel successfully!';
                                                                    });
                                                                  }
                                                                  await CancelRide(
                                                                      widget
                                                                          .user,
                                                                      remarks);
                                                                  isRideCancel =
                                                                      true;
                                                                  setState(
                                                                      () {});
                                                                  _remarksController
                                                                      .clear();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                } else {
                                                                  Showtoaster()
                                                                      .classtoaster(
                                                                          "pleaseenterremarks"
                                                                              .tr);
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    15), // Set the border radius here
                                              ),
                                            ),
                                            child: Text(
                                              "cancel".tr,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            )),
                                      ),

                                      const SizedBox(
                                        width: 0.01,
                                      ),
                                      // if(isRideEnd && !isRideCancel)
                                      if (widget.user.status ==
                                          "Consent Received")
                                        SizedBox(
                                          width: Get.width * 0.43,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              // Check if payment method is selected
                                              if (ispaymentselected == true ||
                                                  widget.user
                                                          .paymentstatusvalue ==
                                                      "1") {
                                                ischeckin = true;
                                                if (ischeckin == true) {
                                                  // Perform booking

                                                  // widget.user.status = 'Booked';
                                                  isLoading = false;
                                                  setState(() {});

                                                  try {
                                                    if (widget.user.TypeBit == 2 ||
                                                        widget.user.TypeBit ==
                                                            3) {
                                                      await checkinapi();
                                                      getappointments(
                                                        widget.empId,
                                                        AppConstants
                                                            .maximumDataTobeFetched,
                                                        0,
                                                      );
                                                    } else if (widget
                                                                .user.TypeBit ==
                                                            8 ||
                                                        widget.user.TypeBit ==
                                                            25 ||
                                                        widget.user.TypeBit ==
                                                            26 ||
                                                        widget.user.TypeBit ==
                                                            27 ||
                                                        widget.user.TypeBit ==
                                                            28 ||
                                                        widget.user.TypeBit ==
                                                            29) {
                                                      await checkinapidoctor();
                                                      getappointments(
                                                        widget.empId,
                                                        AppConstants
                                                            .maximumDataTobeFetched,
                                                        0,
                                                      );
                                                    }

                                                    await getsampleapi();
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                  } catch (e) {
                                                    log(e.toString());
                                                    setState(() {
                                                      isLoading = false;
                                                    });
                                                  }
                                                }
                                              } else {
                                                // Payment method not selected
                                                Showtoaster().classtoaster(
                                                    "pleaseselectpaymentmethod"
                                                        .tr);
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                            ),
                                            child: Text(
                                              "checkin".tr,
                                              style: GoogleFonts.poppins(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),

                              if (widget.user.status == "Booked")
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.05),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment.center,
                                    children: [
                                      // if(chk)
                                      widget.user.status == "Booked" &&
                                              (widget.user.TypeBit == 2 ||
                                                  widget.user.TypeBit == 3)
                                          ? SizedBox(
                                              width: Get.width * 0.43,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 0),
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      showDialog<void>(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          30),
                                                            ),
                                                            content: SizedBox(
                                                              height:
                                                                  Get.height *
                                                                      0.23,
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      const Text(
                                                                          ""),
                                                                      Text('cancelride'
                                                                          .tr),
                                                                      InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Get.back();
                                                                          },
                                                                          child:
                                                                              const Icon(CupertinoIcons.clear)),
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                      height: Get
                                                                              .height *
                                                                          0.02),
                                                                  TextFormField(
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          'remarks'
                                                                              .tr,
                                                                      enabledBorder: const OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              width: 1,
                                                                              color: Colors.black)),
                                                                      disabledBorder:
                                                                          InputBorder
                                                                              .none,
                                                                      border: const OutlineInputBorder(
                                                                          borderSide: BorderSide(
                                                                              width: 1,
                                                                              color: Colors.black)),
                                                                    ),
                                                                    controller:
                                                                        _remarksController,
                                                                    // placeholder:
                                                                    //     'enterremarks'
                                                                    //         .tr,
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        Get.height *
                                                                            0.03,
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        Get.width *
                                                                            0.7,
                                                                    child:
                                                                        CupertinoButton(
                                                                      color: Colors
                                                                          .blue,
                                                                      borderRadius: const BorderRadius
                                                                          .all(
                                                                          Radius.circular(
                                                                              15.0)),
                                                                      child:
                                                                          Text(
                                                                        'ok'.tr,
                                                                      ),
                                                                      onPressed:
                                                                          () async {
                                                                        widget
                                                                            .user
                                                                            .status = "Ride Started";
                                                                        if (_remarksController
                                                                            .text
                                                                            .isNotEmpty) {
                                                                          chk =
                                                                              false;
                                                                          String
                                                                              remarks =
                                                                              _remarksController.text;
                                                                          isRideCancel =
                                                                              true;
                                                                          if (isRideCancel) {
                                                                            setState(() {
                                                                              message = 'Ride Cancel successfully!';
                                                                            });
                                                                          }
                                                                          await CancelRide(
                                                                              widget.user,
                                                                              remarks);
                                                                          isRideCancel =
                                                                              true;
                                                                          setState(
                                                                              () {});
                                                                          _remarksController
                                                                              .clear();
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        } else {
                                                                          Showtoaster()
                                                                              .classtoaster("pleaseenterremarks".tr);
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.red,
                                                      fixedSize:
                                                          const Size(140, 4),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15), // Set the border radius here
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "cancel".tr,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                    )),
                                              ),
                                            )
                                          :

                                          // log("Image tapped");
                                          // const SizedBox(
                                          //   width: 0.01,
                                          // // ),
                                          // if (widget.user.status == "Booked" &&
                                          //     (widget.user.TypeBit == 8 ||
                                          //         widget.user.TypeBit == 25))
                                          SizedBox(
                                              width: Get.width * 0.43,
                                              child: ElevatedButton(
                                                  onPressed: () async {
                                                    // Navigator.push(
                                                    //     context,
                                                    //     MaterialPageRoute(
                                                    //         builder: (context) =>
                                                    //             PdfViewerPage(
                                                    //               url: widget
                                                    //                   .user
                                                    //                   .InvoiceURL,
                                                    //             )));

                                                    if (await canLaunch(ip2 +
                                                        widget
                                                            .user.InvoiceURL)) {
                                                      await launch(ip2 +
                                                          widget
                                                              .user.InvoiceURL);
                                                    } else {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              'Could not launch ${ip2 + widget.user.InvoiceURL}');
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green,
                                                    // fixedSize: const Size(140, 4),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15), // Set the border radius here
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "Print".tr,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  )),
                                            ),
                                      // if(!isRideEnd && !isRideCancel)
                                      // if (widget.user.status == "Booked")
                                      Visibility(
                                        visible:
                                            widget.user.status == "Booked" &&
                                                (widget.user.TypeBit == 2 ||
                                                    widget.user.TypeBit == 3),
                                        child: SizedBox(
                                          width: Get.width * 0.43,
                                          child: ElevatedButton(
                                              onPressed: () async {
                                                // await _showarrivedDialog();
                                                await _showarrivedDialog(
                                                    'Have you Collected Sample',
                                                    false,
                                                    true);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                fixedSize: const Size(150, 4),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                              ),
                                              child: Text(
                                                "samplecollected".tr,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              )),
                                        ),
                                      ),
                                      if (widget.user.status == "Booked" &&
                                          (widget.user.TypeBit == 8 ||
                                              widget.user.TypeBit == 25 ||
                                              widget.user.TypeBit == 26 ||
                                              widget.user.TypeBit == 27 ||
                                              widget.user.TypeBit == 28 ||
                                              widget.user.TypeBit == 29))
                                        SizedBox(
                                          // height: Get.height * 0.04,
                                          width: Get.width * 0.43,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                isLoading = true;
                                                setState(() {});
                                                try {
                                                  CompleteRide(widget.user);
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                } catch (e) {
                                                  setState(() {
                                                    isLoading = false;
                                                  });
                                                }
                                                setState(() {
                                                  isLoading = false;
                                                });

                                                showDialog<void>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          top: Get.height *
                                                              0.15),
                                                      child:
                                                          CupertinoAlertDialog(
                                                        content: Column(
                                                          children: [
                                                            const SizedBox(
                                                              height: 30,
                                                            ),
                                                            Image.asset(
                                                                'assets/show.png'),
                                                            const SizedBox(
                                                              height: 20,
                                                            ),
                                                            Align(
                                                              alignment: Alignment
                                                                  .bottomCenter,
                                                              child: Text(
                                                                'thankyou'.tr,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 30,
                                                            ),
                                                          ],
                                                        ),
                                                        actions: <Widget>[
                                                          CupertinoButton(
                                                            color: ColorManager
                                                                .kDarkBlue,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                                    Radius.circular(
                                                                        10.0)),
                                                            child: Text(
                                                              'backhome'.tr,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          Dashboard(
                                                                            empId:
                                                                                widget.empId,
                                                                            userName:
                                                                                userprofile?.fullName ?? "",
                                                                          )));
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15), // Set the border radius here
                                                ),
                                              ),
                                              child: Text(
                                                "Completed".tr,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              )),
                                        )
                                    ],
                                  ),
                                ),

                              SizedBox(
                                height: Get.height * 0.02,
                              ),
                              Visibility(
                                visible: widget.user.status == "Completed",
                                child: Center(
                                  child: SizedBox(
                                    width: Get.width * 0.83,
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          // Navigator.push(
                                          //     context,
                                          //     MaterialPageRoute(
                                          //         builder: (context) =>
                                          //             PdfViewerPage(
                                          //               url: widget
                                          //                   .user
                                          //                   .InvoiceURL,
                                          //             )));

                                          if (await canLaunch(
                                              ip2 + widget.user.InvoiceURL)) {
                                            await launch(
                                                ip2 + widget.user.InvoiceURL);
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Could not launch ${ip2 + widget.user.InvoiceURL}');
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          // fixedSize: const Size(140, 4),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                15), // Set the border radius here
                                          ),
                                        ),
                                        child: Text(
                                          "Print".tr,
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        )),
                                  ),
                                ),
                              ),

                              widget.user.status == "Booked"
                                  ? SizedBox(height: Get.height * 0.07)
                                  : const SizedBox.shrink(),
                              if (widget.user.status == "Booked")
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "totalamount".tr,
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        "${widget.user.totalamount ?? "0.0"}",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ),

                              if (widget.user.status == "Booked")
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "paymentstatus".tr,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "${paymentstatus ?? " "} ",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    )),
                              // SizedBox(height: Get.height*0.05,),

                              //checked in

                              if (widget.user.status == "Ride Arrived" ||
                                  widget.user.status == "Consent Received" ||
                                  widget.user.status == "Sample Collected" ||
                                  widget.user.status == "In Route" ||
                                  widget.user.status == "Sample Delivered")
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Get.width * 0.05),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Column(children: [
                                          Row(
                                            children: [
                                              // Column(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment.end,
                                              //   crossAxisAlignment:
                                              //       CrossAxisAlignment.start,
                                              //   children: [
                                              //     // if (widget.user.status ==
                                              //     //     "Ride Arrived")
                                              //       // SizedBox(
                                              //       //     child: widget.user
                                              //       //                 .paymentstatusvalue ==
                                              //       //             "1"
                                              //       //         ? Text(
                                              //       //             "discount".tr,
                                              //       //             style: const TextStyle(
                                              //       //                 color: Colors
                                              //       //                     .white),
                                              //       //           )
                                              //       //         : const SizedBox
                                              //       //             .shrink()),
                                              //       if (widget.user.status ==
                                              //           "Ride Arrived")
                                              //         SizedBox(
                                              //           height: MediaQuery.of(
                                              //                       context)
                                              //                   .size
                                              //                   .height *
                                              //               0.04,
                                              //           width: MediaQuery.of(
                                              //                       context)
                                              //                   .size
                                              //                   .width *
                                              //               0.27,
                                              //           child: widget.user
                                              //                       .paymentstatusvalue !=
                                              //                   "1"
                                              //               ? Padding(
                                              //                   padding: EdgeInsets
                                              //                       .symmetric(
                                              //                           vertical:
                                              //                               Get.height *
                                              //                                   0.01),
                                              //                   child: Row(
                                              //                     mainAxisAlignment:
                                              //                         MainAxisAlignment
                                              //                             .start,
                                              //                     children: [
                                              //                       Text(
                                              //                         'yes'.tr,
                                              //                         style: const TextStyle(
                                              //                             color:
                                              //                                 Colors.white),
                                              //                       ),
                                              //                       Obx(() =>
                                              //                           SizedBox(
                                              //                             width:
                                              //                                 MediaQuery.of(context).size.width * 0.06,
                                              //                             child:
                                              //                                 Radio(
                                              //                               value:
                                              //                                   'yes'.tr,
                                              //                               groupValue:
                                              //                                   _selectedOption.value, // Access value property
                                              //                               fillColor:
                                              //                                   MaterialStateColor.resolveWith((states) => Colors.white),
                                              //                               onChanged:
                                              //                                   (value) {
                                              //                                 _selectedOption.value = value!; // Update _selectedOption value
                                              //                               },
                                              //                             ),
                                              //                           )),
                                              //                       Obx(
                                              //                           () =>
                                              //                               Row(
                                              //                                 mainAxisSize: MainAxisSize.min,
                                              //                                 children: [
                                              //                                   Text(
                                              //                                     'no'.tr,
                                              //                                     style: const TextStyle(color: Colors.white),
                                              //                                   ),
                                              //                                   SizedBox(
                                              //                                     width: MediaQuery.of(context).size.width * 0.06,
                                              //                                     child: Radio(
                                              //                                       value: 'no'.tr,
                                              //                                       groupValue: _selectedOption.value,
                                              //                                       fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
                                              //                                       onChanged: (value) {
                                              //                                         discount = TextEditingController();
                                              //                                         dsct = "0.0";
                                              //                                         setState(() {});
                                              //                                         _selectedOption.value = value!;
                                              //                                       },
                                              //                                     ),
                                              //                                   ),
                                              //                                 ],
                                              //                               )),
                                              //                     ],
                                              //                   ),
                                              //                 )
                                              //               : const SizedBox
                                              //                   .shrink(),
                                              //         ),
                                              //   ],
                                              // ),
                                              widget.user.status ==
                                                      "Consent Received"
                                                  ? Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        InkWell(
                                                          onTap: () async {
                                                            Selectpayment =
                                                                null;
                                                            payments.clear();
                                                            await paymentapi();
                                                            setState(() {});
                                                          },
                                                          child: SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.37,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.05,
                                                            child: widget.user
                                                                        .paymentstatusvalue !=
                                                                    "1"
                                                                ? Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      border: Border.all(
                                                                          color: Colors
                                                                              .black,
                                                                          width:
                                                                              0.5),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5.0),
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    height: MediaQuery.of(context)
                                                                            .size
                                                                            .height *
                                                                        0.05,
                                                                    width:
                                                                        Get.width *
                                                                            0.32,
                                                                    child:
                                                                        DropdownButtonFormField(
                                                                      decoration:
                                                                          const InputDecoration(
                                                                        contentPadding:
                                                                            EdgeInsets.only(bottom: 12),
                                                                        border:
                                                                            InputBorder.none,
                                                                      ),
                                                                      value:
                                                                          Selectpayment,
                                                                      hint: Text(
                                                                          'paymentmethod'
                                                                              .tr,
                                                                          textAlign:
                                                                              TextAlign.center),
                                                                      items: payments.map<
                                                                          DropdownMenuItem<
                                                                              String>>((PaymentMethod
                                                                          val) {
                                                                        return DropdownMenuItem<
                                                                            String>(
                                                                          value:
                                                                              val.name,
                                                                          child: Text(val
                                                                              .name
                                                                              .toString()),
                                                                        );
                                                                      }).toList(),
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            10,
                                                                      ),
                                                                      onChanged:
                                                                          (String?
                                                                              newValue) {
                                                                        discount
                                                                            .clear();
                                                                        setState(
                                                                            () {
                                                                          Selectpayment =
                                                                              newValue;
                                                                          ispaymentselected =
                                                                              true;
                                                                          print(
                                                                              newValue);
                                                                        });
                                                                      },
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                    ),
                                                                  )
                                                                : const SizedBox
                                                                    .shrink(),
                                                          ),
                                                        ),
                                                        // Obx(
                                                        //   () => _selectedOption ==
                                                        //           'yes'.tr
                                                        //       ? Row(
                                                        //           children: [
                                                        //             Container(
                                                        //               decoration:
                                                        //                   BoxDecoration(
                                                        //                 border: Border.all(
                                                        //                     color:
                                                        //                         Colors.black,
                                                        //                     width: 0.5),
                                                        //                 borderRadius:
                                                        //                     BorderRadius.circular(5.0),
                                                        //                 color: Colors
                                                        //                     .white,
                                                        //               ),
                                                        //               width: MediaQuery.of(context)
                                                        //                       .size
                                                        //                       .width *
                                                        //                   0.22,
                                                        //               height: MediaQuery.of(context)
                                                        //                       .size
                                                        //                       .height *
                                                        //                   0.05,
                                                        //               child:
                                                        //                   DropdownButtonFormField(
                                                        //                 decoration:
                                                        //                     const InputDecoration(
                                                        //                   contentPadding:
                                                        //                       EdgeInsets.only(bottom: 12),
                                                        //                   border:
                                                        //                       InputBorder.none,
                                                        //                 ),
                                                        //                 value:
                                                        //                     dropdownvalue,
                                                        //                 items: item1.map((String
                                                        //                     items) {
                                                        //                   return DropdownMenuItem(
                                                        //                     value:
                                                        //                         items,
                                                        //                     child:
                                                        //                         Center(
                                                        //                       child: Text(
                                                        //                         "  $items",
                                                        //                         //  textAlign: AlignmentDirectional.topCenter,
                                                        //                       ),
                                                        //                     ),
                                                        //                   );
                                                        //                 }).toList(),
                                                        //                 style:
                                                        //                     const TextStyle(
                                                        //                   color:
                                                        //                       Colors.black,
                                                        //                   fontSize:
                                                        //                       12,
                                                        //                 ),
                                                        //                 onChanged:
                                                        //                     (String?
                                                        //                         newValue) {
                                                        //                   setState(
                                                        //                       () {
                                                        //                     dropdownvalue =
                                                        //                         newValue!;
                                                        //                   });
                                                        //                 },
                                                        //                 alignment:
                                                        //                     Alignment.center,
                                                        //                 elevation:
                                                        //                     0,
                                                        //               ),
                                                        //             ),
                                                        //             SizedBox(
                                                        //               width: MediaQuery.of(context)
                                                        //                       .size
                                                        //                       .width *
                                                        //                   0.15,
                                                        //               height: MediaQuery.of(context)
                                                        //                       .size
                                                        //                       .height *
                                                        //                   0.05,
                                                        //               child:
                                                        //                   TextFormField(
                                                        //                 controller:
                                                        //                     discount,
                                                        //                 onChanged:
                                                        //                     (val) {
                                                        //                   if (dropdownvalue == "percentage".tr &&
                                                        //                       val.replaceAll('0', '') !=
                                                        //                           "") {
                                                        //                     dsct = int.parse(val) >= 100
                                                        //                         ? totalAppointmentPrice.toString()
                                                        //                         : ((totalAppointmentPrice - ((totalAppointmentPrice / 100) * int.parse(val)))).toString();
                                                        //                   } else if (dropdownvalue != "" &&
                                                        //                       val.replaceAll('0', '') !=
                                                        //                           "") {
                                                        //                     dsct = double.parse(val) > totalAppointmentPrice
                                                        //                         ? totalAppointmentPrice.toString()
                                                        //                         : (totalAppointmentPrice - int.parse(val)).toString();
                                                        //                   } else if (discount.text.isEmpty ||
                                                        //                       val.replaceAll('0', '') == "") {
                                                        //                     dsct =
                                                        //                         "0.0";
                                                        //                   }
                                                        //                   setState(
                                                        //                       () {});
                                                        //                 },
                                                        //                 keyboardType:
                                                        //                     TextInputType.number,
                                                        //                 decoration:
                                                        //                     InputDecoration(
                                                        //                   contentPadding: EdgeInsets.symmetric(
                                                        //                       vertical: Get.height * 0.01,
                                                        //                       horizontal: Get.width * 0.02),
                                                        //                   filled:
                                                        //                       true,
                                                        //                   fillColor:
                                                        //                       Colors.white,
                                                        //                   hintText:
                                                        //                       dropdownvalue,
                                                        //                   border:
                                                        //                       OutlineInputBorder(
                                                        //                     borderSide:
                                                        //                         const BorderSide(color: Colors.black),
                                                        //                     borderRadius:
                                                        //                         BorderRadius.circular(5.0),
                                                        //                   ),
                                                        //                 ),
                                                        //                 style:
                                                        //                     const TextStyle(
                                                        //                   color:
                                                        //                       Colors.black, // Text color
                                                        //                   fontSize:
                                                        //                       12.0, // Text size
                                                        //                 ),
                                                        //               ),
                                                        //             ),
                                                        //           ],
                                                        //         )
                                                        //       : const SizedBox(),
                                                        // ),
                                                      ],
                                                    )
                                                  : const SizedBox.shrink(),
                                            ],
                                          ),
                                          if (widget.user.status ==
                                              "Sample Collected")
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  if (widget.user.status ==
                                                      "Sample Collected")
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: InkWell(
                                                        onTap: () async {
                                                          SelectLab = null;
                                                          Labs.clear();
                                                          await labsapi();
                                                          setState(() {});
                                                          dynamic generic =
                                                              await custom_dropdown(
                                                            context,
                                                            Labs,
                                                          );
                                                          _selectedlab =
                                                              generic;
                                                          selectedLabsName =
                                                              null;
                                                          if (generic != null &&
                                                              generic != '') {
                                                            SelectLab =
                                                                generic.id;
                                                            selectedLabsName =
                                                                (generic.name ==
                                                                        '')
                                                                    ? null
                                                                    : generic
                                                                        .name;

                                                            setState(() {});
                                                          }
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15.0),
                                                            color: Colors.white,
                                                          ),
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.4,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.05,
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric(
                                                                horizontal: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.04),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Text(
                                                                  //"${selectedCountriesName?? "Country"}",
                                                                  "${(selectedLabsName != null) ? (selectedLabsName!.length > 8 ? ('${selectedLabsName!.substring(0, 8)}...') : selectedLabsName) : "selectlab".tr}",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: selectedLabsName !=
                                                                              null
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .grey[700]),
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .arrow_drop_down,
                                                                  size: 25,
                                                                  color: selectedLabsName !=
                                                                          null
                                                                      ? Colors
                                                                          .black
                                                                      : Colors.grey[
                                                                          700],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  SizedBox(
                                                    width: Get.width * 0.08,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: SizedBox(
                                                      height: Get.height * 0.05,
                                                      width: Get.width * 0.4,
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          if (selectedLabsName ==
                                                              null) {
                                                            Showtoaster()
                                                                .classtoaster(
                                                                    "pleaseselect"
                                                                        .tr);
                                                          } else {
                                                            isLoading = true;
                                                            setState(() {});
                                                            try {
                                                              await InRouteapi();
                                                              _getPolylinesWithLocation(
                                                                  _currentLatLng,
                                                                  LatLng(
                                                                      double.parse(_selectedlab!
                                                                          .latitude
                                                                          .toString()),
                                                                      double.parse(_selectedlab!
                                                                          .longitude
                                                                          .toString())));
                                                              setState(() {
                                                                isLoading =
                                                                    false;
                                                              });
                                                            } catch (e) {
                                                              setState(() {
                                                                isLoading =
                                                                    false;
                                                              });
                                                            }
                                                            setState(() {
                                                              isLoading = false;
                                                            });

                                                            setState(() {
                                                              //  message='';
                                                              widget.user
                                                                      .status =
                                                                  "In Route";
                                                            });
                                                          }
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'inroutelab'.tr,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .blue),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ]),

                                          // if (widget.user.status ==
                                          //     "Sample Collected")
                                          //   Center(
                                          //     child: Row(
                                          //       mainAxisAlignment:
                                          //           MainAxisAlignment.center,
                                          //       children: [
                                          //         Text(
                                          //           "totalamount".tr,
                                          //           style: GoogleFonts.poppins(
                                          //             fontSize: 12,
                                          //             fontWeight:
                                          //                 FontWeight.bold,
                                          //             color: Colors.white,
                                          //           ),
                                          //           textAlign: TextAlign.center,
                                          //         ),
                                          //         Text(
                                          //           "$totalAppointmentPrice",
                                          //           style: GoogleFonts.poppins(
                                          //             fontSize: 12,
                                          //             fontWeight:
                                          //                 FontWeight.bold,
                                          //             color: Colors.white,
                                          //           ),
                                          //           textAlign: TextAlign.center,
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),
                                          // if (widget.user.status ==
                                          //     "Sample Collected")
                                          //   Center(
                                          //     child: Row(
                                          //       mainAxisAlignment:
                                          //           MainAxisAlignment.center,
                                          //       children: [
                                          //         Text(
                                          //           "paymentstatus".tr,
                                          //           style: GoogleFonts.poppins(
                                          //             fontSize: 12,
                                          //             color: Colors.white,
                                          //           ),
                                          //           textAlign: TextAlign.center,
                                          //         ),
                                          //         Text(
                                          //           "${widget.user.paymentstatusname ?? " "} ",
                                          //           style: GoogleFonts.poppins(
                                          //             fontSize: 12,
                                          //             color: Colors.white,
                                          //           ),
                                          //           textAlign: TextAlign.center,
                                          //         ),
                                          //       ],
                                          //     ),
                                          //   ),

                                          widget.user.status == "In Route"
                                              ? SizedBox(
                                                  height: Get.height * 0.05,
                                                  width: Get.width * 0.88,
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      isLoading = true;
                                                      setState(() {});
                                                      try {
                                                        _polylines.clear();
                                                        setState(() {});

                                                        distance = 0.0;
                                                        time = 0.0;
                                                        _markers.clear();
                                                        setState(() {
                                                          _polylines;
                                                          _markers;
                                                        });

                                                        String? msg =
                                                            await sampledeliveredapi();
                                                        if (msg != null) {
                                                          widget.user.status =
                                                              "Sample Delivered";
                                                        }
                                                        Fluttertoast.showToast(
                                                            msg: msg ??
                                                                "Sample Delivered Successfully",
                                                            toastLength: Toast
                                                                .LENGTH_SHORT,
                                                            gravity:
                                                                ToastGravity
                                                                    .BOTTOM,
                                                            timeInSecForIosWeb:
                                                                1,
                                                            backgroundColor:
                                                                Colors.green,
                                                            textColor:
                                                                Colors.white,
                                                            fontSize: 16.0);
                                                        setState(() {
                                                          isLoading = false;
                                                        });
                                                      } catch (e) {
                                                        setState(() {
                                                          isLoading = false;
                                                        });
                                                      }

                                                      setState(() {
                                                        isLoading = false;
                                                      });

                                                      setState(() {});
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.white,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      'deliversample'.tr,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.blue),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink(),
                                          Row(
                                            children: [
                                              widget.user.status ==
                                                      "Sample Delivered"
                                                  ? SizedBox(
                                                      width: Get.width * 0.4,
                                                      child: ElevatedButton(
                                                          onPressed: () async {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            PdfViewerPage(
                                                                              url: widget.user.InvoiceURL,
                                                                            )));
                                                            log("Image tapped");
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.green,
                                                            // fixedSize: const Size(140, 4),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15), // Set the border radius here
                                                            ),
                                                          ),
                                                          child: Text(
                                                            "Print".tr,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .white),
                                                          )),
                                                    )
                                                  : const SizedBox.shrink(),
                                              SizedBox(
                                                width: Get.width * 0.04,
                                              ),
                                              widget.user.status == "In Route"
                                                  ? SizedBox(
                                                      height: Get.height * 0.07)
                                                  : const SizedBox.shrink(),
                                              widget.user.status ==
                                                      "Sample Delivered"
                                                  ? SizedBox(
                                                      // height: Get.height * 0.04,
                                                      width: Get.width * 0.4,
                                                      child: ElevatedButton(
                                                          onPressed: () {
                                                            isLoading = true;
                                                            setState(() {});
                                                            try {
                                                              CompleteRide(
                                                                  widget.user);
                                                              setState(() {
                                                                isLoading =
                                                                    false;
                                                              });
                                                            } catch (e) {
                                                              setState(() {
                                                                isLoading =
                                                                    false;
                                                              });
                                                            }
                                                            setState(() {
                                                              isLoading = false;
                                                            });

                                                            showDialog<void>(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return Padding(
                                                                  padding: EdgeInsets.only(
                                                                      top: Get.height *
                                                                          0.15),
                                                                  child:
                                                                      CupertinoAlertDialog(
                                                                    content:
                                                                        Column(
                                                                      children: [
                                                                        const SizedBox(
                                                                          height:
                                                                              30,
                                                                        ),
                                                                        Image.asset(
                                                                            'assets/show.png'),
                                                                        const SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        Align(
                                                                          alignment:
                                                                              Alignment.bottomCenter,
                                                                          child:
                                                                              Text(
                                                                            'thankyou'.tr,
                                                                            style:
                                                                                GoogleFonts.poppins(
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              30,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    actions: <Widget>[
                                                                      CupertinoButton(
                                                                        color: ColorManager
                                                                            .kDarkBlue,
                                                                        borderRadius: const BorderRadius
                                                                            .all(
                                                                            Radius.circular(10.0)),
                                                                        child:
                                                                            Text(
                                                                          'backhome'
                                                                              .tr,
                                                                        ),
                                                                        onPressed:
                                                                            () async {
                                                                          Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                  builder: (context) => TodayAppoinments(
                                                                                        empId: widget.empId,
                                                                                      )));
                                                                        },
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            );
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.white,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15), // Set the border radius here
                                                            ),
                                                          ),
                                                          child: Text(
                                                            "Completed".tr,
                                                            style: GoogleFonts
                                                                .poppins(
                                                                    fontSize:
                                                                        14,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    color: Colors
                                                                        .blue),
                                                          )),
                                                    )
                                                  : const SizedBox.shrink(),
                                            ],
                                          ),
                                          widget.user.status ==
                                                  "Sample Delivered"
                                              ? SizedBox(
                                                  height: Get.height * 0.07)
                                              : const SizedBox.shrink(),
                                          if (widget.user.StatusValue == 20)
                                            Obx(
                                              () => _selectedOption == 'yes'.tr
                                                  ? Center(
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.64,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      0.6),
                                                          child: TextFormField(
                                                            onChanged: (val) {},
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      bottom: Get
                                                                              .height *
                                                                          0.02,
                                                                      left: Get
                                                                              .width *
                                                                          0.02),
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              hintText:
                                                                  'Remarks',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: Color
                                                                        .fromARGB(
                                                                            255,
                                                                            100,
                                                                            24,
                                                                            24)),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                              ),
                                                            ),
                                                            style:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .black, // Text color
                                                              fontSize:
                                                                  12.0, // Text size
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : const SizedBox(),
                                            ),
                                        ]),
                                        Visibility(
                                          visible:
                                              widget.user.paymentstatusvalue !=
                                                  "1",
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              if (widget.user.status ==
                                                  "Consent Received")
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "amount".tr,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                    Text(
                                                      "${widget.user.amount ?? "0.0"}",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ],
                                                ),
                                              if (widget.user.status ==
                                                  "Consent Received")
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "discount".tr,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                    widget.user.discounttype ==
                                                            2
                                                        ? Text(
                                                            "${widget.user.discount ?? "0.0"}%",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            textAlign:
                                                                TextAlign.right,
                                                          )
                                                        : Text(
                                                            "${widget.user.discount ?? "0.0"}",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 10,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            textAlign:
                                                                TextAlign.right,
                                                          )
                                                  ],
                                                ),
                                              if (widget.user.status ==
                                                  "Consent Received")
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "totalamount".tr,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                    Text(
                                                      "${widget.user.totalamount ?? "0.0"} ",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign:
                                                          TextAlign.right,
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          ),
                                        )
                                      ]),
                                ),
                              if (widget.user.status == "Consent Received")
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    height: MediaQuery.of(context).size.height *
                                        0.06,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "paymentstatus".tr,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "${widget.user.paymentstatusname ?? " "} ",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    )),
                              if (widget.user.status == "Pending")
                                SizedBox(
                                  height: Get.height * 0.03,
                                ),
                              if (widget.user.status == "Pending" ||
                                  widget.user.status == "Ride Arrived" ||
                                  widget.user.status == "Ride Started" ||
                                  widget.user.status == "Consent Received" ||
                                  widget.user.status == "Booked" ||
                                  widget.user.status == "Sample Collected")
                                Center(
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: Get.height * 0.01),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "order".tr,
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "${widget.user.LabNo ?? " #0001"} ",
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                              if (widget.user.status == "Pending")
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "paymentstatus".tr,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      "${widget.user.paymentstatusname ?? " "} ",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              widget.user.status == "Sample Collected"
                                  ? SizedBox(height: Get.height * 0.04)
                                  : const SizedBox.shrink(),
                              widget.user.status == "Sample Collected"
                                  ? Center(
                                      child: Text(
                                        "Total Amount: ${widget.user.totalamount ?? "0.0"} ",
                                        style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.005,
                              ),
                              // Padding(
                              //           padding: const EdgeInsets.only(top:30.0,left: 70),
                              //           child: Text(message ?? '', style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.normal,color: Colors.white)),
                              // ),

                              // SizedBox(
                              //   height:
                              //       MediaQuery.of(context).size.height *
                              //           0.015,
                              // ),
                              //   widget.user.status ==
                              //     "Sample Collected"?         SizedBox(
                              // width: MediaQuery.of(context).size.width*1,
                              // child: Text("Payment Status: Paid",style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white,),textAlign: TextAlign.center,)):SizedBox.shrink(),

                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.05),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomButton(
                                      onPressed: () {
                                        FlutterPhoneDirectCaller().callnumber(
                                            widget.user.cellNumber.toString());
                                      },
                                      title: "call".tr,
                                      radius: 20,
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      primcolor: ColorManager.kDarkBlue,
                                      //    width: Get.width*0.4,
                                      // height: Get.height*0.088,
                                    ),
                                    CustomButton(
                                      onPressed: () async {
                                        final Uri smsLaunchUri = Uri(
                                          scheme: 'sms',
                                          path: widget.user.cellNumber,
                                        );
                                        urllauncher.launchUrl(smsLaunchUri);

                                        setState(() {});
                                        // whatsapp();
                                        //  Get.to(RiderChat());
                                      },
                                      title: "message".tr,
                                      radius: 20,
                                      style: GoogleFonts.poppins(
                                          color: Colors.blue,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                      primcolor: Colors.white,
                                      // width: Get.width*0.4,
                                      // height: Get.height*0.088,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )),
                ]))));
  }
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
