class PdfModel {
  int? status;
  List<PdfData>? pdfData;
  int? totalRecord;
  int? filterRecord;

  PdfModel({this.status, this.pdfData, this.totalRecord, this.filterRecord});

  PdfModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    if (json['PdfData'] != null) {
      pdfData = <PdfData>[];
      json['PdfData'].forEach((v) {
        pdfData!.add(PdfData.fromJson(v));
      });
    }
    totalRecord = json['TotalRecord'];
    filterRecord = json['FilterRecord'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    if (pdfData != null) {
      data['PdfData'] = pdfData!.map((v) => v.toJson()).toList();
    }
    data['TotalRecord'] = totalRecord;
    data['FilterRecord'] = filterRecord;
    return data;
  }
}

class PdfData {
  String? id;
  String? name;
  dynamic filePath;
  int? start;
  int? length;

  PdfData({this.id, this.name, this.filePath, this.start, this.length});

  PdfData.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    filePath = json['FilePath'];
    start = json['start'];
    length = json['length'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['FilePath'] = filePath;
    data['start'] = start;
    data['length'] = length;
    return data;
  }

  void clear() {}
}
