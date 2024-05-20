class apointmentdetail {
  dynamic id;
  String? subServiceId;
  dynamic subServiceName;
  dynamic price;
  String? paymentMethodId;
  String? branchLocationId;
  dynamic userId;
  dynamic patientId;
  String? appointmentNo;
  String? status;
  dynamic statusValue;
  dynamic vATPercentage;
  dynamic vATAmount;
  dynamic typeBit;
  dynamic subServiceQuantity;
  String? bookingDate;
  String? startTime;
  String? address;
  String? patientName;
  dynamic total;
  dynamic discountType;
  dynamic discount;

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
      this.status,
      this.statusValue,
      this.vATPercentage,
      this.vATAmount,
      this.typeBit,
      this.subServiceQuantity,
      this.bookingDate,
      this.startTime,
      this.address,
      this.patientName,
      this.total,
      this.discountType,
      this.discount});

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
    status = json['Status'];
    statusValue = json['StatusValue'];
    vATPercentage = json['VATPercentage'];
    vATAmount = json['VATAmount'];
    typeBit = json['TypeBit'];
    subServiceQuantity = json['SubServiceQuantity'];
    bookingDate = json['BookingDate'];
    startTime = json['StartTime'];
    address = json['Address'];
    patientName = json['PatientName'];
    total = json['Total'];
    discountType = json['DiscountType'];
    discount = json['Discount'];
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
    data['Status'] = status;
    data['StatusValue'] = statusValue;
    data['VATPercentage'] = vATPercentage;
    data['VATAmount'] = vATAmount;
    data['TypeBit'] = typeBit;
    data['SubServiceQuantity'] = subServiceQuantity;
    data['BookingDate'] = bookingDate;
    data['StartTime'] = startTime;
    data['Address'] = address;
    data['PatientName'] = patientName;
    data['Total'] = total;
    data['DiscountType'] = discountType;
    data['Discount'] = discount;
    return data;
  }
}
