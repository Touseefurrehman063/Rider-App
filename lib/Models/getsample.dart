// ignore_for_file: camel_case_types

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = userId;
    data['PatientId'] = patientId;
    data['PatientStatusId'] = patientStatusId;
    data['LabNo'] = labNo;
    data['VisitNo'] = visitNo;
    data['BranchLocationId'] = branchLocationId;
    data['AppointmentNo'] = appointmentNo;
    data['SubServiceId'] = subServiceId;
    data['Price'] = price;
    return data;
  }
}
