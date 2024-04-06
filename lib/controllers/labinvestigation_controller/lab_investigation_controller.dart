// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/diagnostic_center_model/diagnostic_center_model.dart';
import 'package:flutter_riderapp/Models/doctors_response_model/doctors_response_model.dart';
import 'package:flutter_riderapp/Models/lab_packages/lab_packages_model.dart';
import 'package:flutter_riderapp/Models/lab_test_model/lab_test_model.dart';
import 'package:flutter_riderapp/Models/labtest_home_model/labtest_home_model.dart';
import 'package:flutter_riderapp/Models/payment_response/payment_response.dart';
import 'package:flutter_riderapp/Models/services_model/services_model.dart';
import 'package:flutter_riderapp/Models/slots_session_model/slots_session_model.dart';
import 'package:flutter_riderapp/Models/specielities_data_model/specielities_data_model.dart';
import 'package:flutter_riderapp/Repositeries/lab_investigation_repo/lab_investigation_repo.dart';
import 'package:flutter_riderapp/Widgets/Utils/toast+manager.dart';
import 'package:flutter_riderapp/controllers/packages_controller/packages_controller.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LabInvestigationController extends GetxController implements GetxService {
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

  List<LabTestHome> selectedLabTests = [];
  List<LabTests>? selectedservicelist = [];
  List<LabTests>? selectedconsultservice = [];
  Doctors? selectedDoctor;
  PaymentMethod? selectedPaymentMethod;
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

  updatediagnosticslots(List<Slots> slots) {
    dianosticsslot = slots;
    update();
  }

  File? prescriptionreport;
  updateprescriptionreport(File x) {
    prescriptionreport = x;
    update();
  }

  clearData() {
    LabInvestigationController.i.selectedslot = null;
    LabInvestigationController.i.diagnosticscenter = [];
    LabInvestigationController.i.dianosticsslot = [];
    LabInvestigationController.i.diagnostics = [];
    LabInvestigationController.i.selectedLabtest = null;
    update();
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
  //   LabInvestigationRepo.getDiagnosticCenter(id);
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
  updateGrandTotal(String typeValue) {
    print("Total Price: $totalprice");
    // print("Discount Amount: $discountAmount");
    print("Type Value: $typeValue");

    // double totalPrice = double.tryParse(totalprice) ?? 0.0;
    // double discount = double.tryParse(discountAmount) ?? 0.0;

    if (typeValue == "Percentage") {
      double Discount = totalprice * (int.parse(discountamount.text) / 100);
      grandprice = totalprice - Discount;
    } else if (typeValue == "Amount") {
      grandprice = totalprice - int.parse(discountamount.text);
    }

    print("Grand Price: $grandprice");

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
  //   doctors = await LabInvestigationRepo.getDoctors();

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

  double totalprice = 0.0;

  calculatetotal() {
    double totalPrice = 0.0;
    try {
      for (int i = 0; i < selectedLabTests.length; i++) {
        // dynamic actualPrice =
        //     removeQoutes(selectedLabTests[i].actualPrice!.toString());
        totalPrice += selectedLabTests[i].actualPrice!;
      }
      totalprice = totalPrice;
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
      ToastManager.showToast('labtestalreadyselected'.tr,
          bgColor: ColorManager.kblackColor);
    } else if (PackagesController.i.selectedLabPackages!.isNotEmpty) {
      ToastManager.showToast(
          'Cannot select individual tests when Package is Selected'.tr,
          bgColor: ColorManager.kblackColor);
    } else if (PackagesController.i.selectedLabPackages!.any((element) =>
        element.dTOPackageGroupDetail!
            .any((element) => element.id == selectedLabtest?.id))) {
      ToastManager.showToast('labtestpresent'.tr,
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
    if (totalSum > 0.0) {
      totalSum = totalSum - selectedLabTests[index].price!;
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
    List<LabPackages> packages = await LabInvestigationRepo().getPackages();
    updatePackages(packages);
    isPackagesLoading = false;
    update();
    return packages;

    // log('${labPackages?.length}');
  }

  updateFormattedTime(String value) {
    formattedSelectedTime = value;
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
      updateFormattedTime(formattedTime);
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

  getLabTests() async {
    LabTestsModelHome result = await LabInvestigationRepo.getLabTests();
    labtests = result.data;
    log(labtests!.length.toString());
  }

  // getDiagnostics() async {
  //   LabTestsModelHome result = await LabInvestigationRepo.getDiagnostics();
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
        await LabInvestigationRepo.getLabservices(_selectedValue1!);
    // labservices = result.data??[];
    LabTestsModel results =
        await LabInvestigationRepo.getservices(result[0].id, _selectedValue1!);
    labservices = results.data ?? [];
    log(result.toString());
    updateIsServicesLoading(false);
  }

  getstatus() async {
    List<servicesmodel> result =
        await LabInvestigationRepo.getLabservices(_selectedValue2!);
    // labservices = result.data??[];
    LabTestsModel results =
        await LabInvestigationRepo.getservices(result[0].id, _selectedValue2!);
    labservices = results.data ?? [];
    log(result.toString());
  }

  getspecialityserve() async {
    List<servicesmodel> result =
        await LabInvestigationRepo.getspecialityservices();
    LabTestsModel results = await LabInvestigationRepo.getconsultservices(
      result[0].id,
    );
    doctorconsultation = results.data ?? [];
    log(result.toString());
  }

  // getspeciality() async {
  //   Specialities result = await LabInvestigationRepo.getspecialities();
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

  initTime(BuildContext context) {
    formattedSelectedTime = selectedTime.format(context);
    log('$formattedSelectedTime');
  }

  static LabInvestigationController get i =>
      Get.put(LabInvestigationController());
}
