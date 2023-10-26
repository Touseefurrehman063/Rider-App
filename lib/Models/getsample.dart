class getsamplemodel {
  dynamic userId;
  dynamic patientId;
  dynamic patientStatusId;
  dynamic labNo;
  dynamic visitNo;
  dynamic branchLocationId;
  dynamic appointmentNo;
  dynamic subServiceId;
  int? price;

  getsamplemodel(
      {this.userId,
      this.patientId,
      this.patientStatusId,
      this.labNo,
      this.visitNo,
      this.branchLocationId,
      this.appointmentNo,
      this.subServiceId,
      this.price});

  getsamplemodel.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    patientId = json['PatientId'];
    patientStatusId = json['PatientStatusId'];
    labNo = json['LabNo'];
    visitNo = json['VisitNo'];
    branchLocationId = json['BranchLocationId'];
    appointmentNo = json['AppointmentNo'];
    subServiceId = json['SubServiceId'];
    price = json['Price'];
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
    return data;
  }
}