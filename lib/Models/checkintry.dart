// ignore_for_file: camel_case_types

class checkintry {
  List<PatientCheckIn>? patientCheckIn;
  String? paymentNo;
  String? doctorCheckInType;
  List<PatientServicelist>? patientServicelist;
  String? branchLocationIds;
  String? userId;

  checkintry(
      {this.patientCheckIn,
      this.paymentNo,
      this.doctorCheckInType,
      this.patientServicelist,
      this.branchLocationIds,
      this.userId});

  checkintry.fromJson(Map<String, dynamic> json) {
    if (json['PatientCheckIn'] != null) {
      patientCheckIn = <PatientCheckIn>[];
      json['PatientCheckIn'].forEach((v) {
        patientCheckIn!.add(PatientCheckIn.fromJson(v));
      });
    }
    paymentNo = json['PaymentNo'];
    doctorCheckInType = json['DoctorCheckInType'];
    if (json['patientServicelist'] != null) {
      patientServicelist = <PatientServicelist>[];
      json['patientServicelist'].forEach((v) {
        patientServicelist!.add(PatientServicelist.fromJson(v));
      });
    }
    branchLocationIds = json['BranchLocationIds'];
    userId = json['UserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (patientCheckIn != null) {
      data['PatientCheckIn'] = patientCheckIn!.map((v) => v.toJson()).toList();
    }
    data['PaymentNo'] = paymentNo;
    data['DoctorCheckInType'] = doctorCheckInType;
    if (patientServicelist != null) {
      data['patientServicelist'] =
          patientServicelist!.map((v) => v.toJson()).toList();
    }
    data['BranchLocationIds'] = branchLocationIds;
    data['UserId'] = userId;
    return data;
  }
}

class PatientCheckIn {
  String? patientId;
  String? checkInTypeId;

  PatientCheckIn({this.patientId, this.checkInTypeId});

  PatientCheckIn.fromJson(Map<String, dynamic> json) {
    patientId = json['PatientId'];
    checkInTypeId = json['CheckInTypeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientId'] = patientId;
    data['CheckInTypeId'] = checkInTypeId;
    return data;
  }
}

class PatientServicelist {
  String? subServiceId;
  String? charges;
  String? typeBit;
  dynamic discountType;
  dynamic discountRate;
  String? totalCharges;
  int? paidAmount;
  int? isUrgent;
  String? executionDateTime;
  dynamic urgentDateTime;
  int? governmentCharges;
  int? subServiceCount;
  int? preference;
  bool? isAutoNumberGenerationEnabled;
  String? specimenName;
  dynamic vatpercentage;
  dynamic vatamount;

  PatientServicelist(
      {this.subServiceId,
      this.charges,
      this.typeBit,
      this.discountType,
      this.discountRate,
      this.totalCharges,
      this.paidAmount,
      this.isUrgent,
      this.executionDateTime,
      this.urgentDateTime,
      this.governmentCharges,
      this.subServiceCount,
      this.preference,
      this.isAutoNumberGenerationEnabled,
      this.specimenName,
      this.vatpercentage,
      this.vatamount});

  PatientServicelist.fromJson(Map<String, dynamic> json) {
    subServiceId = json['SubServiceId'];
    charges = json['Charges'];
    typeBit = json['TypeBit'];
    discountType = json['DiscountType'];
    discountRate = json['DiscountRate'];
    totalCharges = json['TotalCharges'];
    paidAmount = json['PaidAmount'];
    isUrgent = json['IsUrgent'];
    executionDateTime = json['ExecutionDateTime'];
    urgentDateTime = json['UrgentDateTime'];
    governmentCharges = json['GovernmentCharges'];
    subServiceCount = json['SubServiceCount'];
    preference = json['Preference'];
    isAutoNumberGenerationEnabled = json['IsAutoNumberGenerationEnabled'];
    specimenName = json['SpecimenName'];
    vatpercentage = json['VATPercentage'];
    vatamount = json['VATAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SubServiceId'] = subServiceId;
    data['Charges'] = charges;
    data['TypeBit'] = typeBit;
    data['DiscountType'] = discountType;
    data['DiscountRate'] = discountRate;
    data['TotalCharges'] = totalCharges;
    data['PaidAmount'] = paidAmount;
    data['IsUrgent'] = isUrgent;
    data['ExecutionDateTime'] = executionDateTime;
    data['UrgentDateTime'] = urgentDateTime;
    data['GovernmentCharges'] = governmentCharges;
    data['SubServiceCount'] = subServiceCount;
    data['Preference'] = preference;
    data['IsAutoNumberGenerationEnabled'] = isAutoNumberGenerationEnabled;
    data['SpecimenName'] = specimenName;
    data['VATPercentage'] = vatpercentage;
    data['VATAmount'] = vatamount;
    return data;
  }
}
