// ignore_for_file: file_names

class CheckInModel {
  List<PatientCheckIn>? patientCheckIn;
  String? patientServiceAppointmentId;
  String? paymentNo;
  String? doctorCheckInType;
  List<PatientServicelist>? patientServicelist;
  List<dynamic>? miscellaneousServicesList;
  String? discountReference;
  String? discountRemarks;
  String? checkInBranchLocationId;
  String? sMSSendTo;
  String? airlineId;
  String? flightNo;
  String? flightDate;
  String? flightDestinationId;
  String? flightDestinationName;
  String? airportId;
  String? oEPRefNo;
  String? nationalityId;
  String? oEPId;
  String? jobTradeId;
  String? agentId;
  String? countryToVisitId;
  dynamic referenceType;
  String? referenceNumber;
  String? bookingRemarks;
  bool? includeFitToTravelCertificate;
  String? validityHours;
  String? vIPBooking;
  String? sampleCollectionSticker;
  String? sampleReceivedFrom;
  String? sampleReceivedFromRemarks;
  String? patientLabBookingSlipAttachmentPath;
  String? gCCSlipNo;
  dynamic sampleReceivedFromPanelOrganizationId;
  dynamic discountReferenceId;
  bool? isBookingHasTestWithoutSpecimenAndAutoNumber;
  bool? canRebookTest;
  String? paymentMethodId;
  dynamic prescribedById;
  String? paymentMethodRemarks;
  String? outDoorDoctor;
  bool? isCreditPaymentPending;
  dynamic creditPaymentRemarks;
  dynamic creditPaymentType;
  int? creditPaymentAmount;
  bool? isReferralPanelBooking;
  dynamic referralPanelBookingRemarks;
  String? advanceSecurityPaidAmount;
  String? patientPassportImagePath;
  String? patientPicturePath;
  String? passportNumber;
  String? bookingConcentFormAttachment;
  String? branchLocationIds;
  String? userId;
  String? workingSessionId;
  bool? isOPDQueueSysEnabled;
  bool? isLabQueueSysEnabled;
  bool? isPreRegTokenEnabled;

  CheckInModel(
      {this.patientCheckIn,
      this.patientServiceAppointmentId,
      this.paymentNo,
      this.doctorCheckInType,
      this.patientServicelist,
      this.miscellaneousServicesList,
      this.discountReference,
      this.discountRemarks,
      this.checkInBranchLocationId,
      this.sMSSendTo,
      this.airlineId,
      this.flightNo,
      this.flightDate,
      this.flightDestinationId,
      this.flightDestinationName,
      this.airportId,
      this.oEPRefNo,
      this.nationalityId,
      this.oEPId,
      this.jobTradeId,
      this.agentId,
      this.countryToVisitId,
      this.referenceType,
      this.referenceNumber,
      this.bookingRemarks,
      this.includeFitToTravelCertificate,
      this.validityHours,
      this.vIPBooking,
      this.sampleCollectionSticker,
      this.sampleReceivedFrom,
      this.sampleReceivedFromRemarks,
      this.patientLabBookingSlipAttachmentPath,
      this.gCCSlipNo,
      this.sampleReceivedFromPanelOrganizationId,
      this.discountReferenceId,
      this.isBookingHasTestWithoutSpecimenAndAutoNumber,
      this.canRebookTest,
      this.paymentMethodId,
      this.prescribedById,
      this.paymentMethodRemarks,
      this.outDoorDoctor,
      this.isCreditPaymentPending,
      this.creditPaymentRemarks,
      this.creditPaymentType,
      this.creditPaymentAmount,
      this.isReferralPanelBooking,
      this.referralPanelBookingRemarks,
      this.advanceSecurityPaidAmount,
      this.patientPassportImagePath,
      this.patientPicturePath,
      this.passportNumber,
      this.bookingConcentFormAttachment,
      this.branchLocationIds,
      this.userId,
      this.workingSessionId,
      this.isOPDQueueSysEnabled,
      this.isLabQueueSysEnabled,
      this.isPreRegTokenEnabled});

  CheckInModel.fromJson(Map<String, dynamic> json) {
    if (json['PatientCheckIn'] != dynamic) {
      patientCheckIn = <PatientCheckIn>[];
      json['PatientCheckIn'].forEach((v) {
        patientCheckIn!.add(PatientCheckIn.fromJson(v));
      });
    }
    patientServiceAppointmentId = json['PatientServiceAppointmentId'];
    paymentNo = json['PaymentNo'];
    doctorCheckInType = json['DoctorCheckInType'];
    if (json['patientServicelist'] != dynamic) {
      patientServicelist = <PatientServicelist>[];
      json['patientServicelist'].forEach((v) {
        patientServicelist!.add(PatientServicelist.fromJson(v));
      });
    }
    if (json['MiscellaneousServicesList'] != dynamic) {
      miscellaneousServicesList = <dynamic>[];
      json['MiscellaneousServicesList'].forEach((v) {});
    }
    discountReference = json['DiscountReference'];
    discountRemarks = json['DiscountRemarks'];
    checkInBranchLocationId = json['CheckInBranchLocationId'];
    sMSSendTo = json['SMSSendTo'];
    airlineId = json['AirlineId'];
    flightNo = json['FlightNo'];
    flightDate = json['FlightDate'];
    flightDestinationId = json['FlightDestinationId'];
    flightDestinationName = json['FlightDestinationName'];
    airportId = json['AirportId'];
    oEPRefNo = json['OEPRefNo'];
    nationalityId = json['NationalityId'];
    oEPId = json['OEPId'];
    jobTradeId = json['JobTradeId'];
    agentId = json['AgentId'];
    countryToVisitId = json['CountryToVisitId'];
    referenceType = json['ReferenceType'];
    referenceNumber = json['ReferenceNumber'];
    bookingRemarks = json['BookingRemarks'];
    includeFitToTravelCertificate = json['IncludeFitToTravelCertificate'];
    validityHours = json['ValidityHours'];
    vIPBooking = json['VIPBooking'];
    sampleCollectionSticker = json['SampleCollectionSticker'];
    sampleReceivedFrom = json['SampleReceivedFrom'];
    sampleReceivedFromRemarks = json['SampleReceivedFromRemarks'];
    patientLabBookingSlipAttachmentPath =
        json['PatientLabBookingSlipAttachmentPath'];
    gCCSlipNo = json['GCCSlipNo'];
    sampleReceivedFromPanelOrganizationId =
        json['SampleReceivedFromPanelOrganizationId'];
    discountReferenceId = json['DiscountReferenceId'];
    isBookingHasTestWithoutSpecimenAndAutoNumber =
        json['IsBookingHasTestWithoutSpecimenAndAutoNumber'];
    canRebookTest = json['CanRebookTest'];
    paymentMethodId = json['PaymentMethodId'];
    prescribedById = json['PrescribedById'];
    paymentMethodRemarks = json['PaymentMethodRemarks'];
    outDoorDoctor = json['OutDoorDoctor'];
    isCreditPaymentPending = json['IsCreditPaymentPending'];
    creditPaymentRemarks = json['CreditPaymentRemarks'];
    creditPaymentType = json['CreditPaymentType'];
    creditPaymentAmount = json['CreditPaymentAmount'];
    isReferralPanelBooking = json['IsReferralPanelBooking'];
    referralPanelBookingRemarks = json['ReferralPanelBookingRemarks'];
    advanceSecurityPaidAmount = json['AdvanceSecurityPaidAmount'];
    patientPassportImagePath = json['PatientPassportImagePath'];
    patientPicturePath = json['PatientPicturePath'];
    passportNumber = json['PassportNumber'];
    bookingConcentFormAttachment = json['BookingConcentFormAttachment'];
    branchLocationIds = json['BranchLocationIds'];
    userId = json['UserId'];
    workingSessionId = json['WorkingSessionId'];
    isOPDQueueSysEnabled = json['IsOPDQueueSysEnabled'];
    isLabQueueSysEnabled = json['IsLabQueueSysEnabled'];
    isPreRegTokenEnabled = json['IsPreRegTokenEnabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // ignore: unrelated_type_equality_checks
    if (patientCheckIn != dynamic) {
      data['PatientCheckIn'] = patientCheckIn!.map((v) => v.toJson()).toList();
    }
    data['PatientServiceAppointmentId'] = patientServiceAppointmentId;
    data['PaymentNo'] = paymentNo;
    data['DoctorCheckInType'] = doctorCheckInType;
    // ignore: unrelated_type_equality_checks
    if (patientServicelist != dynamic) {
      data['patientServicelist'] =
          patientServicelist!.map((v) => v.toJson()).toList();
    }
    // ignore: unrelated_type_equality_checks
    if (miscellaneousServicesList != dynamic) {
      // data['MiscellaneousServicesList'] =
      //     this.miscellaneousServicesList!.map((v) => v.toJson()).toList();
    }
    data['DiscountReference'] = discountReference;
    data['DiscountRemarks'] = discountRemarks;
    data['CheckInBranchLocationId'] = checkInBranchLocationId;
    data['SMSSendTo'] = sMSSendTo;
    data['AirlineId'] = airlineId;
    data['FlightNo'] = flightNo;
    data['FlightDate'] = flightDate;
    data['FlightDestinationId'] = flightDestinationId;
    data['FlightDestinationName'] = flightDestinationName;
    data['AirportId'] = airportId;
    data['OEPRefNo'] = oEPRefNo;
    data['NationalityId'] = nationalityId;
    data['OEPId'] = oEPId;
    data['JobTradeId'] = jobTradeId;
    data['AgentId'] = agentId;
    data['CountryToVisitId'] = countryToVisitId;
    data['ReferenceType'] = referenceType;
    data['ReferenceNumber'] = referenceNumber;
    data['BookingRemarks'] = bookingRemarks;
    data['IncludeFitToTravelCertificate'] = includeFitToTravelCertificate;
    data['ValidityHours'] = validityHours;
    data['VIPBooking'] = vIPBooking;
    data['SampleCollectionSticker'] = sampleCollectionSticker;
    data['SampleReceivedFrom'] = sampleReceivedFrom;
    data['SampleReceivedFromRemarks'] = sampleReceivedFromRemarks;
    data['PatientLabBookingSlipAttachmentPath'] =
        patientLabBookingSlipAttachmentPath;
    data['GCCSlipNo'] = gCCSlipNo;
    data['SampleReceivedFromPanelOrganizationId'] =
        sampleReceivedFromPanelOrganizationId;
    data['DiscountReferenceId'] = discountReferenceId;
    data['IsBookingHasTestWithoutSpecimenAndAutoNumber'] =
        isBookingHasTestWithoutSpecimenAndAutoNumber;
    data['CanRebookTest'] = canRebookTest;
    data['PaymentMethodId'] = paymentMethodId;
    data['PrescribedById'] = prescribedById;
    data['PaymentMethodRemarks'] = paymentMethodRemarks;
    data['OutDoorDoctor'] = outDoorDoctor;
    data['IsCreditPaymentPending'] = isCreditPaymentPending;
    data['CreditPaymentRemarks'] = creditPaymentRemarks;
    data['CreditPaymentType'] = creditPaymentType;
    data['CreditPaymentAmount'] = creditPaymentAmount;
    data['IsReferralPanelBooking'] = isReferralPanelBooking;
    data['ReferralPanelBookingRemarks'] = referralPanelBookingRemarks;
    data['AdvanceSecurityPaidAmount'] = advanceSecurityPaidAmount;
    data['PatientPassportImagePath'] = patientPassportImagePath;
    data['PatientPicturePath'] = patientPicturePath;
    data['PassportNumber'] = passportNumber;
    data['BookingConcentFormAttachment'] = bookingConcentFormAttachment;
    data['BranchLocationIds'] = branchLocationIds;
    data['UserId'] = userId;
    data['WorkingSessionId'] = workingSessionId;
    data['IsOPDQueueSysEnabled'] = isOPDQueueSysEnabled;
    data['IsLabQueueSysEnabled'] = isLabQueueSysEnabled;
    data['IsPreRegTokenEnabled'] = isPreRegTokenEnabled;
    return data;
  }
}

class PatientCheckIn {
  String? patientId;
  dynamic tokenNumber;
  String? increasedPaymentAmountRemarks;
  String? increasedPaymentAmount;
  String? customPanelEntitleLetterB;
  String? customPanelEntitleLetterA;
  String? customPanelEmployeeNo;
  String? customPanelOrganizationPackageId;
  String? customPanelOrganizationId;
  String? voucherCouponAmount;
  String? voucherCouponDiscountType;
  String? voucherCouponCode;
  String? voucherCouponId;
  String? shareAmount;
  String? shareType;
  String? shareEntityName;
  String? bookingShareConfigId;
  String? patientAppointmentId;
  String? passengerNameRecord;
  bool? isOnline;
  String? individualPackageId;
  String? checkInDiagnosisId;
  String? checkInDoctorId;
  String? fateofReffered;
  String? modeofReffered;
  String? refferedByName;
  String? refferedFromInstituteId;
  String? checkInTypeId;
  String? paidAmount;
  String? description;
  String? policeStation;
  String? patientCondition;
  String? discountType;
  String? total;
  String? discountRate;
  String? chargeRate;
  String? departmentId;
  String? doctorId;

  PatientCheckIn(
      {this.patientId,
      this.tokenNumber,
      this.increasedPaymentAmountRemarks,
      this.increasedPaymentAmount,
      this.customPanelEntitleLetterB,
      this.customPanelEntitleLetterA,
      this.customPanelEmployeeNo,
      this.customPanelOrganizationPackageId,
      this.customPanelOrganizationId,
      this.voucherCouponAmount,
      this.voucherCouponDiscountType,
      this.voucherCouponCode,
      this.voucherCouponId,
      this.shareAmount,
      this.shareType,
      this.shareEntityName,
      this.bookingShareConfigId,
      this.patientAppointmentId,
      this.passengerNameRecord,
      this.isOnline,
      this.individualPackageId,
      this.checkInDiagnosisId,
      this.checkInDoctorId,
      this.fateofReffered,
      this.modeofReffered,
      this.refferedByName,
      this.refferedFromInstituteId,
      this.checkInTypeId,
      this.paidAmount,
      this.description,
      this.policeStation,
      this.patientCondition,
      this.discountType,
      this.total,
      this.discountRate,
      this.chargeRate,
      this.departmentId,
      this.doctorId});

  PatientCheckIn.fromJson(Map<String, dynamic> json) {
    patientId = json['PatientId'];
    tokenNumber = json['TokenNumber'];
    increasedPaymentAmountRemarks = json['IncreasedPaymentAmountRemarks'];
    increasedPaymentAmount = json['IncreasedPaymentAmount'];
    customPanelEntitleLetterB = json['CustomPanelEntitleLetterB'];
    customPanelEntitleLetterA = json['CustomPanelEntitleLetterA'];
    customPanelEmployeeNo = json['CustomPanelEmployeeNo'];
    customPanelOrganizationPackageId = json['CustomPanelOrganizationPackageId'];
    customPanelOrganizationId = json['CustomPanelOrganizationId'];
    voucherCouponAmount = json['VoucherCouponAmount'];
    voucherCouponDiscountType = json['VoucherCouponDiscountType'];
    voucherCouponCode = json['VoucherCouponCode'];
    voucherCouponId = json['VoucherCouponId'];
    shareAmount = json['ShareAmount'];
    shareType = json['ShareType'];
    shareEntityName = json['ShareEntityName'];
    bookingShareConfigId = json['BookingShareConfigId'];
    patientAppointmentId = json['PatientAppointmentId'];
    passengerNameRecord = json['PassengerNameRecord'];
    isOnline = json['IsOnline'];
    individualPackageId = json['IndividualPackageId'];
    checkInDiagnosisId = json['CheckInDiagnosisId'];
    checkInDoctorId = json['CheckInDoctorId'];
    fateofReffered = json['FateofReffered'];
    modeofReffered = json['ModeofReffered'];
    refferedByName = json['RefferedByName'];
    refferedFromInstituteId = json['RefferedFromInstituteId'];
    checkInTypeId = json['CheckInTypeId'];
    paidAmount = json['PaidAmount'];
    description = json['Description'];
    policeStation = json['PoliceStation'];
    patientCondition = json['PatientCondition'];
    discountType = json['DiscountType'];
    total = json['Total'];
    discountRate = json['DiscountRate'];
    chargeRate = json['ChargeRate'];
    departmentId = json['DepartmentId'];
    doctorId = json['DoctorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientId'] = patientId;
    data['TokenNumber'] = tokenNumber;
    data['IncreasedPaymentAmountRemarks'] = increasedPaymentAmountRemarks;
    data['IncreasedPaymentAmount'] = increasedPaymentAmount;
    data['CustomPanelEntitleLetterB'] = customPanelEntitleLetterB;
    data['CustomPanelEntitleLetterA'] = customPanelEntitleLetterA;
    data['CustomPanelEmployeeNo'] = customPanelEmployeeNo;
    data['CustomPanelOrganizationPackageId'] = customPanelOrganizationPackageId;
    data['CustomPanelOrganizationId'] = customPanelOrganizationId;
    data['VoucherCouponAmount'] = voucherCouponAmount;
    data['VoucherCouponDiscountType'] = voucherCouponDiscountType;
    data['VoucherCouponCode'] = voucherCouponCode;
    data['VoucherCouponId'] = voucherCouponId;
    data['ShareAmount'] = shareAmount;
    data['ShareType'] = shareType;
    data['ShareEntityName'] = shareEntityName;
    data['BookingShareConfigId'] = bookingShareConfigId;
    data['PatientAppointmentId'] = patientAppointmentId;
    data['PassengerNameRecord'] = passengerNameRecord;
    data['IsOnline'] = isOnline;
    data['IndividualPackageId'] = individualPackageId;
    data['CheckInDiagnosisId'] = checkInDiagnosisId;
    data['CheckInDoctorId'] = checkInDoctorId;
    data['FateofReffered'] = fateofReffered;
    data['ModeofReffered'] = modeofReffered;
    data['RefferedByName'] = refferedByName;
    data['RefferedFromInstituteId'] = refferedFromInstituteId;
    data['CheckInTypeId'] = checkInTypeId;
    data['PaidAmount'] = paidAmount;
    data['Description'] = description;
    data['PoliceStation'] = policeStation;
    data['PatientCondition'] = patientCondition;
    data['DiscountType'] = discountType;
    data['Total'] = total;
    data['DiscountRate'] = discountRate;
    data['ChargeRate'] = chargeRate;
    data['DepartmentId'] = departmentId;
    data['DoctorId'] = doctorId;
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
      this.specimenName});

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
    return data;
  }
}
