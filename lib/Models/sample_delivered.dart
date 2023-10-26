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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PatientId'] = this.patientId;
    data['BranchLocationId'] = this.branchLocationId;
    data['LabNo'] = this.labNo;
    data['RiderLatitude'] = this.riderLatitude;
    data['RiderLongitude'] = this.riderLongitude;
    data['RiderAddress'] = this.riderAddress;
    data['RiderRemarks'] = this.riderRemarks;
    data['UserId'] = this.userId;
    data['DeliveryBranchLocationId'] = this.deliveryBranchLocationId;
    return data;
  }
}
