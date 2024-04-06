import 'dart:convert';
import 'package:flutter_riderapp/Models/cities_model.dart';
import 'package:flutter_riderapp/Models/countries_model.dart';
import 'package:flutter_riderapp/Models/genders_model.dart';
import 'package:flutter_riderapp/Models/marital_status.dart';
import 'package:flutter_riderapp/Models/patient_data.dart';
import 'package:flutter_riderapp/Models/person_title.dart';
import 'package:flutter_riderapp/Models/provinces_model.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/controllers/edit_patient_controller.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthRepo {
  Future<String> updatePatientProfile(pid) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {
      "PatientId": pid,
      "PersonTitleId": EditPatientController.i.selectedpersonalTitle?.id,
      "FirstName": EditPatientController.i.firstname.text,
      "MiddleName": EditPatientController.i.middlename.text,
      "LastName": EditPatientController.i.lastname.text,
      "DateOfBirth": EditPatientController.i.formattedArrival,
      "Address": EditPatientController.i.address.text,
      "CellNumber": EditPatientController.i.phone.text,
      "Email": EditPatientController.i.email.text,
      "GenderId": EditPatientController.i.selectedgender?.id,
      "MaritalStatusId": EditPatientController.i.selectedmaritalStatus?.id,
      "CountryId": EditPatientController.i.selectedcountry?.id,
      "StateOrProvinceId": EditPatientController.i.selectedprovince?.id,
      "CityId": EditPatientController.i.selectedcity?.id,
    };
    try {
      var response = await http.post(
          Uri.parse("$ip2/api/account/UpdateProfile"),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        var status = responseData['Status'];
        var msg = responseData['ErrorMessage'];
        if (status == 1) {
          if (msg == "Success") {
            Fluttertoast.showToast(
                msg: msg,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: ColorManager.kPrimaryColor,
                textColor: ColorManager.kWhiteColor,
                fontSize: 14.0);
            Get.back();
            Get.back();
            return 'true';
          }
        } else if (status == -5 || status == 0) {
          Fluttertoast.showToast(
              msg: msg,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
        } else {
          Fluttertoast.showToast(
              msg: 'Something went wrong',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: ColorManager.kRedColor,
              textColor: ColorManager.kWhiteColor,
              fontSize: 14.0);
          return 'false';
        }
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);
      return 'false';
    }
    Fluttertoast.showToast(
        msg: 'Something went wrong',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManager.kRedColor,
        textColor: ColorManager.kWhiteColor,
        fontSize: 14.0);
    return 'false';
  }

  Future<bool> getPatientBasicInfo(String patientId) async {
    var headers = {
      'Content-Type': 'application/json',
    };

    var body = {"PatientId": patientId};

    try {
      var response = await http.post(
          Uri.parse('$ip2/api/account/GetUpdateProfileDetail'),
          body: jsonEncode(body),
          headers: headers);
      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        EditPatientController.i.UpdateData(PatientData.fromJson(responseData));
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: ColorManager.kRedColor,
          textColor: ColorManager.kWhiteColor,
          fontSize: 14.0);

      return false;
    }
    return false;
  }

  Future<List<PTitle>> getPersonalTitle() async {
    String url = '$ip2/api/ddl/GetPersonTitle';
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    // ProfileController.i.updateval(false);
    // ProfileController.i.updateaddval(false);
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);

      Iterable data = jsonData['Data']; //Data

      List<PTitle> ptitleList =
          data.map((json) => PTitle.fromJson(json)).toList();
      return ptitleList;
    } else {
      throw Exception('Failed to fetch title details');
    }
  }

  Future<List<GendersData>> getGendersList() async {
    String url = '$ip2/api/ddl/GetGenders';
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Data']; //Data
      List<GendersData> gendersList =
          data.map((json) => GendersData.fromJson(json)).toList();

      return gendersList;
    } else {
      throw Exception('Failed to fetch genders details');
    }
  }

  Future<List<MSData>> getMaritalStatus() async {
    String url = '$ip2/api/ddl/GetMaritalStatuses';
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Data']; //Data

      List<MSData> maritalstatusList =
          data.map((json) => MSData.fromJson(json)).toList();
      return maritalstatusList;
    } else {
      throw Exception('Failed to fetch marital status details');
    }
  }

  Future<List<Countries>> getCountries() async {
    String url = '$ip/api/ddl/GetCountries';
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{});

    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Data']; //Data
      List<Countries> countriesList =
          data.map((json) => Countries.fromJson(json)).toList();

      return countriesList;
    } else {
      throw Exception('Failed to fetch countries details');
    }
  }

  Future<List<Provinces>> getProvinces(String countryId) async {
    String url = '$ip/api/ddl/GetStateOrProvinces';
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "CountryId": countryId,
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Data']; //Data
      List<Provinces> provincesList =
          data.map((json) => Provinces.fromJson(json)).toList();

      return provincesList;
    } else {
      throw Exception('Failed to fetch provinces details');
    }
  }

  Future<List<Cities>> getCities(String provinceId) async {
    String url = '$ip/api/ddl/GetCities';
    Uri uri = Uri.parse(url);
    var body = jsonEncode(<String, dynamic>{
      "StateORProvinceId": provinceId,
    });
    var response = await http.post(uri,
        body: body,
        headers: <String, String>{'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      Iterable data = jsonData['Data']; //Data
      List<Cities> citiesList =
          data.map((json) => Cities.fromJson(json)).toList();

      return citiesList;
    } else {
      throw Exception('Failed to fetch cities details');
    }
  }
}
