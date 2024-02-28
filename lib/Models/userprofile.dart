// ignore_for_file: camel_case_types

class userProfile {
  String? id;
  String? cNICNumber;
  String? email;
  String? username;
  String? fullName;
  String? firstName;
  String? middleName;
  String? lastName;
  String? branchId;
  int? status;
  String? errorMessage;
  String? workingSessionId;
  String? countryId;
  String? cityId;
  String? stateOrProvinceId;
  String? districtId;
  String? organizationId;
  String? cellNumber;
  String? telephoneNumber;
  String? userAddress;
  String? imagePath;
  String? userDisplayDesignation;
  String? designations;
  String? employeeNumber;
  String? token;
  String? vehicleTypeId;
  String? vehicleNumber;
  String? licenseNo;
  String? vehicleTypeName;
  String? dateofBirth;

  userProfile(
      {this.id,
      this.cNICNumber,
      this.email,
      this.username,
      this.fullName,
      this.firstName,
      this.middleName,
      this.lastName,
      this.branchId,
      this.status,
      this.errorMessage,
      this.workingSessionId,
      this.countryId,
      this.cityId,
      this.stateOrProvinceId,
      this.districtId,
      this.organizationId,
      this.cellNumber,
      this.telephoneNumber,
      this.userAddress,
      this.imagePath,
      this.userDisplayDesignation,
      this.designations,
      this.employeeNumber,
      this.token,
      this.vehicleTypeId,
      this.vehicleNumber = "",
      this.licenseNo,
      this.vehicleTypeName,
      this.dateofBirth = ""});

  userProfile.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    cNICNumber = json['CNICNumber'];
    email = json['Email'];
    username = json['Username'];
    fullName = json['FullName'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    branchId = json['BranchId'];
    status = json['Status'];
    errorMessage = json['ErrorMessage'];
    workingSessionId = json['WorkingSessionId'];
    countryId = json['CountryId'];
    cityId = json['CityId'];
    stateOrProvinceId = json['StateOrProvinceId'];
    districtId = json['DistrictId'];
    organizationId = json['OrganizationId'];
    cellNumber = json['CellNumber'];
    telephoneNumber = json['TelephoneNumber'];
    userAddress = json['UserAddress'];
    imagePath = json['ImagePath'];
    userDisplayDesignation = json['UserDisplayDesignation'];
    designations = json['Designations'];
    employeeNumber = json['EmployeeNumber'];
    token = json['Token'];
    vehicleTypeId = json['VehicleTypeId'];
    vehicleNumber = json['VehicleNumber'];
    licenseNo = json['LicenseNo'];
    vehicleTypeName = json['VehicleTypeName'];
    dateofBirth = json['DateofBirth'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['CNICNumber'] = cNICNumber;
    data['Email'] = email;
    data['Username'] = username;
    data['FullName'] = fullName;
    data['FirstName'] = firstName;
    data['MiddleName'] = middleName;
    data['LastName'] = lastName;
    data['BranchId'] = branchId;
    data['Status'] = status;
    data['ErrorMessage'] = errorMessage;
    data['WorkingSessionId'] = workingSessionId;
    data['CountryId'] = countryId;
    data['CityId'] = cityId;
    data['StateOrProvinceId'] = stateOrProvinceId;
    data['DistrictId'] = districtId;
    data['OrganizationId'] = organizationId;
    data['CellNumber'] = cellNumber;
    data['TelephoneNumber'] = telephoneNumber;
    data['UserAddress'] = userAddress;
    data['ImagePath'] = imagePath;
    data['UserDisplayDesignation'] = userDisplayDesignation;
    data['Designations'] = designations;
    data['EmployeeNumber'] = employeeNumber;
    data['Token'] = token;
    data['VehicleTypeId'] = vehicleTypeId;
    data['VehicleNumber'] = vehicleNumber;
    data['LicenseNo'] = licenseNo;
    data['VehicleTypeName'] = vehicleTypeName;
    data['DateofBirth'] = dateofBirth;
    return data;
  }
}
