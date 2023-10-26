class samplecollectionresponse {
  dynamic userId;
  dynamic  patientId;
  dynamic  patientStatusId;
  dynamic  labNo;
  dynamic  visitNo;
  dynamic branchLocationId;
  dynamic appointmentNo;
  dynamic  subServiceId;
  dynamic  price;
  dynamic  srNo;
  dynamic  prescribedById;
  dynamic isInPatient;
  dynamic  patientLabCheckInId;
  dynamic  patientName;
  dynamic cNICNumber;
  dynamic otherIdentity;
  dynamic passport;
  dynamic passengerNameRecord;
  dynamic patientLabStatusId;
  dynamic labStatus;
  dynamic  subServiceName;
  dynamic departmentName;
  dynamic branch;
  dynamic  referenceId;
  dynamic specimenContainer;
  dynamic specimenName;
  dynamic  serviceName;
  dynamic  mRNo;
  dynamic  visitTime;
  dynamic  patientStatusValue;
  dynamic html;
  dynamic  prescribedBy;
  dynamic  labCurrentStatus;
  dynamic  outSourcedBranchName;
  dynamic  outsourcedBranchId;
  dynamic  subDepartmentId;
  dynamic  departmentId;
  dynamic designationId;
  dynamic roleId;
  dynamic  callBackCount;
  dynamic totalAmount;
  dynamic  paidAmount;
  dynamic discount;
  dynamic dueAmount;
  dynamic specimenQuantity;
  dynamic barCodeIndicators;
  dynamic  prescribedByDepartmentId;
  dynamic  prescribedBySubDepartmentId;
  dynamic  payments;
  dynamic  sampling;
  dynamic  pendingBatch;
  dynamic  dispatchedBatch;
  dynamic  resultEntry;
  dynamic  verification;
  dynamic  verified;
  dynamic isOutsideSample;
  dynamic isOnePagerReport;
  dynamic isConfidential;
  dynamic isDepartmentPrintOnly;
  dynamic canPrintConfidential;
  dynamic canPrintDepartmentOnly;
  dynamic cellNumber;
  dynamic address;
  dynamic age;
  dynamic gender;
  dynamic  dateOfBirth;
  dynamic callBackComments;
  dynamic identityNo;
  dynamic attributeResult;
  dynamic flightNo;
  dynamic flightDate;
  dynamic airportId;
  dynamic airlineId;
  dynamic airportName;
  dynamic airlineName;
  dynamic cityName;
  dynamic statusTime;
  dynamic reportURL;
  dynamic isCreditPaymentPending;
  dynamic creditPaymentAmount;
  dynamic flightDestinationId;
  dynamic flightDestinationName;
  dynamic branchId;
  dynamic displaySampleCollectionDateTime;
  dynamic displayReportedOn;
  dynamic nationalityId;
  dynamic oEPId;
  dynamic agentId;
  dynamic countryToVisitId;
  dynamic jobTradeId;
  dynamic oEPRefNo;
  dynamic  vaccinationStatus;
  dynamic vaccinationStatusName;
  dynamic vaccineId;
  dynamic vaccineName;
  dynamic vaccinationDate;
  dynamic vaccinationRemarks;
  dynamic  consumptionItem;
  dynamic manualCode;
  dynamic isResultEnteredByMachine;
  dynamic subDepartmentManualCodeString;
  dynamic specimenCode;
  dynamic createdByName;
  dynamic callBackRemarks;
  dynamic actionByName;
  dynamic  serviceReportType;
  dynamic  createdOn;
  dynamic isLabReportOnHold;
  dynamic reportVisibilityType;
  dynamic patientLabBookingSlipAttachmentPath;
  dynamic sampleCollectionStickerCount;
  dynamic forwardToConsultantRemarks;
  dynamic sampleReceivedFromRemarks;
  dynamic tokenNumber;
  dynamic roomName;
  dynamic roomId;
  dynamic tokenStatus;
  dynamic tokenCallTime;
  dynamic infoCertificationType;
  dynamic assignToForVerificationById;
  dynamic assignToForConsultantVerificationById;
  dynamic holdingRemarks;
  dynamic numberOfSlides;
  dynamic autoNumberGenerated;
  dynamic autoNumberGenerationLabelText;
  dynamic autoNumberGeneratedValue;
  dynamic labExecutionDateTime;
  dynamic isReportVerificationRequiredByConsultant;
  dynamic isReportVerifiedByConsultant;
  dynamic isProvisionalReportsPrintable;
  dynamic patientEmail;
  dynamic branchLocationName;
  dynamic specimenTestMethodId;
  dynamic sampleReceivedDateTime;
  dynamic reportEnteredDateTime;
  dynamic gCCSlipNo;
  dynamic picturePath;

  samplecollectionresponse(
      {this.userId,
      this.patientId,
      this.patientStatusId,
      this.labNo,
      this.visitNo,
      this.branchLocationId,
      this.appointmentNo,
      this.subServiceId,
      this.price,
      this.srNo,
      this.prescribedById,
      this.isInPatient,
      this.patientLabCheckInId,
      this.patientName,
      this.cNICNumber,
      this.otherIdentity,
      this.passport,
      this.passengerNameRecord,
      this.patientLabStatusId,
      this.labStatus,
      this.subServiceName,
      this.departmentName,
      this.branch,
      this.referenceId,
      this.specimenContainer,
      this.specimenName,
      this.serviceName,
      this.mRNo,
      this.visitTime,
      this.patientStatusValue,
      this.html,
      this.prescribedBy,
      this.labCurrentStatus,
      this.outSourcedBranchName,
      this.outsourcedBranchId,
      this.subDepartmentId,
      this.departmentId,
      this.designationId,
      this.roleId,
      this.callBackCount,
      this.totalAmount,
      this.paidAmount,
      this.discount,
      this.dueAmount,
      this.specimenQuantity,
      this.barCodeIndicators,
      this.prescribedByDepartmentId,
      this.prescribedBySubDepartmentId,
      this.payments,
      this.sampling,
      this.pendingBatch,
      this.dispatchedBatch,
      this.resultEntry,
      this.verification,
      this.verified,
      this.isOutsideSample,
      this.isOnePagerReport,
      this.isConfidential,
      this.isDepartmentPrintOnly,
      this.canPrintConfidential,
      this.canPrintDepartmentOnly,
      this.cellNumber,
      this.address,
      this.age,
      this.gender,
      this.dateOfBirth,
      this.callBackComments,
      this.identityNo,
      this.attributeResult,
      this.flightNo,
      this.flightDate,
      this.airportId,
      this.airlineId,
      this.airportName,
      this.airlineName,
      this.cityName,
      this.statusTime,
      this.reportURL,
      this.isCreditPaymentPending,
      this.creditPaymentAmount,
      this.flightDestinationId,
      this.flightDestinationName,
      this.branchId,
      this.displaySampleCollectionDateTime,
      this.displayReportedOn,
      this.nationalityId,
      this.oEPId,
      this.agentId,
      this.countryToVisitId,
      this.jobTradeId,
      this.oEPRefNo,
      this.vaccinationStatus,
      this.vaccinationStatusName,
      this.vaccineId,
      this.vaccineName,
      this.vaccinationDate,
      this.vaccinationRemarks,
      this.consumptionItem,
      this.manualCode,
      this.isResultEnteredByMachine,
      this.subDepartmentManualCodeString,
      this.specimenCode,
      this.createdByName,
      this.callBackRemarks,
      this.actionByName,
      this.serviceReportType,
      this.createdOn,
      this.isLabReportOnHold,
      this.reportVisibilityType,
      this.patientLabBookingSlipAttachmentPath,
      this.sampleCollectionStickerCount,
      this.forwardToConsultantRemarks,
      this.sampleReceivedFromRemarks,
      this.tokenNumber,
      this.roomName,
      this.roomId,
      this.tokenStatus,
      this.tokenCallTime,
      this.infoCertificationType,
      this.assignToForVerificationById,
      this.assignToForConsultantVerificationById,
      this.holdingRemarks,
      this.numberOfSlides,
      this.autoNumberGenerated,
      this.autoNumberGenerationLabelText,
      this.autoNumberGeneratedValue,
      this.labExecutionDateTime,
      this.isReportVerificationRequiredByConsultant,
      this.isReportVerifiedByConsultant,
      this.isProvisionalReportsPrintable,
      this.patientEmail,
      this.branchLocationName,
      this.specimenTestMethodId,
      this.sampleReceivedDateTime,
      this.reportEnteredDateTime,
      this.gCCSlipNo,
      this.picturePath});

  samplecollectionresponse.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    patientId = json['PatientId'];
    patientStatusId = json['PatientStatusId'];
    labNo = json['LabNo'];
    visitNo = json['VisitNo'];
    branchLocationId = json['BranchLocationId'];
    appointmentNo = json['AppointmentNo'];
    subServiceId = json['SubServiceId'];
    price = json['Price'];
    srNo = json['SrNo'];
    prescribedById = json['PrescribedById'];
    isInPatient = json['IsInPatient'];
    patientLabCheckInId = json['PatientLabCheckInId'];
    patientName = json['PatientName'];
    cNICNumber = json['CNICNumber'];
    otherIdentity = json['OtherIdentity'];
    passport = json['Passport'];
    passengerNameRecord = json['PassengerNameRecord'];
    patientLabStatusId = json['PatientLabStatusId'];
    labStatus = json['LabStatus'];
    subServiceName = json['SubServiceName'];
    departmentName = json['DepartmentName'];
    branch = json['Branch'];
    referenceId = json['ReferenceId'];
    specimenContainer = json['SpecimenContainer'];
    specimenName = json['SpecimenName'];
    serviceName = json['ServiceName'];
    mRNo = json['MRNo'];
    visitTime = json['VisitTime'];
    patientStatusValue = json['PatientStatusValue'];
    html = json['Html'];
    prescribedBy = json['PrescribedBy'];
    labCurrentStatus = json['LabCurrentStatus'];
    outSourcedBranchName = json['OutSourcedBranchName'];
    outsourcedBranchId = json['OutsourcedBranchId'];
    subDepartmentId = json['SubDepartmentId'];
    departmentId = json['DepartmentId'];
    designationId = json['DesignationId'];
    roleId = json['RoleId'];
    callBackCount = json['CallBackCount'];
    totalAmount = json['TotalAmount'];
    paidAmount = json['PaidAmount'];
    discount = json['Discount'];
    dueAmount = json['DueAmount'];
    specimenQuantity = json['SpecimenQuantity'];
    barCodeIndicators = json['BarCodeIndicators'];
    prescribedByDepartmentId = json['PrescribedByDepartmentId'];
    prescribedBySubDepartmentId = json['PrescribedBySubDepartmentId'];
    payments = json['Payments'];
    sampling = json['Sampling'];
    pendingBatch = json['PendingBatch'];
    dispatchedBatch = json['DispatchedBatch'];
    resultEntry = json['ResultEntry'];
    verification = json['Verification'];
    verified = json['Verified'];
    isOutsideSample = json['IsOutsideSample'];
    isOnePagerReport = json['IsOnePagerReport'];
    isConfidential = json['IsConfidential'];
    isDepartmentPrintOnly = json['IsDepartmentPrintOnly'];
    canPrintConfidential = json['CanPrintConfidential'];
    canPrintDepartmentOnly = json['CanPrintDepartmentOnly'];
    cellNumber = json['CellNumber'];
    address = json['Address'];
    age = json['Age'];
    gender = json['Gender'];
    dateOfBirth = json['DateOfBirth'];
    callBackComments = json['CallBackComments'];
    identityNo = json['IdentityNo'];
    attributeResult = json['AttributeResult'];
    flightNo = json['FlightNo'];
    flightDate = json['FlightDate'];
    airportId = json['AirportId'];
    airlineId = json['AirlineId'];
    airportName = json['AirportName'];
    airlineName = json['AirlineName'];
    cityName = json['CityName'];
    statusTime = json['StatusTime'];
    reportURL = json['ReportURL'];
    isCreditPaymentPending = json['IsCreditPaymentPending'];
    creditPaymentAmount = json['CreditPaymentAmount'];
    flightDestinationId = json['FlightDestinationId'];
    flightDestinationName = json['FlightDestinationName'];
    branchId = json['BranchId'];
    displaySampleCollectionDateTime = json['DisplaySampleCollectionDateTime'];
    displayReportedOn = json['DisplayReportedOn'];
    nationalityId = json['NationalityId'];
    oEPId = json['OEPId'];
    agentId = json['AgentId'];
    countryToVisitId = json['CountryToVisitId'];
    jobTradeId = json['JobTradeId'];
    oEPRefNo = json['OEPRefNo'];
    vaccinationStatus = json['VaccinationStatus'];
    vaccinationStatusName = json['VaccinationStatusName'];
    vaccineId = json['VaccineId'];
    vaccineName = json['VaccineName'];
    vaccinationDate = json['VaccinationDate'];
    vaccinationRemarks = json['VaccinationRemarks'];
    consumptionItem = json['ConsumptionItem'];
    manualCode = json['ManualCode'];
    isResultEnteredByMachine = json['IsResultEnteredByMachine'];
    subDepartmentManualCodeString = json['SubDepartmentManualCodeString'];
    specimenCode = json['SpecimenCode'];
    createdByName = json['CreatedByName'];
    callBackRemarks = json['CallBackRemarks'];
    actionByName = json['ActionByName'];
    serviceReportType = json['ServiceReportType'];
    createdOn = json['CreatedOn'];
    isLabReportOnHold = json['IsLabReportOnHold'];
    reportVisibilityType = json['ReportVisibilityType'];
    patientLabBookingSlipAttachmentPath =
        json['PatientLabBookingSlipAttachmentPath'];
    sampleCollectionStickerCount = json['SampleCollectionStickerCount'];
    forwardToConsultantRemarks = json['ForwardToConsultantRemarks'];
    sampleReceivedFromRemarks = json['SampleReceivedFromRemarks'];
    tokenNumber = json['TokenNumber'];
    roomName = json['RoomName'];
    roomId = json['RoomId'];
    tokenStatus = json['TokenStatus'];
    tokenCallTime = json['TokenCallTime'];
    infoCertificationType = json['InfoCertificationType'];
    assignToForVerificationById = json['AssignToForVerificationById'];
    assignToForConsultantVerificationById =
        json['AssignToForConsultantVerificationById'];
    holdingRemarks = json['HoldingRemarks'];
    numberOfSlides = json['NumberOfSlides'];
    autoNumberGenerated = json['AutoNumberGenerated'];
    autoNumberGenerationLabelText = json['AutoNumberGenerationLabelText'];
    autoNumberGeneratedValue = json['AutoNumberGeneratedValue'];
    labExecutionDateTime = json['LabExecutionDateTime'];
    isReportVerificationRequiredByConsultant =
        json['IsReportVerificationRequiredByConsultant'];
    isReportVerifiedByConsultant = json['IsReportVerifiedByConsultant'];
    isProvisionalReportsPrintable = json['IsProvisionalReportsPrintable'];
    patientEmail = json['PatientEmail'];
    branchLocationName = json['BranchLocationName'];
    specimenTestMethodId = json['SpecimenTestMethodId'];
    sampleReceivedDateTime = json['SampleReceivedDateTime'];
    reportEnteredDateTime = json['ReportEnteredDateTime'];
    gCCSlipNo = json['GCCSlipNo'];
    picturePath = json['PicturePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserId'] = this.userId;
    data['PatientId'] = this.patientId;
    data['PatientStatusId'] = this.patientStatusId;
    data['LabNo'] = this.labNo;
    data['VisitNo'] = this.visitNo;
    data['BranchLocationId'] = this.branchLocationId;
    data['AppointmentNo'] = this.appointmentNo;
    data['SubServiceId'] = this.subServiceId;
    data['Price'] = this.price;
    data['SrNo'] = this.srNo;
    data['PrescribedById'] = this.prescribedById;
    data['IsInPatient'] = this.isInPatient;
    data['PatientLabCheckInId'] = this.patientLabCheckInId;
    data['PatientName'] = this.patientName;
    data['CNICNumber'] = this.cNICNumber;
    data['OtherIdentity'] = this.otherIdentity;
    data['Passport'] = this.passport;
    data['PassengerNameRecord'] = this.passengerNameRecord;
    data['PatientLabStatusId'] = this.patientLabStatusId;
    data['LabStatus'] = this.labStatus;
    data['SubServiceName'] = this.subServiceName;
    data['DepartmentName'] = this.departmentName;
    data['Branch'] = this.branch;
    data['ReferenceId'] = this.referenceId;
    data['SpecimenContainer'] = this.specimenContainer;
    data['SpecimenName'] = this.specimenName;
    data['ServiceName'] = this.serviceName;
    data['MRNo'] = this.mRNo;
    data['VisitTime'] = this.visitTime;
    data['PatientStatusValue'] = this.patientStatusValue;
    data['Html'] = this.html;
    data['PrescribedBy'] = this.prescribedBy;
    data['LabCurrentStatus'] = this.labCurrentStatus;
    data['OutSourcedBranchName'] = this.outSourcedBranchName;
    data['OutsourcedBranchId'] = this.outsourcedBranchId;
    data['SubDepartmentId'] = this.subDepartmentId;
    data['DepartmentId'] = this.departmentId;
    data['DesignationId'] = this.designationId;
    data['RoleId'] = this.roleId;
    data['CallBackCount'] = this.callBackCount;
    data['TotalAmount'] = this.totalAmount;
    data['PaidAmount'] = this.paidAmount;
    data['Discount'] = this.discount;
    data['DueAmount'] = this.dueAmount;
    data['SpecimenQuantity'] = this.specimenQuantity;
    data['BarCodeIndicators'] = this.barCodeIndicators;
    data['PrescribedByDepartmentId'] = this.prescribedByDepartmentId;
    data['PrescribedBySubDepartmentId'] = this.prescribedBySubDepartmentId;
    data['Payments'] = this.payments;
    data['Sampling'] = this.sampling;
    data['PendingBatch'] = this.pendingBatch;
    data['DispatchedBatch'] = this.dispatchedBatch;
    data['ResultEntry'] = this.resultEntry;
    data['Verification'] = this.verification;
    data['Verified'] = this.verified;
    data['IsOutsideSample'] = this.isOutsideSample;
    data['IsOnePagerReport'] = this.isOnePagerReport;
    data['IsConfidential'] = this.isConfidential;
    data['IsDepartmentPrintOnly'] = this.isDepartmentPrintOnly;
    data['CanPrintConfidential'] = this.canPrintConfidential;
    data['CanPrintDepartmentOnly'] = this.canPrintDepartmentOnly;
    data['CellNumber'] = this.cellNumber;
    data['Address'] = this.address;
    data['Age'] = this.age;
    data['Gender'] = this.gender;
    data['DateOfBirth'] = this.dateOfBirth;
    data['CallBackComments'] = this.callBackComments;
    data['IdentityNo'] = this.identityNo;
    data['AttributeResult'] = this.attributeResult;
    data['FlightNo'] = this.flightNo;
    data['FlightDate'] = this.flightDate;
    data['AirportId'] = this.airportId;
    data['AirlineId'] = this.airlineId;
    data['AirportName'] = this.airportName;
    data['AirlineName'] = this.airlineName;
    data['CityName'] = this.cityName;
    data['StatusTime'] = this.statusTime;
    data['ReportURL'] = this.reportURL;
    data['IsCreditPaymentPending'] = this.isCreditPaymentPending;
    data['CreditPaymentAmount'] = this.creditPaymentAmount;
    data['FlightDestinationId'] = this.flightDestinationId;
    data['FlightDestinationName'] = this.flightDestinationName;
    data['BranchId'] = this.branchId;
    data['DisplaySampleCollectionDateTime'] =
        this.displaySampleCollectionDateTime;
    data['DisplayReportedOn'] = this.displayReportedOn;
    data['NationalityId'] = this.nationalityId;
    data['OEPId'] = this.oEPId;
    data['AgentId'] = this.agentId;
    data['CountryToVisitId'] = this.countryToVisitId;
    data['JobTradeId'] = this.jobTradeId;
    data['OEPRefNo'] = this.oEPRefNo;
    data['VaccinationStatus'] = this.vaccinationStatus;
    data['VaccinationStatusName'] = this.vaccinationStatusName;
    data['VaccineId'] = this.vaccineId;
    data['VaccineName'] = this.vaccineName;
    data['VaccinationDate'] = this.vaccinationDate;
    data['VaccinationRemarks'] = this.vaccinationRemarks;
    data['ConsumptionItem'] = this.consumptionItem;
    data['ManualCode'] = this.manualCode;
    data['IsResultEnteredByMachine'] = this.isResultEnteredByMachine;
    data['SubDepartmentManualCodeString'] = this.subDepartmentManualCodeString;
    data['SpecimenCode'] = this.specimenCode;
    data['CreatedByName'] = this.createdByName;
    data['CallBackRemarks'] = this.callBackRemarks;
    data['ActionByName'] = this.actionByName;
    data['ServiceReportType'] = this.serviceReportType;
    data['CreatedOn'] = this.createdOn;
    data['IsLabReportOnHold'] = this.isLabReportOnHold;
    data['ReportVisibilityType'] = this.reportVisibilityType;
    data['PatientLabBookingSlipAttachmentPath'] =
        this.patientLabBookingSlipAttachmentPath;
    data['SampleCollectionStickerCount'] = this.sampleCollectionStickerCount;
    data['ForwardToConsultantRemarks'] = this.forwardToConsultantRemarks;
    data['SampleReceivedFromRemarks'] = this.sampleReceivedFromRemarks;
    data['TokenNumber'] = this.tokenNumber;
    data['RoomName'] = this.roomName;
    data['RoomId'] = this.roomId;
    data['TokenStatus'] = this.tokenStatus;
    data['TokenCallTime'] = this.tokenCallTime;
    data['InfoCertificationType'] = this.infoCertificationType;
    data['AssignToForVerificationById'] = this.assignToForVerificationById;
    data['AssignToForConsultantVerificationById'] =
        this.assignToForConsultantVerificationById;
    data['HoldingRemarks'] = this.holdingRemarks;
    data['NumberOfSlides'] = this.numberOfSlides;
    data['AutoNumberGenerated'] = this.autoNumberGenerated;
    data['AutoNumberGenerationLabelText'] = this.autoNumberGenerationLabelText;
    data['AutoNumberGeneratedValue'] = this.autoNumberGeneratedValue;
    data['LabExecutionDateTime'] = this.labExecutionDateTime;
    data['IsReportVerificationRequiredByConsultant'] =
        this.isReportVerificationRequiredByConsultant;
    data['IsReportVerifiedByConsultant'] = this.isReportVerifiedByConsultant;
    data['IsProvisionalReportsPrintable'] = this.isProvisionalReportsPrintable;
    data['PatientEmail'] = this.patientEmail;
    data['BranchLocationName'] = this.branchLocationName;
    data['SpecimenTestMethodId'] = this.specimenTestMethodId;
    data['SampleReceivedDateTime'] = this.sampleReceivedDateTime;
    data['ReportEnteredDateTime'] = this.reportEnteredDateTime;
    data['GCCSlipNo'] = this.gCCSlipNo;
    data['PicturePath'] = this.picturePath;
    return data;
  }
}
