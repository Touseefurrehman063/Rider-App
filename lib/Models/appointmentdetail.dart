// ignore: camel_case_types
class apointmentdetail {
  dynamic id;
  dynamic subServiceId;
  dynamic subServiceName;
  dynamic price;
  dynamic paymentMethodId;
  dynamic branchLocationId;
  dynamic userId;
  dynamic patientId;
  dynamic appointmentNo;
  dynamic vatamount;
  dynamic vatpercentage;

  apointmentdetail(
      {this.id,
      this.subServiceId,
      this.subServiceName,
      this.price,
      this.paymentMethodId,
      this.branchLocationId,
      this.userId,
      this.patientId,
      this.appointmentNo,
      this.vatamount,
      this.vatpercentage});

  apointmentdetail.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    subServiceId = json['SubServiceId'];
    subServiceName = json['SubServiceName'];
    price = json['Price'];
    paymentMethodId = json['PaymentMethodId'];
    branchLocationId = json['BranchLocationId'];
    userId = json['UserId'];
    patientId = json['PatientId'];
    appointmentNo = json['AppointmentNo'];
    vatamount = json['VATAmount'];
    vatpercentage = json['VATPercentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['SubServiceId'] = subServiceId;
    data['SubServiceName'] = subServiceName;
    data['Price'] = price;
    data['PaymentMethodId'] = paymentMethodId;
    data['BranchLocationId'] = branchLocationId;
    data['UserId'] = userId;
    data['PatientId'] = patientId;
    data['AppointmentNo'] = appointmentNo;
    data['VATPercentage'] = vatpercentage;
    data['VATAmount'] = vatamount;
    return data;
  }
}
