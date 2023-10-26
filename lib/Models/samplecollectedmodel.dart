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
        listLabServiceDataDetail!.add(new ListLabServiceDataDetail.fromJson(v));
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsInvestigationQueue'] = this.isInvestigationQueue;
    data['PatientId'] = this.patientId;
    data['VisitNo'] = this.visitNo;
    data['statusBit'] = this.statusBit;
    data['DepartmentId'] = this.departmentId;
    data['SubDepartmentId'] = this.subDepartmentId;
    data['DoctorId'] = this.doctorId;
    data['SubServiceId'] = this.subServiceId;
    data['RoleId'] = this.roleId;
    data['DesignationId'] = this.designationId;
    data['UserId'] = this.userId;
    data['PatientCheckInId'] = this.patientCheckInId;
    if (this.listLabServiceDataDetail != null) {
      data['ListLabServiceDataDetail'] =
          this.listLabServiceDataDetail!.map((v) => v.toJson()).toList();
    }
    data['PaidAmount'] = this.paidAmount;
    data['SubDepartmentManualCodeString'] = this.subDepartmentManualCodeString;
    data['SampleCollectionStickerCount'] = this.sampleCollectionStickerCount;
    data['AutoNumberGenerated'] = this.autoNumberGenerated;
    data['AutoNumberGenerationLabelText'] = this.autoNumberGenerationLabelText;
    data['SessionUserId'] = this.sessionUserId;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SrNo'] = this.srNo;
    data['Id'] = this.id;
    data['PatientLabCheckInId'] = this.patientLabCheckInId;
    data['PatientId'] = this.patientId;
    data['DepartmentId'] = this.departmentId;
    data['SubDepartmentId'] = this.subDepartmentId;
    data['UserId'] = this.userId;
    data['DesignationId'] = this.designationId;
    data['RoleId'] = this.roleId;
    data['IsInPatient'] = this.isInPatient;
    data['PatientVisitNo'] = this.patientVisitNo;
    data['SubserviceName'] = this.subserviceName;
    data['PrescribedbyName'] = this.prescribedbyName;
    data['Charges'] = this.charges;
    data['PrescribedQuantity'] = this.prescribedQuantity;
    data['TotalCharges'] = this.totalCharges;
    data['VisitTime'] = this.visitTime;
    data['Total'] = this.total;
    data['PatientStatusId'] = this.patientStatusId;
    data['SubServiceId'] = this.subServiceId;
    data['PatientStatusValue'] = this.patientStatusValue;
    data['ServiceTotal'] = this.serviceTotal;
    data['IsOutsideSample'] = this.isOutsideSample;
    data['OutSourcedBranchId'] = this.outSourcedBranchId;
    data['OutSideSampleComments'] = this.outSideSampleComments;
    data['ConsumtionItems'] = this.consumtionItems;
    data['Html'] = this.html;
    data['PrescribedBy'] = this.prescribedBy;
    data['PatientEntitled'] = this.patientEntitled;
    data['AutoNumberGenerated'] = this.autoNumberGenerated;
    data['AutoNumberGenerationLabelText'] = this.autoNumberGenerationLabelText;
    return data;
  }
}
