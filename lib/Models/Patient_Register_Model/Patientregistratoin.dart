class PatientRegister {
  String? firstName;
  String? cNICNumber;
  String? dateOfBirth;
  String? address;
  String? cellNumber;
  String? telephoneNumber;
  String? email;
  String? genderId;
  String? countryId;
  String? stateOrProvinceId;
  String? cityId;
  String? relationshipTypeId;
  String? identityRelation;
  String? password;
  String? confirmPassword;

  PatientRegister(
      {this.firstName,
      this.cNICNumber,
      this.dateOfBirth,
      this.address,
      this.cellNumber,
      this.telephoneNumber,
      this.email,
      this.genderId,
      this.countryId,
      this.stateOrProvinceId,
      this.cityId,
      this.relationshipTypeId,
      this.identityRelation,
      this.password,
      this.confirmPassword});

  PatientRegister.fromJson(Map<String, dynamic> json) {
    firstName = json['FirstName'];
    cNICNumber = json['CNICNumber'];
    dateOfBirth = json['DateOfBirth'];
    address = json['Address'];
    cellNumber = json['CellNumber'];
    telephoneNumber = json['TelephoneNumber'];
    email = json['Email'];
    genderId = json['GenderId'];
    countryId = json['CountryId'];
    stateOrProvinceId = json['StateOrProvinceId'];
    cityId = json['CityId'];
    relationshipTypeId = json['RelationshipTypeId'];
    identityRelation = json['IdentityRelation'];
    password = json['Password'];
    confirmPassword = json['ConfirmPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FirstName'] = this.firstName;
    data['CNICNumber'] = this.cNICNumber;
    data['DateOfBirth'] = this.dateOfBirth;
    data['Address'] = this.address;
    data['CellNumber'] = this.cellNumber;
    data['TelephoneNumber'] = this.telephoneNumber;
    data['Email'] = this.email;
    data['GenderId'] = this.genderId;
    data['CountryId'] = this.countryId;
    data['StateOrProvinceId'] = this.stateOrProvinceId;
    data['CityId'] = this.cityId;
    data['RelationshipTypeId'] = this.relationshipTypeId;
    data['IdentityRelation'] = this.identityRelation;
    data['Password'] = this.password;
    data['ConfirmPassword'] = this.confirmPassword;
    return data;
  }
}
