import 'package:flutter_riderapp/Models/lab_packages/lab_packages_model.dart';
import 'package:flutter_riderapp/Models/labtest_home_model/labtest_home_model.dart';
import 'package:flutter_riderapp/controllers/labinvestigation_controller/lab_investigation_controller.dart';

class LabTestsModel {
  int? status;
  List<LabTests>? data;
  String? errorMessage;

  LabTestsModel({this.status, this.data, this.errorMessage});

  LabTestsModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <LabTests>[];
      json['Data'].forEach((v) {
        data!.add(LabTests.fromJson(v));
      });
    }
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['ErrorMessage'] = errorMessage;
    return data;
  }
}

class LabTests {
  String? labtestId;
  String? id;
  String? name;
  double? price;
  double? actualPrice;
  bool? isForSampleCollectionCharges;
  bool? isForAdditionalCharges;
  bool? isForUrgentCharges;
  bool? isAdditionalChargesForPassenger;
  bool? isForCovid;
  bool? isForAdditionalChargesForCovid;
  String? typeId;
  List<LabTestHome>? dTOlabGroupDetail;

  LabTests({
    this.id,
    this.labtestId,
    this.name,
    this.price,
    this.actualPrice,
    this.isForSampleCollectionCharges,
    this.isForAdditionalCharges,
    this.isForUrgentCharges,
    this.isAdditionalChargesForPassenger,
    this.isForCovid,
    this.isForAdditionalChargesForCovid,
    this.dTOlabGroupDetail,
  });

  LabTests.fromJson(Map<String, dynamic> json) {
    typeId = typbitselection();
    id = json['Id'];
    labtestId = json['LabTestId'];
    name = json['Name'];
    price = json['Price'];
    actualPrice = json['ActualPrice'];
    isForSampleCollectionCharges = json['IsForSampleCollectionCharges'];
    isForAdditionalCharges = json['IsForAdditionalCharges'];
    isForUrgentCharges = json['IsForUrgentCharges'];
    isAdditionalChargesForPassenger = json['IsAdditionalChargesForPassenger'];
    isForCovid = json['IsForCovid'];
    isForAdditionalChargesForCovid = json['IsForAdditionalChargesForCovid'];
    if (json['LabTests'] != null) {
      dTOlabGroupDetail = <LabTestHome>[];
      json['LabTests'].forEach((v) {
        dTOlabGroupDetail!.add(LabTestHome.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TypeBit'] = typeId;
    data['Id'] = id;
    data['LabTestId'] = id;
    data['Name'] = name;
    data['Price'] = price;
    data['ActualPrice'] = actualPrice;
    data['IsForSampleCollectionCharges'] = isForSampleCollectionCharges;
    data['IsForAdditionalCharges'] = isForAdditionalCharges;
    data['IsForUrgentCharges'] = isForUrgentCharges;
    data['IsAdditionalChargesForPassenger'] = isAdditionalChargesForPassenger;
    data['IsForCovid'] = isForCovid;
    data['IsForAdditionalChargesForCovid'] = isForAdditionalChargesForCovid;
    if (dTOlabGroupDetail != null) {
      data['LabTests'] = dTOlabGroupDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

String typbitselection() {
  var cont = LabInvestigationController.i;
  if (cont.selectedalue1 == 25) {
    return "25";
  } else if (cont.selectedalue1 == 26) {
    return "26";
  } else if (cont.selectedalue1 == 27) {
    return "27";
  } else if (cont.selectedalue1 == 28) {
    return "28";
  } else {
    return '29';
  }
}
