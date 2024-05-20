// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/appointmentdetail.dart';
import 'package:flutter_riderapp/Models/diagnostic_center_model/diagnostic_center_model.dart';
import 'package:flutter_riderapp/Models/doctors_response_model/doctors_response_model.dart';
import 'package:flutter_riderapp/Models/lab_packages/lab_packages_model.dart';
import 'package:flutter_riderapp/Models/lab_test_model/lab_test_model.dart';
import 'package:flutter_riderapp/Models/labtest.dart';
import 'package:flutter_riderapp/Models/labtest_home_model/labtest_home_model.dart';
import 'package:flutter_riderapp/Models/payment_response/payment_response.dart';
import 'package:flutter_riderapp/Models/services_model/services_model.dart';
import 'package:flutter_riderapp/Models/slots_session_model/slots_session_model.dart';
import 'package:flutter_riderapp/Models/specielities_data_model/specielities_data_model.dart';
import 'package:flutter_riderapp/Repositeries/lab_investigation_repo/add_lab_investigation_repo.dart';
import 'package:flutter_riderapp/Repositeries/lab_investigation_repo/lab_investigation_repo.dart';
import 'package:flutter_riderapp/Widgets/Utils/toast+manager.dart';
import 'package:flutter_riderapp/controllers/packages_controller/packages_controller.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LabInvestigationController1 extends GetxController
    implements GetxService {
  int? _selectedValue;
  int? _selectedValue1 = 26;
  int? _selectedValue2 = 0;
  int? _selectedLabValue = 0;
  int _selectedStatusValue = 0;
  double finalsubtotal = 0.0;
  TextEditingController quantitycont = TextEditingController();
  TextEditingController discountamount = TextEditingController();

  int? get selectedalue1 => _selectedValue1;
  int? get selectedalue => _selectedValue;
  int? get selectedalue2 => _selectedValue2;
  int? get selectedLabValue => _selectedLabValue;
  int? get selectedstatusvalue => _selectedStatusValue;
  List<Slots> dianosticsslot = [];
  Slots? selectedslot;
  File? file;

  List<LabTestHome>? labtests = [];
  List<LabTestHome>? diagnostics = [];
  List<LabTests> labservices = [];
  List<Data> specialities = [];
  List<Labtest> selectedlabtestlist = [];

  List<LabTests> doctorconsultation = [];
  List<LabPackages>? labPackages = [];

  Data? doctorspeciality;
  static TimeOfDay selectedTime = TimeOfDay.now();
  static TimeOfDay selectedTimeto = TimeOfDay.now();
  TimeOfDay currentTime = TimeOfDay.now();
  String? formattedSelectedTime;
  String? formattedSelectedTimeto;
  bool _isloading = false;
  bool get isLoading => _isloading;

  LabTestHome? selectedLabtest;
  LabTests? selectedservice;
  LabTests? selectedspaciality;
  Data? selecteddata;
  LabPackages? selectedLabPackage;
  DateTime selectedDate = DateTime.now();
  late TextEditingController? description;
  List<apointmentdetail> appointments = [];

  List<LabTestHome> selectedLabTests = [];
  List<LabTests>? selectedservicelist = [];
  List<LabTests>? selectedconsultservice = [];
  Doctors? selectedDoctor;
  PaymentMethod? selectedPaymentMethod;
  String? selectedSubServiceName;
  PaymentMethod? selectedPaymentMethod1;
  PaymentMethod? selectedPaymentMethod2;
  String? prescribedBy = 'Self';
  String? ServicesBy = 'Nursing';
  String? Status = 'Offline';
  List<Diagnosticscenter> diagnosticscenter = [];
  // String? selecteddate;
  bool? _isServicesLoading = false;
  bool? get isServicesLoading => _isServicesLoading;

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  TextEditingController doctorname = TextEditingController();

  // updateselecteddate(String dt) {
  //   selecteddate = dt;
  //   update();
  // }
  String TypeValue = "Percentage";
  updatedistype(typevalue) {
    if (typevalue == 1 || typevalue == 2) {
      if (LabInvestigationController1.i.appointments.isNotEmpty) {
        if (typevalue == 1) {
          TypeValue = "Amount";
          LabInvestigationController1.i.appointments[0].discountType = "Amount";
        } else if (typevalue == 2) {
          TypeValue = "Percentage";
          LabInvestigationController1.i.appointments[0].discountType =
              "Percentage";
        }
      } else {
        print("No appointments available");
      }
    } else {
      print("Invalid typevalue. Typevalue must be 1 or 2.");
    }
  }

  updatediagnosticslots(List<Slots> slots) {
    dianosticsslot = slots;
    update();
  }

  updatediscount(dynamic value) {
    if (value != null) {
      discountamount.text = value.toString();
    } else {
      // If value is null, clear the text
      discountamount.clear();
    }
    update();
  }

  File? prescriptionreport;
  updateprescriptionreport(File x) {
    prescriptionreport = x;
    update();
  }

  updateDate(dynamic value) {
    if (value is String) {
      selectedDate = DateTime.parse(value);
    } else if (value is DateTime) {
      selectedDate = value;
    }
    update();
  }

  String date = "";
  String username = "";
  String time = "";
  String test = "";
  String Address = "";
  String appointment = "";
  String status1 = "";
  String patientid = "";
  String branchid = "";
  String patientstatusid = "";
  String visitno = "";
  String subsurviceid = "";
  String price = "";
  String discount1 = "";
  String paymentstatus = "";

  updateValues(
      sd, un, st, tst, addres, appt, s, pid, bid, psId, vNo, ssId, p, dis, ps) {
    date = sd;
    username = un;
    time = st;
    test = tst;
    Address = addres;
    appointment = appt;
    status1 = s;
    patientid = pid;
    branchid = bid;
    patientstatusid = psId;
    visitno = vNo;
    subsurviceid = ssId;
    price = p;
    discount1 = dis;
    paymentstatus = ps;

    update();
  }

  clearData() {
    LabInvestigationController1.i.selectedslot = null;
    LabInvestigationController1.i.diagnosticscenter = [];
    LabInvestigationController1.i.dianosticsslot = [];
    LabInvestigationController1.i.diagnostics = [];
    LabInvestigationController1.i.selectedLabtest = null;
    update();
  }

  // updateTime(String? value) {
  //   formattedSelectedTime = value;
  //   update();
  // }

  void addLabTest1({required LabTestHome labTest}) {
    selectedLabTests.add(labTest);
    update(); // Update the UI whenever tests are added/removed
  }

  updateselectedslot(Slots st) {
    selectedslot = st;
    update();
  }

  updatediagnosticscenter(List<Diagnosticscenter> dt) {
    diagnosticscenter = dt;
    update();
  }

  // getdiagnosticcenter(String id) {
  //   LabInvestigationRepo1.getDiagnosticCenter(id);
  // }
  var discount = 0.0;
  updateDiscount(String newDiscount) {
    discount = double.tryParse(newDiscount) ?? 0.0;
    update();
  }

  Future<int> updateSelectedIndex(int index) async {
    _selectedIndex = index;
    update();
    return _selectedIndex;
  }

//  Future<double> sumUpGrandTotal() async {
//     double grandTotal = totalSum ;

//     if (grandTotal == 0.0) {
//       return 0.0;
//     } else {
//       return grandTotal;
//     }
//   }
  dynamic grandprice = 0.0;

  updateGrandTotal(String typeValue, String totalprice,
      TextEditingController discountamount) {
    print("Total Price: $totalprice");
    print("Type Value: $typeValue");

    double totalPrice = double.tryParse(totalprice) ?? 0.0;
    double discount = double.tryParse(discountamount.text) ?? 0.0;

    if (typeValue == "Percentage") {
      double Discount = totalPrice * (discount / 100);
      grandprice = totalPrice - Discount;
    } else if (typeValue == "Amount") {
      grandprice = totalPrice - discount;
    }

    print("Grand Price: $grandprice");

    update();
  }

  dynamic grandprice1 = 0.0;

  updateGrandTotal1(String typeValue, String totalprice,
      TextEditingController discountamount) {
    print("Total Price: $totalprice");
    print("Type Value: $typeValue");

    double totalPrice = double.tryParse(totalprice) ?? 0.0;
    double discount = double.tryParse(discountamount.text) ?? 0.0;

    if (typeValue == "Percentage") {
      double Discount = totalPrice * (discount / 100);
      grandprice1 = totalPrice - Discount;
    } else if (typeValue == "Amount") {
      grandprice1 = totalPrice - discount;
    }

    print("Grand Price: $grandprice1");

    update();
  }

  clearpage() {
    discountamount.clear();
    grandprice = 0.0;
  }

  updateIsLoading(bool value) {
    _isloading = value;
    update();
  }

  updatefinalsubtotal(double d) {
    finalsubtotal = finalsubtotal + d;
    update();
  }

  updatefinalsubtotal1() {
    for (int i = 0; i < selectedLabTests.length; i++) {
      totalprice = selectedLabTests[i].actualPrice!;
    }

    update();
  }

  updateSelectedLab(int value) {
    _selectedLabValue = value;
    update();
  }

  updateSelectedStatus(int value) {
    _selectedStatusValue = value;
    update();
  }

  updatePrescribedBy(String prescriptionBy) {
    prescribedBy = prescriptionBy;
    update();
  }

  List<Map<String, dynamic>> radioOptions = [
    {'value': 26, 'labelText': 'Physiotherapy'},
    {'value': 25, 'labelText': 'Nursing'},
    {'value': 27, 'labelText': 'Caregiver'},
    {'value': 28, 'labelText': 'Respiratory Therapy'},
    {'value': 29, 'labelText': 'Dietitian'},
  ];

  swapList(List<Map<String, dynamic>> list) {
    radioOptions = list;
    update();
  }

  updateservicesprecription(String prescriptionBy) {
    ServicesBy = prescriptionBy;
    update();
  }

  updatestatus(String status) {
    Status = status;
    update();
  }

  formattedDate(String format) {
    try {
      DateTime dateOfBirth = DateTime.parse(format);

      String formattedDate = DateFormat('yyyy-MM-dd').format(dateOfBirth);

      return formattedDate;
    } catch (e) {
      return format;
    }
  }

// DateTime selectedDate = DateTime.now();
  updateselecteddate(date) {
    selectedDate = date;
    update();
  }

  Future<DateTime> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1990, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      return selectedDate;
    }
    return DateTime.now();
  }

  Future<DateTime> selectDate1(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate1,
      firstDate: DateTime(1990, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate1) {
      selectedDate1 = picked;
      return selectedDate1;
    }
    return DateTime.now();
  }

  DateTime selectedDate1 = DateTime.now();
  updateselecteddate1(date1) {
    selectedDate1 = date1;
    update();
  }

  // getDoctors() async {
  //   doctors = await LabInvestigationRepo1.getDoctors();

  //   update();
  // }
  updateDoctor(Doctors doctor) {
    selectedDoctor = doctor;
    log(selectedDoctor!.id.toString());
    update();
  }

  prescription() {
    if (_selectedValue == 0) {
      updatePrescribedBy('self'.tr);
    } else if (_selectedValue == 1) {
      updatePrescribedBy('doctor'.tr);
    } else {
      updatePrescribedBy('outdoorDoctor'.tr);
    }
  }

  Serivcesprecription() {
    if (_selectedValue1 == 25) {
      updateservicesprecription('Nursing');
    } else if (_selectedValue1 == 26) {
      updateservicesprecription('Physiotherapy');
    } else if (_selectedValue1 == 27) {
      updateservicesprecription('Caregiver');
    } else if (_selectedValue1 == 28) {
      updateservicesprecription('Respiratory Therapy');
    } else if (_selectedValue1 == 29) {
      updateservicesprecription('Dietitian');
    }
  }

  online() {
    if (_selectedValue2 == 0) {
      updatestatus('Offline');
    } else if (_selectedValue2 == 1) {
      updatestatus('Online');
    }
  }

  double totalSum = 0;
  updatequantity(quantity) {
    selectedLabtest!.quantity = quantity;
    update();
  }

  updatequantityprice() {
    dynamic price = selectedLabtest!.actualPrice!;
    dynamic quantity = int.parse(selectedLabtest!.quantity!);
    dynamic subtotal = price * quantity;
    selectedLabtest!.actualPrice = subtotal;
    update();
  }

  updatequantityprice1() {
    for (int i = 0; i < selectedLabTests.length; i++) {
      dynamic price = selectedLabTests[i].actualPrice!;

      dynamic subtotal = price * selectedLabTests[i].quantity;
      selectedLabTests[i].actualPrice = subtotal;
    }

    update();
  }

  double ttPrice = 0.0;
  calculateedittotal() {
    for (int i = 0;
        i < LabInvestigationController1.i.appointments.length;
        i++) {
      ttPrice += LabInvestigationController1.i.appointments[i].price;
    }
    update();
  }

  String name = "";

  void updatetestlist() {
    // Reset name
    name = "";

    for (int i = 0;
        i < LabInvestigationController1.i.appointments.length;
        i++) {
      // Add subServiceName to name
      name += LabInvestigationController1.i.appointments[i].subServiceName
          .toString();

      // Add comma if not the last item
      if (i < LabInvestigationController1.i.appointments.length - 1) {
        name += ", ";
      }
    }

    update();
  }

  clearnamelist() {
    name = "";
    update();
  }

  dynamic testprice;
  String? testname;
  int? testquantity;
  String? testid;
  String? testbranchlocationid;
  String? testappointmentno;
  addfunction() {
    selectedLabTests.clear();

    for (int i = 0; i < appointments.length; i++) {
      testname = appointments[i].subServiceName;
      testprice = appointments[i].price;
      testquantity = appointments[i].subServiceQuantity;
      testid = appointments[i].subServiceId;
      testbranchlocationid = appointments[i].branchLocationId;
      testappointmentno = appointments[i].appointmentNo;

      selectedLabTests.add(LabTestHome(
        name: testname,
        actualPrice: testprice,
        quantity: testquantity,
        id: testid,
        branchlocationid: testbranchlocationid,
        appointmentno: testappointmentno,
      ));
    }
    update();
  }

  double totalprice = 0.0;
  calculatetotal() {
    double tp = 0.0;
    // selectedLabTests.clear();
    try {
      for (int i = 0; i < selectedLabTests.length; i++) {
        tp += selectedLabTests[i].actualPrice!;
      }
      totalprice = tp;
      update();
    } catch (e) {}
  }

  double totalamount = 0.0;
  calculateamount() {
    double totalPrice = 0.0;
    totalamount = 0.0;
    // selectedLabTests.clear();
    try {
      for (int i = 0; i < appointments.length; i++) {
        totalPrice += appointments[i].price!;
      }
      totalamount = totalPrice;
      update();
    } catch (e) {}
  }

  calculategrandtotal() {}

  String removeQoutes(String text) {
    return text.replaceAll('"', '');
  }

  addLabTest() {
    log('add lab test');
    if (selectedLabTests.contains(selectedLabtest)) {
      ToastManager.showToast('Lab test already selected',
          bgColor: ColorManager.kblackColor);
    } else if (PackagesController.i.selectedLabPackages!.isNotEmpty) {
      ToastManager.showToast(
          'Cannot select individual tests when Package is Selected'.tr,
          bgColor: ColorManager.kblackColor);
    } else if (PackagesController.i.selectedLabPackages!.any((element) =>
        element.dTOPackageGroupDetail!
            .any((element) => element.id == selectedLabtest?.id))) {
      ToastManager.showToast('Lab test present'.tr,
          bgColor: ColorManager.kblackColor);
    } else {
      updatequantityprice();
      selectedLabTests.add(selectedLabtest!);
      log(selectedLabtest!.toJson().toString());
      totalSum = totalSum + selectedLabtest!.price;
      quantitycont.text = "1";
      calculatetotal();
    }
    update();
  }

  dynamic totaldiagnostic = 0;

  updatetotal() {
    totaldiagnostic = 0;
    update();
  }

  Future<String> returnPriceLabsAndPackages() async {
    var packageContr = PackagesController.i;
    var doubleSum = packageContr.totalPriceOfPackages();
    double sum = totalSum + doubleSum;

    if (sum == 0.0) {
      update();
      return '0.0';
    } else {
      update();
      totaldiagnostic = totaldiagnostic + sum;
      update();
      return sum.toStringAsFixed(1);
    }
  }

  Future<String> returnDiscountOfPackages() async {
    var packageContr = PackagesController.i;
    double doubleSum = packageContr.totalDiscountOfPackages();
    if (doubleSum == 0.0) {
      return '';
    } else {
      return doubleSum.toStringAsFixed(1);
    }
  }

  // double discount = 0.0;
  double finalTotal = 0.0;

  double totalSum1 = 0;
  addservices() {
    if (selectedservicelist!.contains(selectedservice!)) {
      ToastManager.showToast('servicealreadyselected'.tr,
          bgColor: ColorManager.kblackColor);
      log('here');
    } else {
      if (selectedservice?.actualPrice != null) {
        selectedservicelist!.add(selectedservice!);
        log(selectedservicelist.toString());
        totalSum1 = totalSum1 + selectedservice!.price!;
      }
    }
    update();
  }

  double totalSum2 = 0;
  addconsultservices() {
    if (selectedconsultservice!.contains(selectedspaciality!)) {
      ToastManager.showToast('servicealreadyselected'.tr,
          bgColor: ColorManager.kblackColor);
    } else {
      selectedconsultservice!.add(selectedspaciality!);
      totalSum2 = totalSum2 + selectedspaciality!.price!;
    }
    update();
  }

  removeLabTest(int index) {
    if (totalprice > 0.0) {
      totalprice = totalprice - selectedLabTests[index].actualPrice!;
      update();
    }
    selectedLabTests.removeAt(index);
    update();
  }

  removeserviceslist(int index) {
    if (totalSum1 > 0.0) {
      totalSum1 = totalSum1 - selectedservicelist![index].price!;
      update();
    }
    selectedservicelist!.removeAt(index);
    update();
  }

  removeconserviceslist(int index) {
    if (totalSum2 > 0.0) {
      totalSum2 = totalSum2 - selectedconsultservice![index].price!;
      update();
    }
    selectedconsultservice!.removeAt(index);
    update();
  }

  bool? _payButtonDisabled = true;
  bool? get payButtonDisabled => _payButtonDisabled;

  updatePayment(bool value) {
    _payButtonDisabled = value;
    update();
  }

  updatePaymentMethod(PaymentMethod method) {
    selectedPaymentMethod = method;
    if (selectedPaymentMethod?.paymentMethodValue == 5) {
      log('true');
    }
    update();
  }

  updatePaymentMethod1(PaymentMethod method) {
    selectedPaymentMethod1 = method;
    update();
  }

  updatePaymentMethod2(PaymentMethod method) {
    selectedPaymentMethod2 = method;
    update();
  }

  updateSelectedValue(int value) {
    _selectedValue = value;
    update();
  }

  updateSampleValue(int value) {}

  updateSelecteddoctor(int value) {
    _selectedValue1 = value;
    update();
  }

  updateSelectedservices(int value) {
    _selectedValue1 = value;
    selectedservicelist = [];
    ServicesBy = null;
    selectedPaymentMethod1 = null;
    totalSum1 = 0.0;
    selectedDate = DateTime.now();
    update();
  }

  updateSelectedstatus(int value) {
    _selectedValue2 = value;
    update();
  }

  updateSelectedDatae(DateTime date) {
    selectedDate = date;
    update();
  }

  updatePackages(List<LabPackages>? packages) {
    labPackages = packages;
    update();
  }

  updateSelectedLabPackage(LabPackages packages) {
    selectedLabPackage = packages;
    update();
  }

  bool isPackagesLoading = false;

  getAllPackages() async {
    isPackagesLoading = true;
    update();
    List<LabPackages> packages = await LabInvestigationRepo1().getPackages();
    updatePackages(packages);
    isPackagesLoading = false;
    update();
    return packages;

    // log('${labPackages?.length}');
  }

  // updateFormattedTime(String value) {
  //   formattedSelectedTime = value;
  //   update();
  // }

  updateFormattedTime1(String value) {
    if (value.isNotEmpty) {
      final DateTime time = DateFormat('HH:mm').parse(value);
      formattedSelectedTime = DateFormat.jm().format(time);
    } else {
      formattedSelectedTime = null;
    }

    update();
  }

  Future<void> selectTime(
    BuildContext context,
    TimeOfDay time,
    String? formattedTime,
  ) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: time,
        builder: (context, childWidget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 24-Hour format
                  alwaysUse24HourFormat: false),
              // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
              child: childWidget!);
        });

    if (pickedTime != null && pickedTime != time) {
      time = pickedTime;
      selectedTime = time;
      formattedTime = time.format(Get.context!);
      updateFormattedTime1(formattedTime);
      log(selectedTime.toString());
      update();
    }
  }

  updateFormattedTimeto(String value) {
    formattedSelectedTimeto = value;
    update();
  }

  Future<void> selectTimeto(
    BuildContext context,
    TimeOfDay time,
    String? formattedTimeto,
  ) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: time,
        builder: (context, childWidget) {
          return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  // Using 24-Hour format
                  alwaysUse24HourFormat: false),
              // If you want 12-Hour format, just change alwaysUse24HourFormat to false or remove all the builder argument
              child: childWidget!);
        });

    if (pickedTime != null && pickedTime != time) {
      time = pickedTime;
      selectedTimeto = time;
      formattedTimeto = time.format(Get.context!);
      updateFormattedTimeto(formattedTimeto);
      log(selectedTimeto.toString());
      update();
    }
  }

  getLabTests(pid) async {
    LabTestsModelHome result = await LabInvestigationRepo1.getLabTests(pid);
    labtests = result.data;
    log(labtests!.length.toString());
  }

  // getDiagnostics() async {
  //   LabTestsModelHome result = await LabInvestigationRepo1.getDiagnostics();
  //   diagnostics = result.data;
  //   log(labtests!.length.toString());
  // }

  updateIsServicesLoading(bool loading) {
    _isServicesLoading = loading;
    update();
  }

  getserviceslist() async {
    updateIsServicesLoading(true);
    labservices.clear();
    List<servicesmodel> result =
        await LabInvestigationRepo1.getLabservices(_selectedValue1!);
    // labservices = result.data??[];
    LabTestsModel results =
        await LabInvestigationRepo1.getservices(result[0].id, _selectedValue1!);
    labservices = results.data ?? [];
    log(result.toString());
    updateIsServicesLoading(false);
  }

  getstatus() async {
    List<servicesmodel> result =
        await LabInvestigationRepo1.getLabservices(_selectedValue2!);
    // labservices = result.data??[];
    LabTestsModel results =
        await LabInvestigationRepo1.getservices(result[0].id, _selectedValue2!);
    labservices = results.data ?? [];
    log(result.toString());
  }

  getspecialityserve() async {
    List<servicesmodel> result =
        await LabInvestigationRepo1.getspecialityservices();
    LabTestsModel results = await LabInvestigationRepo1.getconsultservices(
      result[0].id,
    );
    doctorconsultation = results.data ?? [];
    log(result.toString());
  }

  // getspeciality() async {
  //   Specialities result = await LabInvestigationRepo1.getspecialities();
  //   List<Data>? lst = result.data;
  //   specialities = lst ?? [];
  //   log(lst.toString());
  //   return lst;
  // }

  updatespeciality(Data? data) {
    doctorspeciality = data!;
    update();
  }

  updateservice(LabTests labservices) {
    selectedservice = labservices;
    log('selected lab Test ${labservices.name}');
    update();
  }

  //  updatedoctorconsult(Doctorconsult consult) {
  //   doctorcons = consult;
  //   log('selected consultation ${consult.name}');
  //   update();
  // }
  updateLabTest(LabTestHome labTest) {
    selectedLabtest = labTest;
    log('selected lab Test ${labTest.name}');
    update();
  }

  @override
  void onInit() {
    description = TextEditingController();

    super.onInit();
  }

  // initTime(BuildContext context) {
  //   formattedSelectedTime = selectedTime.format(context);
  //   log('$formattedSelectedTime');
  // }

  static LabInvestigationController1 get i =>
      Get.put(LabInvestigationController1());
}
