class LabsModel {
 dynamic id;
 dynamic userId;
 dynamic name;
 dynamic permissionValue;
 dynamic taxPercentage;
 dynamic isOnlinePayment;
 dynamic latitude;
 dynamic longitude;
 dynamic address;

  LabsModel(
      {this.id,
      this.userId,
      this.name,
      this.permissionValue,
      this.taxPercentage,
      this.isOnlinePayment,
      this.latitude,
      this.longitude,
      this.address});

  LabsModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userId = json['UserId'];
    name = json['Name'];
    permissionValue = json['PermissionValue'];
    taxPercentage = json['TaxPercentage'];
    isOnlinePayment = json['IsOnlinePayment'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    address = json['Address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['UserId'] = userId;
    data['Name'] = name;
    data['PermissionValue'] = permissionValue;
    data['TaxPercentage'] = taxPercentage;
    data['IsOnlinePayment'] = isOnlinePayment;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['Address'] = address;
    return data;
  }
}
