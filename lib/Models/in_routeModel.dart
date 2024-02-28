// ignore_for_file: file_names

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientId'] = patientId;
    data['BranchLocationId'] = branchLocationId;
    data['LabNo'] = labNo;
    data['RiderLatitude'] = riderLatitude;
    data['RiderLongitude'] = riderLongitude;
    data['UserId'] = userId;
    data['DeliveryBranchLocationId'] = deliveryBranchLocationId;
    data['InRouteDeliveryBranchLocationId'] = inRouteDeliveryBranchLocationId;
    return data;
  }
}
