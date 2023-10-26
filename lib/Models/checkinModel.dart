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
        patientCheckIn!.add(new PatientCheckIn.fromJson(v));
      });
    }
    patientServiceAppointmentId = json['PatientServiceAppointmentId'];
    paymentNo = json['PaymentNo'];
    doctorCheckInType = json['DoctorCheckInType'];
    if (json['patientServicelist'] != dynamic) {
      patientServicelist = <PatientServicelist>[];
      json['patientServicelist'].forEach((v) {
        patientServicelist!.add(new PatientServicelist.fromJson(v));
      });
    }
    if (json['MiscellaneousServicesList'] != dynamic) {
      miscellaneousServicesList = <dynamic>[];
      json['MiscellaneousServicesList'].forEach((v) {
       
      });
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patientCheckIn != dynamic) {
      data['PatientCheckIn'] =
          this.patientCheckIn!.map((v) => v.toJson()).toList();
    }
    data['PatientServiceAppointmentId'] = this.patientServiceAppointmentId;
    data['PaymentNo'] = this.paymentNo;
    data['DoctorCheckInType'] = this.doctorCheckInType;
    if (this.patientServicelist != dynamic) {
      data['patientServicelist'] =
          this.patientServicelist!.map((v) => v.toJson()).toList();
    }
    if (this.miscellaneousServicesList != dynamic) {
      // data['MiscellaneousServicesList'] =
      //     this.miscellaneousServicesList!.map((v) => v.toJson()).toList();
    }
    data['DiscountReference'] = this.discountReference;
    data['DiscountRemarks'] = this.discountRemarks;
    data['CheckInBranchLocationId'] = this.checkInBranchLocationId;
    data['SMSSendTo'] = this.sMSSendTo;
    data['AirlineId'] = this.airlineId;
    data['FlightNo'] = this.flightNo;
    data['FlightDate'] = this.flightDate;
    data['FlightDestinationId'] = this.flightDestinationId;
    data['FlightDestinationName'] = this.flightDestinationName;
    data['AirportId'] = this.airportId;
    data['OEPRefNo'] = this.oEPRefNo;
    data['NationalityId'] = this.nationalityId;
    data['OEPId'] = this.oEPId;
    data['JobTradeId'] = this.jobTradeId;
    data['AgentId'] = this.agentId;
    data['CountryToVisitId'] = this.countryToVisitId;
    data['ReferenceType'] = this.referenceType;
    data['ReferenceNumber'] = this.referenceNumber;
    data['BookingRemarks'] = this.bookingRemarks;
    data['IncludeFitToTravelCertificate'] = this.includeFitToTravelCertificate;
    data['ValidityHours'] = this.validityHours;
    data['VIPBooking'] = this.vIPBooking;
    data['SampleCollectionSticker'] = this.sampleCollectionSticker;
    data['SampleReceivedFrom'] = this.sampleReceivedFrom;
    data['SampleReceivedFromRemarks'] = this.sampleReceivedFromRemarks;
    data['PatientLabBookingSlipAttachmentPath'] =
        this.patientLabBookingSlipAttachmentPath;
    data['GCCSlipNo'] = this.gCCSlipNo;
    data['SampleReceivedFromPanelOrganizationId'] =
        this.sampleReceivedFromPanelOrganizationId;
    data['DiscountReferenceId'] = this.discountReferenceId;
    data['IsBookingHasTestWithoutSpecimenAndAutoNumber'] =
        this.isBookingHasTestWithoutSpecimenAndAutoNumber;
    data['CanRebookTest'] = this.canRebookTest;
    data['PaymentMethodId'] = this.paymentMethodId;
    data['PrescribedById'] = this.prescribedById;
    data['PaymentMethodRemarks'] = this.paymentMethodRemarks;
    data['OutDoorDoctor'] = this.outDoorDoctor;
    data['IsCreditPaymentPending'] = this.isCreditPaymentPending;
    data['CreditPaymentRemarks'] = this.creditPaymentRemarks;
    data['CreditPaymentType'] = this.creditPaymentType;
    data['CreditPaymentAmount'] = this.creditPaymentAmount;
    data['IsReferralPanelBooking'] = this.isReferralPanelBooking;
    data['ReferralPanelBookingRemarks'] = this.referralPanelBookingRemarks;
    data['AdvanceSecurityPaidAmount'] = this.advanceSecurityPaidAmount;
    data['PatientPassportImagePath'] = this.patientPassportImagePath;
    data['PatientPicturePath'] = this.patientPicturePath;
    data['PassportNumber'] = this.passportNumber;
    data['BookingConcentFormAttachment'] = this.bookingConcentFormAttachment;
    data['BranchLocationIds'] = this.branchLocationIds;
    data['UserId'] = this.userId;
    data['WorkingSessionId'] = this.workingSessionId;
    data['IsOPDQueueSysEnabled'] = this.isOPDQueueSysEnabled;
    data['IsLabQueueSysEnabled'] = this.isLabQueueSysEnabled;
    data['IsPreRegTokenEnabled'] = this.isPreRegTokenEnabled;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PatientId'] = this.patientId;
    data['TokenNumber'] = this.tokenNumber;
    data['IncreasedPaymentAmountRemarks'] = this.increasedPaymentAmountRemarks;
    data['IncreasedPaymentAmount'] = this.increasedPaymentAmount;
    data['CustomPanelEntitleLetterB'] = this.customPanelEntitleLetterB;
    data['CustomPanelEntitleLetterA'] = this.customPanelEntitleLetterA;
    data['CustomPanelEmployeeNo'] = this.customPanelEmployeeNo;
    data['CustomPanelOrganizationPackageId'] =
        this.customPanelOrganizationPackageId;
    data['CustomPanelOrganizationId'] = this.customPanelOrganizationId;
    data['VoucherCouponAmount'] = this.voucherCouponAmount;
    data['VoucherCouponDiscountType'] = this.voucherCouponDiscountType;
    data['VoucherCouponCode'] = this.voucherCouponCode;
    data['VoucherCouponId'] = this.voucherCouponId;
    data['ShareAmount'] = this.shareAmount;
    data['ShareType'] = this.shareType;
    data['ShareEntityName'] = this.shareEntityName;
    data['BookingShareConfigId'] = this.bookingShareConfigId;
    data['PatientAppointmentId'] = this.patientAppointmentId;
    data['PassengerNameRecord'] = this.passengerNameRecord;
    data['IsOnline'] = this.isOnline;
    data['IndividualPackageId'] = this.individualPackageId;
    data['CheckInDiagnosisId'] = this.checkInDiagnosisId;
    data['CheckInDoctorId'] = this.checkInDoctorId;
    data['FateofReffered'] = this.fateofReffered;
    data['ModeofReffered'] = this.modeofReffered;
    data['RefferedByName'] = this.refferedByName;
    data['RefferedFromInstituteId'] = this.refferedFromInstituteId;
    data['CheckInTypeId'] = this.checkInTypeId;
    data['PaidAmount'] = this.paidAmount;
    data['Description'] = this.description;
    data['PoliceStation'] = this.policeStation;
    data['PatientCondition'] = this.patientCondition;
    data['DiscountType'] = this.discountType;
    data['Total'] = this.total;
    data['DiscountRate'] = this.discountRate;
    data['ChargeRate'] = this.chargeRate;
    data['DepartmentId'] = this.departmentId;
    data['DoctorId'] = this.doctorId;
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
    return data;
  }
}
