class InrouteModel {
 dynamic patientId;
 dynamic branchLocationId;
 dynamic labNo;
  dynamic riderLatitude;
  dynamic riderLongitude;
 dynamic userId;
 dynamic deliveryBranchLocationId;
 dynamic inRouteDeliveryBranchLocationId;

  InrouteModel(
      {this.patientId,
      this.branchLocationId,
      this.labNo,
      this.riderLatitude,
      this.riderLongitude,
      this.userId,
      this.deliveryBranchLocationId,
      this.inRouteDeliveryBranchLocationId});

  InrouteModel.fromJson(Map<String, dynamic> json) {
    patientId = json['PatientId'];
    branchLocationId = json['BranchLocationId'];
    labNo = json['LabNo'];
    riderLatitude = json['RiderLatitude'];
    riderLongitude = json['RiderLongitude'];
    userId = json['UserId'];
    deliveryBranchLocationId = json['DeliveryBranchLocationId'];
    inRouteDeliveryBranchLocationId = json['InRouteDeliveryBranchLocationId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PatientId'] = this.patientId;
    data['BranchLocationId'] = this.branchLocationId;
    data['LabNo'] = this.labNo;
    data['RiderLatitude'] = this.riderLatitude;
    data['RiderLongitude'] = this.riderLongitude;
    data['UserId'] = this.userId;
    data['DeliveryBranchLocationId'] = this.deliveryBranchLocationId;
    data['InRouteDeliveryBranchLocationId'] =
        this.inRouteDeliveryBranchLocationId;
    return data;
  }
}
