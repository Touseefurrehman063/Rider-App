class samplecollectedModel {
 dynamic  isInvestigationQueue;
dynamic  patientId;
dynamic  visitNo;
  dynamic  statusBit;
dynamic  departmentId;
dynamic  subDepartmentId;
dynamic  doctorId;
dynamic  subServiceId;
dynamic  roleId;
dynamic  designationId;
dynamic  userId;
dynamic  patientCheckInId;
  List<ListLabServiceDataDetail>? listLabServiceDataDetail;
  dynamic  paidAmount;
dynamic  subDepartmentManualCodeString;
  dynamic  sampleCollectionStickerCount;
dynamic  autoNumberGenerated;
dynamic  autoNumberGenerationLabelText;
dynamic  sessionUserId;

  samplecollectedModel(
      {this.isInvestigationQueue,
      this.patientId,
      this.visitNo,
      this.statusBit,
      this.departmentId,
      this.subDepartmentId,
      this.doctorId,
      this.subServiceId,
      this.roleId,
      this.designationId,
      this.userId,
      this.patientCheckInId,
      this.listLabServiceDataDetail,
      this.paidAmount,
      this.subDepartmentManualCodeString,
      this.sampleCollectionStickerCount,
      this.autoNumberGenerated,
      this.autoNumberGenerationLabelText,
      this.sessionUserId});

  samplecollectedModel.fromJson(Map<String, dynamic> json) {
    isInvestigationQueue = json['IsInvestigationQueue'];
    patientId = json['PatientId'];
    visitNo = json['VisitNo'];
    statusBit = json['statusBit'];
    departmentId = json['DepartmentId'];
    subDepartmentId = json['SubDepartmentId'];
    doctorId = json['DoctorId'];
    subServiceId = json['SubServiceId'];
    roleId = json['RoleId'];
    designationId = json['DesignationId'];
    userId = json['UserId'];
    patientCheckInId = json['PatientCheckInId'];
    if (json['ListLabServiceDataDetail'] != null) {
      listLabServiceDataDetail = <ListLabServiceDataDetail>[];
      json['ListLabServiceDataDetail'].forEach((v) {
        listLabServiceDataDetail!.add(ListLabServiceDataDetail.fromJson(v));
      });
    }
    paidAmount = json['PaidAmount'];
    subDepartmentManualCodeString = json['SubDepartmentManualCodeString'];
    sampleCollectionStickerCount = json['SampleCollectionStickerCount'];
    autoNumberGenerated = json['AutoNumberGenerated'];
    autoNumberGenerationLabelText = json['AutoNumberGenerationLabelText'];
    sessionUserId = json['SessionUserId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsInvestigationQueue'] = isInvestigationQueue;
    data['PatientId'] = patientId;
    data['VisitNo'] = visitNo;
    data['statusBit'] = statusBit;
    data['DepartmentId'] = departmentId;
    data['SubDepartmentId'] = subDepartmentId;
    data['DoctorId'] = doctorId;
    data['SubServiceId'] = subServiceId;
    data['RoleId'] = roleId;
    data['DesignationId'] = designationId;
    data['UserId'] = userId;
    data['PatientCheckInId'] = patientCheckInId;
    if (listLabServiceDataDetail != null) {
      data['ListLabServiceDataDetail'] =
          listLabServiceDataDetail!.map((v) => v.toJson()).toList();
    }
    data['PaidAmount'] = paidAmount;
    data['SubDepartmentManualCodeString'] = subDepartmentManualCodeString;
    data['SampleCollectionStickerCount'] = sampleCollectionStickerCount;
    data['AutoNumberGenerated'] = autoNumberGenerated;
    data['AutoNumberGenerationLabelText'] = autoNumberGenerationLabelText;
    data['SessionUserId'] = sessionUserId;
    return data;
  }
}

class ListLabServiceDataDetail {
  dynamic  srNo;
dynamic  id;
dynamic  patientLabCheckInId;
dynamic  patientId;
dynamic  departmentId;
dynamic  subDepartmentId;
dynamic  userId;
dynamic  designationId;
dynamic  roleId;
 dynamic  isInPatient;
dynamic  patientVisitNo;
dynamic  subserviceName;
dynamic  prescribedbyName;
 dynamic  charges;
  dynamic  prescribedQuantity;
 dynamic  totalCharges;
dynamic  visitTime;
 dynamic  total;
dynamic  patientStatusId;
dynamic  subServiceId;
  dynamic  patientStatusValue;
 dynamic  serviceTotal;
 dynamic  isOutsideSample;
dynamic  outSourcedBranchId;
dynamic  outSideSampleComments;
dynamic  consumtionItems;
dynamic  html;
dynamic  prescribedBy;
  dynamic  patientEntitled;
dynamic  autoNumberGenerated;
dynamic  autoNumberGenerationLabelText;

  ListLabServiceDataDetail(
      {this.srNo,
      this.id,
      this.patientLabCheckInId,
      this.patientId,
      this.departmentId,
      this.subDepartmentId,
      this.userId,
      this.designationId,
      this.roleId,
      this.isInPatient,
      this.patientVisitNo,
      this.subserviceName,
      this.prescribedbyName,
      this.charges,
      this.prescribedQuantity,
      this.totalCharges,
      this.visitTime,
      this.total,
      this.patientStatusId,
      this.subServiceId,
      this.patientStatusValue,
      this.serviceTotal,
      this.isOutsideSample,
      this.outSourcedBranchId,
      this.outSideSampleComments,
      this.consumtionItems,
      this.html,
      this.prescribedBy,
      this.patientEntitled,
      this.autoNumberGenerated,
      this.autoNumberGenerationLabelText});

  ListLabServiceDataDetail.fromJson(Map<String, dynamic> json) {
    srNo = json['SrNo'];
    id = json['Id'];
    patientLabCheckInId = json['PatientLabCheckInId'];
    patientId = json['PatientId'];
    departmentId = json['DepartmentId'];
    subDepartmentId = json['SubDepartmentId'];
    userId = json['UserId'];
    designationId = json['DesignationId'];
    roleId = json['RoleId'];
    isInPatient = json['IsInPatient'];
    patientVisitNo = json['PatientVisitNo'];
    subserviceName = json['SubserviceName'];
    prescribedbyName = json['PrescribedbyName'];
    charges = json['Charges'];
    prescribedQuantity = json['PrescribedQuantity'];
    totalCharges = json['TotalCharges'];
    visitTime = json['VisitTime'];
    total = json['Total'];
    patientStatusId = json['PatientStatusId'];
    subServiceId = json['SubServiceId'];
    patientStatusValue = json['PatientStatusValue'];
    serviceTotal = json['ServiceTotal'];
    isOutsideSample = json['IsOutsideSample'];
    outSourcedBranchId = json['OutSourcedBranchId'];
    outSideSampleComments = json['OutSideSampleComments'];
    consumtionItems = json['ConsumtionItems'];
    html = json['Html'];
    prescribedBy = json['PrescribedBy'];
    patientEntitled = json['PatientEntitled'];
    autoNumberGenerated = json['AutoNumberGenerated'];
    autoNumberGenerationLabelText = json['AutoNumberGenerationLabelText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['SrNo'] = srNo;
    data['Id'] = id;
    data['PatientLabCheckInId'] = patientLabCheckInId;
    data['PatientId'] = patientId;
    data['DepartmentId'] = departmentId;
    data['SubDepartmentId'] = subDepartmentId;
    data['UserId'] = userId;
    data['DesignationId'] = designationId;
    data['RoleId'] = roleId;
    data['IsInPatient'] = isInPatient;
    data['PatientVisitNo'] = patientVisitNo;
    data['SubserviceName'] = subserviceName;
    data['PrescribedbyName'] = prescribedbyName;
    data['Charges'] = charges;
    data['PrescribedQuantity'] = prescribedQuantity;
    data['TotalCharges'] = totalCharges;
    data['VisitTime'] = visitTime;
    data['Total'] = total;
    data['PatientStatusId'] = patientStatusId;
    data['SubServiceId'] = subServiceId;
    data['PatientStatusValue'] = patientStatusValue;
    data['ServiceTotal'] = serviceTotal;
    data['IsOutsideSample'] = isOutsideSample;
    data['OutSourcedBranchId'] = outSourcedBranchId;
    data['OutSideSampleComments'] = outSideSampleComments;
    data['ConsumtionItems'] = consumtionItems;
    data['Html'] = html;
    data['PrescribedBy'] = prescribedBy;
    data['PatientEntitled'] = patientEntitled;
    data['AutoNumberGenerated'] = autoNumberGenerated;
    data['AutoNumberGenerationLabelText'] = autoNumberGenerationLabelText;
    return data;
  }
}
