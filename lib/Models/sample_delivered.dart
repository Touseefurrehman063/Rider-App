class sampledeliveredModel {
  dynamic patientId;
  dynamic branchLocationId;
  dynamic labNo;
 dynamic riderLatitude;
 dynamic riderLongitude;
  dynamic riderAddress;
  dynamic riderRemarks;
  dynamic userId;
  dynamic deliveryBranchLocationId;

  sampledeliveredModel(
      {this.patientId,
      this.branchLocationId,
      this.labNo,
      this.riderLatitude,
      this.riderLongitude,
      this.riderAddress,
      this.riderRemarks,
      this.userId,
      this.deliveryBranchLocationId});

  sampledeliveredModel.fromJson(Map<String, dynamic> json) {
    patientId = json['PatientId'];
    branchLocationId = json['BranchLocationId'];
    labNo = json['LabNo'];
    riderLatitude = json['RiderLatitude'];
    riderLongitude = json['RiderLongitude'];
    riderAddress = json['RiderAddress'];
    riderRemarks = json['RiderRemarks'];
    userId = json['UserId'];
    deliveryBranchLocationId = json['DeliveryBranchLocationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientId'] = patientId;
    data['BranchLocationId'] = branchLocationId;
    data['LabNo'] = labNo;
    data['RiderLatitude'] = riderLatitude;
    data['RiderLongitude'] = riderLongitude;
    data['RiderAddress'] = riderAddress;
    data['RiderRemarks'] = riderRemarks;
    data['UserId'] = userId;
    data['DeliveryBranchLocationId'] = deliveryBranchLocationId;
    return data;
  }
}
