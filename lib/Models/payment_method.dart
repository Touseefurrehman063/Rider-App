class   PaymentMethod {
 dynamic userId;
  dynamic  name;
  dynamic  permissionValue;
  dynamic  taxPercentage;
  dynamic  isOnlinePayment;

  PaymentMethod(
      {this.userId,
      this.name,
      this.permissionValue,
      this.taxPercentage,
      this.isOnlinePayment});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    userId = json['UserId'];
    name = json['Name'];
    permissionValue = json['PermissionValue'];
    taxPercentage = json['TaxPercentage'];
    isOnlinePayment = json['IsOnlinePayment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['UserId'] = userId;
    data['Name'] = name;
    data['PermissionValue'] = permissionValue;
    data['TaxPercentage'] = taxPercentage;
    data['IsOnlinePayment'] = isOnlinePayment;
    return data;
  }
}