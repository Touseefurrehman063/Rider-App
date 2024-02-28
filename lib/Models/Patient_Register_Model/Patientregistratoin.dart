// ignore_for_file: file_names

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FirstName'] = firstName;
    data['CNICNumber'] = cNICNumber;
    data['DateOfBirth'] = dateOfBirth;
    data['Address'] = address;
    data['CellNumber'] = cellNumber;
    data['TelephoneNumber'] = telephoneNumber;
    data['Email'] = email;
    data['GenderId'] = genderId;
    data['CountryId'] = countryId;
    data['StateOrProvinceId'] = stateOrProvinceId;
    data['CityId'] = cityId;
    data['RelationshipTypeId'] = relationshipTypeId;
    data['IdentityRelation'] = identityRelation;
    data['Password'] = password;
    data['ConfirmPassword'] = confirmPassword;
    return data;
  }
}
