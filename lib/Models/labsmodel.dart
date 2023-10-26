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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserId'] = this.userId;
    data['Name'] = this.name;
    data['PermissionValue'] = this.permissionValue;
    data['TaxPercentage'] = this.taxPercentage;
    data['IsOnlinePayment'] = this.isOnlinePayment;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['Address'] = this.address;
    return data;
  }
}
