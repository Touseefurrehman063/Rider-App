class checkintry {
  List<PatientCheckIn>? patientCheckIn;
  String? paymentNo;
  String? doctorCheckInType;
  String? isbooking;
  dynamic typebit;
  dynamic paymentmethodid;
  List<PatientServicelist>? patientServicelist;
  List<MiscellaneousServicesList>? miscellaneousserviceslist;
  String? branchLocationIds;
  String? userId;

  checkintry({
    this.patientCheckIn,
    this.paymentNo,
    this.doctorCheckInType,
    this.patientServicelist,
    this.branchLocationIds,
    this.userId,
    this.isbooking,
    this.typebit,
    this.paymentmethodid,
    this.miscellaneousserviceslist,
  });

  checkintry.fromJson(Map<String, dynamic> json) {
    if (json['PatientCheckIn'] != null) {
      patientCheckIn = <PatientCheckIn>[];
      json['PatientCheckIn'].forEach((v) {
        patientCheckIn!.add(PatientCheckIn.fromJson(v));
      });
    }
    paymentNo = json['PaymentNo'];
    doctorCheckInType = json['DoctorCheckInType'];
    isbooking = json['IsBookingHasTestWithoutSpecimenAndAutoNumber'];
    typebit = json['TypeBit'];
    paymentmethodid = json['PaymentMethodId'];
    if (json['patientServicelist'] != null) {
      patientServicelist = <PatientServicelist>[];
      json['patientServicelist'].forEach((v) {
        patientServicelist!.add(PatientServicelist.fromJson(v));
      });
    }
    if (json['MiscellaneousServicesList'] != null) {
      miscellaneousserviceslist = <MiscellaneousServicesList>[];
      json['MiscellaneousServicesList'].forEach((v) {
        miscellaneousserviceslist!.add(MiscellaneousServicesList.fromJson(v));
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
    data['IsBookingHasTestWithoutSpecimenAndAutoNumber'] = isbooking;
    data['TypeBit'] = typebit;
    data['PaymentMethodId'] = paymentmethodid;

    if (patientServicelist != null) {
      data['patientServicelist'] =
          patientServicelist!.map((v) => v.toJson()).toList();
    }

    if (miscellaneousserviceslist != null) {
      data['MiscellaneousServicesList'] =
          miscellaneousserviceslist!.map((v) => v.toJson()).toList();
    }
    data['BranchLocationIds'] = branchLocationIds;
    data['UserId'] = userId;
    return data;
  }
}

class PatientCheckIn {
  String? patientId;
  String? checkInTypeId;
  dynamic chargerate;
  dynamic paidamount;
  dynamic smssendto;
  dynamic isonline;
  String? patientserviceappointmentid;

  PatientCheckIn({this.patientId, this.checkInTypeId});

  PatientCheckIn.fromJson(Map<String, dynamic> json) {
    patientId = json['PatientId'];
    checkInTypeId = json['CheckInTypeId'];
    patientserviceappointmentid = json['PatientServiceAppointmentId'];
    chargerate = json['ChargeRate'];
    paidamount = json['PaidAmount'];
    smssendto = json['SMSSendTo'];
    isonline = json['IsOnline'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientId'] = patientId;
    data['CheckInTypeId'] = checkInTypeId;
    data['ChargeRate'] = chargerate;
    data['PaidAmount'] = paidamount;
    data['SMSSendTo'] = smssendto;
    data['IsOnline'] = isonline;
    data['PatientServiceAppointmentId'] = patientserviceappointmentid;
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

class MiscellaneousServicesList {
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

  MiscellaneousServicesList(
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

  MiscellaneousServicesList.fromJson(Map<String, dynamic> json) {
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
