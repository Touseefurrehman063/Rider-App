class Labtest {
  dynamic id;
  dynamic name;
  dynamic price;
  dynamic actualPrice;
  dynamic isForSampleCollectionCharges;
  dynamic isForAdditionalCharges;
  dynamic isForUrgentCharges;
  dynamic isAdditionalChargesForPassenger;
  dynamic isForCovid;
  dynamic isForAdditionalChargesForCovid;
  dynamic vATPercentageAmount;

  Labtest(
      {this.id,
      this.name,
      this.price,
      this.actualPrice,
      this.isForSampleCollectionCharges,
      this.isForAdditionalCharges,
      this.isForUrgentCharges,
      this.isAdditionalChargesForPassenger,
      this.isForCovid,
      this.isForAdditionalChargesForCovid,
      this.vATPercentageAmount});

  Labtest.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    price = json['Price'];
    actualPrice = json['ActualPrice'];
    isForSampleCollectionCharges = json['IsForSampleCollectionCharges'];
    isForAdditionalCharges = json['IsForAdditionalCharges'];
    isForUrgentCharges = json['IsForUrgentCharges'];
    isAdditionalChargesForPassenger = json['IsAdditionalChargesForPassenger'];
    isForCovid = json['IsForCovid'];
    isForAdditionalChargesForCovid = json['IsForAdditionalChargesForCovid'];
    vATPercentageAmount = json['VATPercentageAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['Price'] = price;
    data['ActualPrice'] = actualPrice;
    data['IsForSampleCollectionCharges'] = isForSampleCollectionCharges;
    data['IsForAdditionalCharges'] = isForAdditionalCharges;
    data['IsForUrgentCharges'] = isForUrgentCharges;
    data['IsAdditionalChargesForPassenger'] =
        isAdditionalChargesForPassenger;
    data['IsForCovid'] = isForCovid;
    data['IsForAdditionalChargesForCovid'] =
        isForAdditionalChargesForCovid;
    data['VATPercentageAmount'] = vATPercentageAmount;
    return data;
  }
}
