import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Models/cities_model.dart';
import 'package:flutter_riderapp/Models/countries_model.dart';
import 'package:flutter_riderapp/Models/genders_model.dart';
import 'package:flutter_riderapp/Models/marital_status.dart';
import 'package:flutter_riderapp/Models/patient_data.dart';
import 'package:flutter_riderapp/Models/person_title.dart';
import 'package:flutter_riderapp/Models/provinces_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditPatientController extends GetxController implements GetxService {
  bool ontap = false;

  List<MSData> maritalStatusList = [];
  MSData? selectedmaritalStatus = MSData();
  updatemaritalStatusList(List<MSData> mslist) {
    maritalStatusList = mslist;
    update();
  }

  updateselectedmaritalStatus(MSData maritalstatus) {
    selectedmaritalStatus = maritalstatus;
    update();
  }

  deleteSelectedmaritalStatus() {
    selectedmaritalStatus = null;
    update();
  }

  List<GendersData> genderList = [];
  GendersData? selectedgender = GendersData();
  updategenderList(List<GendersData> glist) {
    genderList = glist;
    update();
  }

  updateselectedgender(GendersData gender) {
    selectedgender = gender;
    update();
  }

  deleteSelectedgender() {
    selectedgender = null;
    update();
  }

  List<PTitle> personalTitleList = [];
  PTitle? selectedpersonalTitle = PTitle();
  updatepersonalTitleList(List<PTitle> plist) {
    personalTitleList = plist;
    update();
  }

  updateselectedpersonalTitle(PTitle p) {
    selectedpersonalTitle = p;
    update();
  }

  List<Countries> countriesList = [];
  Countries? selectedcountry = Countries();
  Countries? educationselectedCountry = Countries();
  updatecountriesList(List<Countries> clist) {
    countriesList = clist;
    update();
  }

  updateselectedCountry(Countries country) {
    selectedcountry = country;

    update();
  }

  List<Provinces> provinceList = [];
  Provinces? selectedprovince = Provinces();
  updateprovinceList(List<Provinces> plist) {
    provinceList = plist;
    update();
  }

  updateselectedprovince(Provinces province) {
    selectedprovince = province;
    update();
  }

  deleteSelectedprovince() {
    selectedprovince = null;
    update();
  }

  List<Cities> citiesList = [];
  Cities? selectedcity = Cities();
  updatecitiesList(List<Cities> clist) {
    citiesList = clist;
    update();
  }

  updateselectedcity(Cities city) {
    selectedcity = city;
    update();
  }

  deleteSelectedcity() {
    selectedcity = null;
    update();
  }

  static DateTime? arrival = DateTime.now();
  updatearrival(ardate) {
    arrival = ardate;
    update();
  }

  String? formattedArrival = arrival!.toIso8601String();
  RxString? formatearrival = DateFormat.yMMMd().format(arrival!).obs;
  Future<void> selectDateAndTime(
    BuildContext context,
    DateTime? date,
    RxString? formattedDate,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        confirmText: 'Ok',
        initialDate: date!,
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (pickedDate != null && pickedDate != date) {
      date = pickedDate;
      formattedDate!.value = DateFormat.yMMMd().format(date);
      formattedDate.value = DateFormat.yMMMd().format(date);
      final iso8601Format = DateFormat("yyyy-MM-dd'T'00:00:00");
      formattedArrival = iso8601Format.format(date);

      updatearrival(date);
      update();
    }
  }

  String selectedPatientId = "";
  UpdatePatientId(String pid) {
    selectedPatientId = pid;
    update();
  }

  late TextEditingController firstname;
  late TextEditingController middlename;
  late TextEditingController lastname;
  late TextEditingController phone;
  late TextEditingController email;
  late TextEditingController address;
  late TextEditingController nationalid;

  @override
  void onInit() {
    firstname = TextEditingController();
    middlename = TextEditingController();
    lastname = TextEditingController();
    phone = TextEditingController();
    email = TextEditingController();
    address = TextEditingController();
    nationalid = TextEditingController();
    super.onInit();
  }

  UpdateData(PatientData u) {
    firstname.text = u.firstName ?? "";
    middlename.text = u.middleName ?? "";
    lastname.text = u.lastName ?? "";
    phone.text = u.cellNumber ?? "";
    email.text = u.email ?? "";
    address.text = u.address ?? "";
    formattedArrival = u.dateOfBirth ?? "";
    String apiDateTime = u.dateOfBirth ?? "";
    formatearrival!.value = apiDateTime.split("T")[0];
    selectedgender?.name = u.gender ?? "";
    selectedgender?.id = u.genderId ?? "";
    selectedmaritalStatus?.name = u.maritalStatus ?? "";
    selectedmaritalStatus?.id = u.maritalStatusId ?? "";
    selectedcountry = Countries(
      id: u.countryId ?? "",
      name: u.country ?? "",
    );
    selectedprovince = Provinces(
      id: u.stateOrProvinceId ?? "",
      name: u.stateOrProvince ?? "",
    );
    selectedcity = Cities(
      id: u.cityId ?? "",
      name: u.city ?? "",
    );
    selectedpersonalTitle?.id = u.personTitleId ?? "";
    selectedpersonalTitle?.name = u.title ?? "";
    nationalid.text = u.cNICNumber ?? "";
    update();
  }

  static EditPatientController get i => Get.put(EditPatientController());
}
