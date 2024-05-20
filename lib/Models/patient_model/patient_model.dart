class PatientModel {
  int? status;
  List<Data>? data;
  int? totalRecord;
  int? filterRecord;

  PatientModel({this.status, this.data, this.totalRecord, this.filterRecord});

  PatientModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['Data'] != null) {
      data = <Data>[];
      json['Data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    totalRecord = json['TotalRecord'];
    filterRecord = json['FilterRecord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['TotalRecord'] = totalRecord;
    data['FilterRecord'] = filterRecord;
    return data;
  }
}

class Data {
  String? id;
  dynamic patientId;
  String? familyMemberPatientId;
  dynamic mRNo;
  String? gender;
  String? age;
  dynamic cellNumber;
  dynamic name;
  String? identityNo;
  String? createdOn;
  String? modifiedOn;
  dynamic referenceId;
  String? deathCertificateId;
  dynamic familyMember;
  dynamic action;
  int? patientTypesHtmlValue;
  dynamic panelOrganizationName;
  dynamic panelDepartment;
  int? balanceAmount;
  int? dependentStatus;
  dynamic religionId;
  bool? isPatientInMonitory;
  int? infoCertificationType;
  int? panelType;
  dynamic drivingLicenseNo;
  dynamic insuranceNo;
  dynamic panelEmployeeNo;
  dynamic address;
  dynamic latitude;
  dynamic longitude;

  Data(
      {this.id,
      this.patientId,
      this.familyMemberPatientId,
      this.mRNo,
      this.gender,
      this.age,
      this.cellNumber,
      this.name,
      this.identityNo,
      this.createdOn,
      this.modifiedOn,
      this.referenceId,
      this.deathCertificateId,
      this.familyMember,
      this.action,
      this.patientTypesHtmlValue,
      this.panelOrganizationName,
      this.panelDepartment,
      this.balanceAmount,
      this.dependentStatus,
      this.religionId,
      this.isPatientInMonitory,
      this.infoCertificationType,
      this.panelType,
      this.drivingLicenseNo,
      this.insuranceNo,
      this.panelEmployeeNo,
      this.address,
      this.latitude,
      this.longitude});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    patientId = json['PatientId'];
    familyMemberPatientId = json['FamilyMemberPatientId'];
    mRNo = json['MRNo'];
    gender = json['Gender'];
    age = json['Age'];
    cellNumber = json['CellNumber'];
    name = json['Name'];
    identityNo = json['IdentityNo'];
    createdOn = json['CreatedOn'];
    modifiedOn = json['ModifiedOn'];
    referenceId = json['ReferenceId'];
    deathCertificateId = json['DeathCertificateId'];
    familyMember = json['FamilyMember'];
    action = json['Action'];
    patientTypesHtmlValue = json['PatientTypesHtmlValue'];
    panelOrganizationName = json['PanelOrganizationName'];
    panelDepartment = json['PanelDepartment'];
    balanceAmount = json['BalanceAmount'];
    dependentStatus = json['DependentStatus'];
    religionId = json['ReligionId'];
    isPatientInMonitory = json['IsPatientInMonitory'];
    infoCertificationType = json['InfoCertificationType'];
    panelType = json['PanelType'];
    drivingLicenseNo = json['DrivingLicenseNo'];
    insuranceNo = json['InsuranceNo'];
    panelEmployeeNo = json['PanelEmployeeNo'];
    address = json['Address'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['PatientId'] = patientId;
    data['FamilyMemberPatientId'] = familyMemberPatientId;
    data['MRNo'] = mRNo;
    data['Gender'] = gender;
    data['Age'] = age;
    data['CellNumber'] = cellNumber;
    data['Name'] = name;
    data['IdentityNo'] = identityNo;
    data['CreatedOn'] = createdOn;
    data['ModifiedOn'] = modifiedOn;
    data['ReferenceId'] = referenceId;
    data['DeathCertificateId'] = deathCertificateId;
    data['FamilyMember'] = familyMember;
    data['Action'] = action;
    data['PatientTypesHtmlValue'] = patientTypesHtmlValue;
    data['PanelOrganizationName'] = panelOrganizationName;
    data['PanelDepartment'] = panelDepartment;
    data['BalanceAmount'] = balanceAmount;
    data['DependentStatus'] = dependentStatus;
    data['ReligionId'] = religionId;
    data['IsPatientInMonitory'] = isPatientInMonitory;
    data['InfoCertificationType'] = infoCertificationType;
    data['PanelType'] = panelType;
    data['DrivingLicenseNo'] = drivingLicenseNo;
    data['InsuranceNo'] = insuranceNo;
    data['PanelEmployeeNo'] = panelEmployeeNo;
    data['Address'] = address;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    return data;
  }
}
