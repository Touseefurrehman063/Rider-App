class ConsentModel {
  String? attachmentPath;
  String? paymentNumber;
  String? consentFormStatus;
  String? remarks;
  String? patientId;
  String? userId;
  dynamic signAttachmentPath;

  ConsentModel({
    this.attachmentPath,
    this.paymentNumber,
    this.consentFormStatus,
    this.remarks,
    this.patientId,
    this.userId,
    this.signAttachmentPath,
  });

  ConsentModel.fromJson(Map<String, dynamic> json) {
    attachmentPath = json['AttachmentPath'];
    paymentNumber = json['PaymentNumber'];
    consentFormStatus = json['ConsentFormStatus'];
    remarks = json['Remarks'];
    patientId = json['PatientId'];
    userId = json['UserId'];
    signAttachmentPath = json['SignatureAttachmentPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AttachmentPath'] = attachmentPath;
    data['PaymentNumber'] = paymentNumber;
    data['ConsentFormStatus'] = consentFormStatus;
    data['Remarks'] = remarks;
    data['PatientId'] = patientId;
    data['UserId'] = userId;
    data['SignatureAttachmentPath'] = signAttachmentPath;
    return data;
  }
}
