class LabInvestigation {
  String? patientId;
  String? labTestId;
  String? labTestName;
  String? visitNo;

  LabInvestigation(
      {this.patientId, this.labTestId, this.labTestName, this.visitNo});

  LabInvestigation.fromJson(Map<String, dynamic> json) {
    patientId = json['PatientId'];
    labTestId = json['LabTestId'];
    labTestName = json['LabTestName'];
    visitNo = json['VisitNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PatientId'] = patientId;
    data['LabTestId'] = labTestId;
    data['LabTestName'] = labTestName;
    data['VisitNo'] = visitNo;
    return data;
  }
}
