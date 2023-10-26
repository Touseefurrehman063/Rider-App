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
        patientCheckIn!.add(new PatientCheckIn.fromJson(v));
      });
    }
    paymentNo = json['PaymentNo'];
    doctorCheckInType = json['DoctorCheckInType'];
    if (json['patientServicelist'] != null) {
      patientServicelist = <PatientServicelist>[];
      json['patientServicelist'].forEach((v) {
        patientServicelist!.add(new PatientServicelist.fromJson(v));
      });
    }
    branchLocationIds = json['BranchLocationIds'];
    userId = json['UserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patientCheckIn != null) {
      data['PatientCheckIn'] =
          this.patientCheckIn!.map((v) => v.toJson()).toList();
    }
    data['PaymentNo'] = this.paymentNo;
    data['DoctorCheckInType'] = this.doctorCheckInType;
    if (this.patientServicelist != null) {
      data['patientServicelist'] =
          this.patientServicelist!.map((v) => v.toJson()).toList();
    }
    data['BranchLocationIds'] = this.branchLocationIds;
    data['UserId'] = this.userId;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PatientId'] = this.patientId;
    data['CheckInTypeId'] = this.checkInTypeId;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SubServiceId'] = this.subServiceId;
    data['Charges'] = this.charges;
    data['TypeBit'] = this.typeBit;
    data['DiscountType'] = this.discountType;
    data['DiscountRate'] = this.discountRate;
    data['TotalCharges'] = this.totalCharges;
    data['PaidAmount'] = this.paidAmount;
    data['IsUrgent'] = this.isUrgent;
    data['ExecutionDateTime'] = this.executionDateTime;
    data['UrgentDateTime'] = this.urgentDateTime;
    data['GovernmentCharges'] = this.governmentCharges;
    data['SubServiceCount'] = this.subServiceCount;
    data['Preference'] = this.preference;
    data['IsAutoNumberGenerationEnabled'] = this.isAutoNumberGenerationEnabled;
    data['SpecimenName'] = this.specimenName;
    data['VATPercentage'] = this.vatpercentage;
    data['VATAmount'] = this.vatamount;
    return data;
  }
}
