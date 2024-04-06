class PatientData {
  int? status;
  String? id;
  String? cNICNumber;
  String? mRNo;
  dynamic identityType;
  String? name;
  String? identityTypeName;
  String? patientTypeName;
  String? patientTypeId;
  String? personTitleId;
  String? title;
  dynamic prefix;
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  String? genderId;
  dynamic relationshipTypeId;
  dynamic relationshipTypeName;
  dynamic guardianName;
  String? maritalStatusId;
  String? maritalStatus;
  String? dateOfBirth;
  dynamic referenceId;
  dynamic picturePath;
  String? country;
  String? countryId;
  String? stateOrProvince;
  String? stateOrProvinceId;
  String? city;
  String? cityId;
  String? address;
  String? cellNumber;
  void telephoneNumber;
  String? email;
  void occupationId;
  void occupation;
  void nOKFirstName;
  void nOKLastName;
  void nOKRelation;
  void nOKRelationId;
  void nOKCNICNumber;
  void nOKCellNumber;
  void bloodGroup;
  void bloodGroupId;
  String? age;
  void latitude;
  void longitude;

  PatientData(
      {this.status,
      this.id,
      this.cNICNumber,
      this.mRNo,
      this.identityType,
      this.name,
      this.identityTypeName,
      this.patientTypeName,
      this.patientTypeId,
      this.personTitleId,
      this.title,
      this.prefix,
      this.firstName,
      this.middleName,
      this.lastName,
      this.gender,
      this.genderId,
      this.relationshipTypeId,
      this.relationshipTypeName,
      this.guardianName,
      this.maritalStatusId,
      this.maritalStatus,
      this.dateOfBirth,
      this.referenceId,
      this.picturePath,
      this.country,
      this.countryId,
      this.stateOrProvince,
      this.stateOrProvinceId,
      this.city,
      this.cityId,
      this.address,
      this.cellNumber,
      this.telephoneNumber,
      this.email,
      this.occupationId,
      this.occupation,
      this.nOKFirstName,
      this.nOKLastName,
      this.nOKRelation,
      this.nOKRelationId,
      this.nOKCNICNumber,
      this.nOKCellNumber,
      this.bloodGroup,
      this.bloodGroupId,
      this.age,
      this.latitude,
      this.longitude});

  PatientData.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    id = json['Id'];
    cNICNumber = json['CNICNumber'];
    mRNo = json['MRNo'];
    identityType = json['IdentityType'];
    name = json['Name'];
    identityTypeName = json['IdentityTypeName'];
    patientTypeName = json['PatientTypeName'];
    patientTypeId = json['PatientTypeId'];
    personTitleId = json['PersonTitleId'];
    title = json['Title'];
    prefix = json['Prefix'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    gender = json['Gender'];
    genderId = json['GenderId'];
    relationshipTypeId = json['RelationshipTypeId'];
    relationshipTypeName = json['RelationshipTypeName'];
    guardianName = json['GuardianName'];
    maritalStatusId = json['MaritalStatusId'];
    maritalStatus = json['MaritalStatus'];
    dateOfBirth = json['DateOfBirth'];
    referenceId = json['ReferenceId'];
    picturePath = json['PicturePath'];
    country = json['Country'];
    countryId = json['CountryId'];
    stateOrProvince = json['StateOrProvince'];
    stateOrProvinceId = json['StateOrProvinceId'];
    city = json['City'];
    cityId = json['CityId'];
    address = json['Address'];
    cellNumber = json['CellNumber'];
    telephoneNumber = json['TelephoneNumber'];
    email = json['Email'];
    occupationId = json['OccupationId'];
    occupation = json['Occupation'];
    nOKFirstName = json['NOKFirstName'];
    nOKLastName = json['NOKLastName'];
    nOKRelation = json['NOKRelation'];
    nOKRelationId = json['NOKRelationId'];
    nOKCNICNumber = json['NOKCNICNumber'];
    nOKCellNumber = json['NOKCellNumber'];
    bloodGroup = json['BloodGroup'];
    bloodGroupId = json['BloodGroupId'];
    age = json['Age'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Id'] = id;
    data['CNICNumber'] = cNICNumber;
    data['MRNo'] = mRNo;
    data['IdentityType'] = identityType;
    data['Name'] = name;
    data['IdentityTypeName'] = identityTypeName;
    data['PatientTypeName'] = patientTypeName;
    data['PatientTypeId'] = patientTypeId;
    data['PersonTitleId'] = personTitleId;
    data['Title'] = title;
    data['Prefix'] = prefix;
    data['FirstName'] = firstName;
    data['MiddleName'] = middleName;
    data['LastName'] = lastName;
    data['Gender'] = gender;
    data['GenderId'] = genderId;
    data['RelationshipTypeId'] = relationshipTypeId;
    data['RelationshipTypeName'] = relationshipTypeName;
    data['GuardianName'] = guardianName;
    data['MaritalStatusId'] = maritalStatusId;
    data['MaritalStatus'] = maritalStatus;
    data['DateOfBirth'] = dateOfBirth;
    data['ReferenceId'] = referenceId;
    data['PicturePath'] = picturePath;
    data['Country'] = country;
    data['CountryId'] = countryId;
    data['StateOrProvince'] = stateOrProvince;
    data['StateOrProvinceId'] = stateOrProvinceId;
    data['City'] = city;
    data['CityId'] = cityId;
    data['Address'] = address;
    data['CellNumber'] = cellNumber;
    // data['TelephoneNumber'] = telephoneNumber;
    data['Email'] = email;
    // data['OccupationId'] = occupationId;
    // data['Occupation'] = occupation;
    // data['NOKFirstName'] = nOKFirstName;
    // data['NOKLastName'] = nOKLastName;
    // data['NOKRelation'] = nOKRelation;
    // data['NOKRelationId'] = nOKRelationId;
    // data['NOKCNICNumber'] = nOKCNICNumber;
    // data['NOKCellNumber'] = nOKCellNumber;
    // data['BloodGroup'] = bloodGroup;
    // data['BloodGroupId'] = bloodGroupId;
    // data['Age'] = age;
    // data['Latitude'] = latitude;
    // data['Longitude'] = longitude;
    return data;
  }
}
