class checkinresponse {
  dynamic id;
  dynamic visitNo;
  dynamic labNo;
  dynamic isInPatient;
  dynamic bedDetails;
  dynamic chatURL;
  dynamic isPreMedicalAssessmentBooking;
  dynamic labSpecimenCodeOutput;
  dynamic autoNumberGeneratedOutput;

  checkinresponse(
      {this.id,
      this.visitNo,
      this.labNo,
      this.isInPatient,
      this.bedDetails,
      this.chatURL,
      this.isPreMedicalAssessmentBooking,
      this.labSpecimenCodeOutput,
      this.autoNumberGeneratedOutput});

  checkinresponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    visitNo = json['VisitNo'];
    labNo = json['LabNo'];
    isInPatient = json['IsInPatient'];
    bedDetails = json['BedDetails'];
    chatURL = json['ChatURL'];
    isPreMedicalAssessmentBooking = json['IsPreMedicalAssessmentBooking'];
    labSpecimenCodeOutput = json['LabSpecimenCodeOutput'];
    autoNumberGeneratedOutput = json['AutoNumberGeneratedOutput'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['VisitNo'] = this.visitNo;
    data['LabNo'] = this.labNo;
    data['IsInPatient'] = this.isInPatient;
    data['BedDetails'] = this.bedDetails;
    data['ChatURL'] = this.chatURL;
    data['IsPreMedicalAssessmentBooking'] = this.isPreMedicalAssessmentBooking;
    data['LabSpecimenCodeOutput'] = this.labSpecimenCodeOutput;
    data['AutoNumberGeneratedOutput'] = this.autoNumberGeneratedOutput;
    return data;
  }
}
