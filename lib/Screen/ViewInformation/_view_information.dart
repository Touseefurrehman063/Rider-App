import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/appointmentdetail.dart';
import 'package:flutter_riderapp/Models/checkinresponse.dart';
import 'package:flutter_riderapp/Models/checkintry.dart';
import 'package:flutter_riderapp/Models/in_routeModel.dart';
import 'package:flutter_riderapp/Models/labsmodel.dart';
import 'package:flutter_riderapp/Models/payment_method.dart';
import 'package:flutter_riderapp/Models/sample_delivered.dart';
import 'package:flutter_riderapp/Models/samplebody.dart';
import 'package:flutter_riderapp/Models/samplecollectedmodel.dart';
import 'package:flutter_riderapp/Models/samplecollectionresponse.dart';
import 'package:flutter_riderapp/Screen/Dashboard/_dashboard.dart';
import 'package:flutter_riderapp/Widgets/Custombutton.dart';
import 'package:flutter_riderapp/Widgets/Customdropdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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

  ViewInformation(
      {required this.user, required this.empId, required this.labid, Key? key})
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
  double distance = 0.0;
  double time = 0.0;
  bool ispaymentselected = false;

  List<String> paymentNameArray = ['Select Vehicle'];
  List<String> labsNameArray = ['selectlab'.tr];
  List<String> appointmentNameArray = ['appointment detail'];
  final RxString _selectedOption = 'no'.tr.obs;
  int _polylineCount = 1;
  final GoogleMapPolyline _googleMapPolyline =
      GoogleMapPolyline(apiKey: "AIzaSyAO9XAv-175N385sGFtr-aeA3EgjEIGWWY");
  LatLng _currentLatLng = const LatLng(0.0, 0.0);
  final Completer<GoogleMapController> _controller = Completer();
  final Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};

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
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(timeInHours.toString())));
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
  String googleAPiKey = "AIzaSyAO9XAv-175N385sGFtr-aeA3EgjEIGWWY";
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
      tempobj.typeBit = "2";
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
      if (status != null && status == 1 && detail != null) {
        checkinreponselist.add(checkinresponse.fromJson(detail));

        ischeckin = true;
        debugPrint(response.body);
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
      if (status != null && status == 2) {
        isRideStarted = true;
      } else {
        isRideStarted = false;
        debugPrint("Data is null");
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
      'LabNo': user.LabNo,
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
      if (status != null && status == 2) {
        widget.user.status = "Ride Arrived";
        isRideEnd = true;
      } else {
        isRideEnd = false;
        debugPrint("Data is empty");
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
      'PatientId': user.patientid,
      'UserId': widget.empId,
      'LabNo': user.LabNo,
      'BranchLocationId': user.branchlocationid,
      'PatientAppointmentId': user.Patientappoinmentid,
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
                          backgroundColor: Colors.blue,
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

  _showarrivedDialog() {
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
              content: Text('arrivedatlocation'.tr),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
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

                          Navigator.of(context).pop();
                          // Navigator.push(
                          //   context, MaterialPageRoute(builder: (context)=> ViewInformation(user:widget.user)));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.099,
                              child: Image.asset(
                                "assets/back.png",
                                height:
                                    MediaQuery.of(context).size.height * 0.11,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: MediaQuery.of(context).size.height * 0.03,
                          left: MediaQuery.of(context).size.width * 0.33,
                          child: Image.asset(
                            "assets/Helpful.png",
                            height: MediaQuery.of(context).size.height * 0.065,
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
                            color: Colors.blue,
                            elevation: 0,
                            child: SingleChildScrollView(
                              child: ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.02,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                          ),
                                          Text(
                                            '${DateFormat('d MMMM y').format(DateTime.parse(widget.user.StartDate!))} | ${widget.user.time ?? ""}',
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Icon(Icons.person,
                                                  color: Colors.white),
                                              const SizedBox(width: 10),
                                              Flexible(
                                                child: Text(
                                                  widget.user.patientName ?? "",
                                                 
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow:
                                                      TextOverflow.clip,
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
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    children: [
                                                      TextSpan(
                                                        text: widget
                                                                .user.test ??
                                                            "",
                                                        style: GoogleFonts
                                                            .poppins(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight
                                                                  .normal,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    children: [
                                                      TextSpan(
                                                          text: widget.user
                                                                  .address ??
                                                              "",
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal)),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      trailing: Text(
                                        widget.user.status ?? "",
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ),

                                    if (widget.user.status == "Pending")
                                      Align(
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
                                    // SizedBox(
                                    //   height:
                                    //       MediaQuery.of(context).size.height *
                                    //           0.02,
                                    // ),
                                    if (widget.user.status == "Pending")
                                      Center(
                                        child: Padding(
                                          padding:  EdgeInsets.only(top:Get.height*0.02),
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
                                    // SizedBox(
                                    //   height:
                                    //       MediaQuery.of(context).size.height *
                                    //           0.02,
                                    // ),
                                    if (widget.user.status == "Pending")
                                      Padding(
                                        padding:  EdgeInsets.symmetric(vertical: Get.height*0.02),
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
                                              "${widget.user.paymentstatusname ?? " Unpaid"} ",
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),

                                    if (widget.user.status == "Ride Started")
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // if(chk)
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    showDialog<void>(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return CupertinoAlertDialog(
                                                          title: Text(
                                                              'cancelride'.tr),
                                                          content: Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 30,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            170.0),
                                                                child: Text(
                                                                  'remarks'.tr,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                          fontSize:
                                                                              14),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 30,
                                                              ),
                                                              CupertinoTextField(
                                                                controller:
                                                                    _remarksController,
                                                                placeholder:
                                                                    'enterremarks'
                                                                        .tr,
                                                              ),
                                                            ],
                                                          ),
                                                          actions: <Widget>[
                                                            CupertinoButton(
                                                              color:
                                                                  Colors.blue,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          5.0)),
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
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(SnackBar(
                                                                          content:
                                                                              Text("pleaseenterremarks".tr)));
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                    fixedSize:
                                                        const Size(120, 4),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8), // Set the border radius here
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "cancel".tr,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  )),
                                            ),
                                            const SizedBox(
                                              width: 0.01,
                                            ),
                                            if (!isRideEnd && !isRideCancel)
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 5.0),
                                                child: ElevatedButton(
                                                    onPressed: () async {
                                                      await _showarrivedDialog();

                                                      if (isRideEnd) {
                                                        setState(() {
                                                          message = '';
                                                        });
                                                      }
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.white,
                                                      fixedSize:
                                                          const Size(120, 4),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                    child: Text(
                                                      "arrived".tr,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.blue),
                                                    )),
                                              ),
                                          ],
                                        ),
                                      ),
                                      if(widget.user.status=="Ride Started")
                                      Padding(
                                        padding:  EdgeInsets.symmetric(vertical: Get.height*0.05),
                                        child: Row(
                                         mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          
                                          children: [
                                            Text("Ride Started Successfully",
                                             style:
                                                              GoogleFonts.poppins(
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  color:
                                                                      Colors.white),),
                                          ],
                                        ),
                                      ),

                                    //Here

                                    if (widget.user.status == "Ride Arrived")
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // if(chk)
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 80.0),
                                              child: ElevatedButton(
                                                  onPressed: () {
                                                    showDialog<void>(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return CupertinoAlertDialog(
                                                          title: Text(
                                                              'cancelride'.tr),
                                                          content: Column(
                                                            children: [
                                                              const SizedBox(
                                                                height: 30,
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        right:
                                                                            170.0),
                                                                child: Text(
                                                                  'remarks'.tr,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                          fontSize:
                                                                              14),
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 30,
                                                              ),
                                                              CupertinoTextField(
                                                                controller:
                                                                    _remarksController,
                                                                placeholder:
                                                                    'enterremarks'
                                                                        .tr,
                                                              ),
                                                            ],
                                                          ),
                                                          actions: <Widget>[
                                                            CupertinoButton(
                                                              color:
                                                                  Colors.blue,
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .all(
                                                                      Radius.circular(
                                                                          5.0)),
                                                              child: Text(
                                                                'ok'.tr,
                                                              ),
                                                              onPressed:
                                                                  () async {
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
                                                                  _remarksController
                                                                      .clear();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                } else {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(SnackBar(
                                                                          content:
                                                                              Text("pleaseenterremarks".tr)));
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8), // Set the border radius here
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "cancel".tr,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  )),
                                            ),

                                            const SizedBox(
                                              width: 0.01,
                                            ),
                                            // if(isRideEnd && !isRideCancel)
                                            if (widget.user.status ==
                                                "Ride Arrived")
                                              ElevatedButton(
                                                  onPressed: () async {
                                                    if (ispaymentselected ==
                                                            true ||
                                                        (widget.user.paymentstatusvalue ==
                                                                "1" &&
                                                            ispaymentselected ==
                                                                false)) {
                                                      ischeckin = true;
                                                      distance = 0.0;
                                                      time = 0.0;
                                                      if (ischeckin) {
                                                        widget.user.status =
                                                            'Booked';
                                                        isLoading = false;
                                                        setState(() {});
                                                        try {
                                                          await checkinapi();
                                                          // _polylines.clear();
                                                          //  _markers.remove(0);
                                                          // await callback();
                                                          await getsampleapi();
                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                        } catch (e) {
                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                        }

                                                        setState(() {
                                                          // message='Checkin Successfully';
                                                        });
                                                      }
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(SnackBar(
                                                              content: Text(
                                                                  "pleaseselectpaymentmethod"
                                                                      .tr)));
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "checkin".tr,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue),
                                                  )),
                                          ],
                                        ),
                                      ),

                                    if (widget.user.status == "Booked")
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          // if(chk)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 0),
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  showDialog<void>(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return CupertinoAlertDialog(
                                                        title: Text(
                                                            'cancelride'.tr),
                                                        content: Column(
                                                          children: [
                                                            const SizedBox(
                                                              height: 30,
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                          170.0),
                                                              child: Text(
                                                                'Remarks',
                                                                style: GoogleFonts
                                                                    .poppins(
                                                                        fontSize:
                                                                            14),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 30,
                                                            ),
                                                            CupertinoTextField(
                                                              controller:
                                                                  _remarksController,
                                                              placeholder:
                                                                  'enterremarks'
                                                                      .tr,
                                                            ),
                                                          ],
                                                        ),
                                                        actions: <Widget>[
                                                          CupertinoButton(
                                                            color: Colors.blue,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                                    Radius.circular(
                                                                        5.0)),
                                                            child: Text(
                                                              'ok'.tr,
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              if (_remarksController
                                                                  .text
                                                                  .isNotEmpty) {
                                                                chk = false;
                                                                String remarks =
                                                                    _remarksController
                                                                        .text;
                                                                isRideCancel =
                                                                    true;
                                                                if (isRideCancel) {
                                                                  setState(() {
                                                                    message =
                                                                        'Ride Cancel successfully!';
                                                                  });
                                                                }
                                                                await CancelRide(
                                                                    widget.user,
                                                                    remarks);
                                                                isRideCanceled =
                                                                    true;
                                                                _remarksController
                                                                    .clear();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              } else {
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(SnackBar(
                                                                        content:
                                                                            Text("pleaseenterremarks".tr)));
                                                              }
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  fixedSize: const Size(140, 4),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8), // Set the border radius here
                                                  ),
                                                ),
                                                child: Text(
                                                  "cancel".tr,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                )),
                                          ),
                                          const SizedBox(
                                            width: 0.01,
                                          ),
                                          // if(!isRideEnd && !isRideCancel)
                                          if (widget.user.status == "Booked")
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: ElevatedButton(
                                                  onPressed: () async {
                                                    // await _showarrivedDialog();

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
                                                    if (collectionstatus == 1 ||
                                                        ischeckin == true) {
                                                      setState(() {
                                                        message = '';
                                                        widget.user.status =
                                                            "Sample Collected";
                                                      });
                                                    }
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    fixedSize:
                                                        const Size(150, 4),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    "samplecollected".tr,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.blue),
                                                  )),
                                            ),
                                        ],
                                      ),
                                        SizedBox(
                                      height: Get.height * 0.05,
                                    ),
                                       if (widget.user.status == "Booked")
                                      Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              
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
                                              "$totalAppointmentPrice ",
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
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
                                                "${widget.user.paymentstatusname ?? " Unpaid"} ",
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

                                    if (widget.user.status == "Ride Arrived")
                                      InkWell(
                                        onTap: () async {
                                          Selectpayment = null;
                                          payments.clear();
                                          await paymentapi();
                                          setState(() {});
                                        },
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.84,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.072,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.28,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05),
                                            child: widget.user
                                                        .paymentstatusvalue !=
                                                    "1"
                                                ? Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 0.5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                      color: Colors.white,
                                                    ),
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                    child:
                                                        DropdownButtonFormField(
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                      value: Selectpayment,
                                                      hint: Text(
                                                          'paymentmethod'.tr,
                                                          textAlign:
                                                              TextAlign.center),
                                                      items: payments.map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (PaymentMethod val) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: val.name,
                                                          child: Text(val.name
                                                              .toString()),
                                                        );
                                                      }).toList(),
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                      ),
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          Selectpayment =
                                                              newValue;
                                                          ispaymentselected =
                                                              true;
                                                          print(newValue);
                                                        });
                                                      },
                                                      alignment:
                                                          Alignment.center,
                                                    ),
                                                  )
                                                : const SizedBox.shrink(),
                                          ),
                                        ),
                                      ),
                                    if (widget.user.status == "Ride Arrived")
                                      SizedBox(
                                          child:
                                              widget.user.paymentstatusvalue !=
                                                      "1"
                                                  ? Text(
                                                      "discount".tr,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  : const SizedBox.shrink()),
                                    if (widget.user.status == "Ride Arrived")
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            widget.user.paymentstatusvalue !=
                                                    "1"
                                                ? Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'yes'.tr,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Obx(() => SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.07,
                                                            child: Radio(
                                                              value: 'yes'.tr,
                                                              groupValue:
                                                                  _selectedOption
                                                                      .value, // Access value property
                                                              fillColor: MaterialStateColor
                                                                  .resolveWith(
                                                                      (states) =>
                                                                          Colors
                                                                              .white),
                                                              onChanged:
                                                                  (value) {
                                                                _selectedOption
                                                                        .value =
                                                                    value!; // Update _selectedOption value
                                                              },
                                                            ),
                                                          )),
                                                      Obx(() => Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                'no'.tr,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              SizedBox(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.07,
                                                                child: Radio(
                                                                  value:
                                                                      'no'.tr,
                                                                  groupValue:
                                                                      _selectedOption
                                                                          .value,
                                                                  fillColor: MaterialStateColor.resolveWith(
                                                                      (states) =>
                                                                          Colors
                                                                              .white),
                                                                  onChanged:
                                                                      (value) {
                                                                    discount =
                                                                        TextEditingController();
                                                                    dsct =
                                                                        "0.0";
                                                                    setState(
                                                                        () {});
                                                                    _selectedOption
                                                                            .value =
                                                                        value!;
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          )),
                                                    ],
                                                  )
                                                : const SizedBox.shrink(),
                                            Obx(
                                              () => _selectedOption == 'yes'.tr
                                                  ? Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .black,
                                                                width: 0.5),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            color: Colors.white,
                                                          ),
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.33,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.06,
                                                          child:
                                                              DropdownButtonFormField(
                                                            decoration:
                                                                const InputDecoration(
                                                              contentPadding:
                                                                  EdgeInsets.only(
                                                                      bottom:
                                                                          10),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                            ),
                                                            value:
                                                                dropdownvalue,
                                                            items: item1.map(
                                                                (String items) {
                                                              return DropdownMenuItem(
                                                                value: items,
                                                                child: Center(
                                                                  child: Text(
                                                                    "  $items",
                                                                    //  textAlign: AlignmentDirectional.topCenter,
                                                                  ),
                                                                ),
                                                              );
                                                            }).toList(),
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12,
                                                            ),
                                                            onChanged: (String?
                                                                newValue) {
                                                              setState(() {
                                                                dropdownvalue =
                                                                    newValue!;
                                                              });
                                                            },
                                                            alignment: Alignment
                                                                .center,
                                                            elevation: 0,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.23,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.06,
                                                          child: TextFormField(
                                                            controller:
                                                                discount,
                                                            onChanged: (val) {
                                                              if (dropdownvalue ==
                                                                  "percentage"
                                                                      .tr) {
                                                                dsct = ((totalAppointmentPrice -
                                                                        ((totalAppointmentPrice /
                                                                                100) *
                                                                            int.parse(val))))
                                                                    .toString();
                                                              } else if (dropdownvalue !=
                                                                  "") {
                                                                dsct = (totalAppointmentPrice -
                                                                        int.parse(
                                                                            val))
                                                                    .toString();
                                                              }
                                                              setState(() {});
                                                            },
                                                            decoration:
                                                                InputDecoration(
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              hintText:
                                                                  dropdownvalue,
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderSide: const BorderSide(
                                                                    color: Colors
                                                                        .black),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.0),
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
                                                      ],
                                                    )
                                                  : const SizedBox(),
                                            )
                                          ],
                                        ),
                                      ),

                                    if (widget.user.status ==
                                        "Sample Collected")
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (selectedLabsName == null) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content:
                                                      Text('pleaseselect'.tr),
                                                ),
                                              );
                                            } else {
                                              isLoading = true;
                                              setState(() {});
                                              try {
                                                await InRouteapi();
                                                _getPolylinesWithLocation(
                                                    _currentLatLng,
                                                    LatLng(
                                                        double.parse(
                                                            _selectedlab!
                                                                .latitude
                                                                .toString()),
                                                        double.parse(
                                                            _selectedlab!
                                                                .longitude
                                                                .toString())));
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

                                              setState(() {
                                                //  message='';
                                                widget.user.status = "In Route";
                                              });
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            fixedSize: const Size(300, 4),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          child: Text(
                                            'inroutelab'.tr,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue),
                                          ),
                                        ),
                                      ),

                                    if (widget.user.status ==
                                        "Sample Collected")
                                      InkWell(
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
                                          _selectedlab = generic;
                                          selectedLabsName = null;
                                          if (generic != null &&
                                              generic != '') {
                                            SelectLab = generic.id;
                                            selectedLabsName =
                                                (generic.name == '')
                                                    ? null
                                                    : generic.name;

                                            setState(() {});
                                          }
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.055),
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.055,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 0.5),
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                                color: Colors.white,
                                              ),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.05,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        MediaQuery.of(context)
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
                                                          fontSize: 14,
                                                          color:
                                                              selectedLabsName !=
                                                                      null
                                                                  ? Colors.black
                                                                  : Colors.grey[
                                                                      700]),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_drop_down,
                                                      size: 25,
                                                      color: selectedLabsName !=
                                                              null
                                                          ? Colors.black
                                                          : Colors.grey[700],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    SizedBox(
                                      height: Get.height * 0.05,
                                    ),
                                     if (widget.user.status ==
                                        "Sample Collected")
                                      Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                              "$totalAppointmentPrice",
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    if (widget.user.status ==
                                        "Sample Collected")
                                      Center(
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
                                              "${widget.user.paymentstatusname ?? " Unpaid"} ",
                                              style: GoogleFonts.poppins(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                   

                                    if (widget.user.status == "In Route")
                                      Align(
                                        alignment: Alignment.bottomCenter,
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
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(msg!),
                                                ),
                                              );
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
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            fixedSize: const Size(300, 4),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          child: Text(
                                            'deliversample'.tr,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue),
                                          ),
                                        ),
                                      ),
                                    if (widget.user.status ==
                                        "Sample Delivered")
                                      ElevatedButton(
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
                                              builder: (BuildContext context) {
                                                return CupertinoAlertDialog(
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
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          'thankyou'.tr,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
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
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  5.0)),
                                                      child: Text(
                                                        'backhome'.tr,
                                                      ),
                                                      onPressed: () async {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Dashboard(
                                                                          empId:
                                                                              widget.empId,
                                                                          userName:
                                                                              userprofile?.fullName ?? "",
                                                                        )));
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            fixedSize: const Size(520, 4),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(
                                                  18), // Set the border radius here
                                            ),
                                          ),
                                          child: Text(
                                            "ridecompleted".tr,
                                            style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue),
                                          )),

                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    if (widget.user.status == "Ride Arrived")
                                      Obx(
                                        () => _selectedOption == 'yes'.tr
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                    Center(
                                                      child: SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.83,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.095,
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
                                                              filled: true,
                                                              fillColor:
                                                                  Colors.white,
                                                              hintText:
                                                                  'remarks'.tr,
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
                                                                            10.0),
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
                                                    ),
                                                  ])
                                            : const SizedBox(),
                                      ),
                                    if (widget.user.status == "Ride Arrived")
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
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
                                                "${widget.user.paymentstatusname ?? " Unpaid"} ",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          )),

                                    if (widget.user.status == "Ride Arrived")
                                     SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "amount".tr,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                              Text(
                                                "$totalAppointmentPrice ",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),

                                            ],
                                          )),
                                           if (widget.user.status == "Ride Arrived")
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "discount".tr,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                              Text(
                                                "${dsct ?? 0.0} ",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                            ],
                                          )),
                                    if (widget.user.status == "Ride Arrived")
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "totalamount".tr,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                              Text(
                                                "${dsct ?? totalAppointmentPrice} ",
                                                style: GoogleFonts.poppins(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                                textAlign: TextAlign.right,
                                              ),
                                            ],
                                          )),

                                    // if (widget.user.status ==
                                    //     "Sample Collected")
                                    //   SizedBox(
                                    //       width: MediaQuery.of(context)
                                    //               .size
                                    //               .width *
                                    //           1,
                                    //       child: Text(
                                    //         "Total Amount: $totalAppointmentPrice ",
                                    //         style: GoogleFonts.poppins(
                                    //           fontSize: 12,
                                    //           fontWeight: FontWeight.bold,
                                    //           color: Colors.white,
                                    //         ),
                                    //         textAlign: TextAlign.right,
                                    //       )),

                                    // Padding(
                                    //           padding: const EdgeInsets.only(top:30.0,left: 70),
                                    //           child: Text(message ?? '', style: GoogleFonts.poppins(fontSize: 18,fontWeight: FontWeight.normal,color: Colors.white)),
                                    // ),

                                    // SizedBox(
                                    //   height:
                                    //       MediaQuery.of(context).size.height *
                                    //           0.015,
                                    // ),
                                    //           SizedBox(
                                    // width: MediaQuery.of(context).size.width*1,

                                    // child: Text("Payment Status: Paid Online ",style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.bold,color: Colors.white,),textAlign: TextAlign.center,)),

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomButton(
                                          onPressed: () {
                                            FlutterPhoneDirectCaller.callNumber(
                                                widget.user.cellNumber
                                                    .toString());
                                          },
                                          title: "call".tr,
                                          radius: 20,
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          primcolor: Colors.blue,
                                          //    width: Get.width*0.4,
                                          // height: Get.height*0.088,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
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
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          primcolor: Colors.white,
                                          // width: Get.width*0.4,
                                          // height: Get.height*0.088,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )),
                  )
                ]))));
  }
}
