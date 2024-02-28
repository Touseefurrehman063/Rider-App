// ignore_for_file: camel_case_types

class vehicle {
  String? id;
  String? name;
  String? type;
  String? description;

  vehicle({this.id, this.name, this.type, this.description});

  vehicle.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    type = json['Type'];
    description = json['Description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Type'] = type;
    data['Description'] = description;
    return data;
  }
}
