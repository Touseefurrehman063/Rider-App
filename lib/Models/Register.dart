// TODO Implement this library.

class Register {
  String? id;
  String? fullName;
  String? mobileNo;
  String? email;
  String? dateOfBirth;
  String? genderId;
  String? identityNo;
  String? profilePictureImagePath;
  String? vehicleTypeId;
  String? vehicleNumber;
  String? licenseNo;
  String? password;
  String? cityId;
  String? streetNo;
  String? houseNo;
  String? address;
  String? branchId;
  String? action;
  int? isActive;
  String? title;

  Register(
      {this.id,
      this.fullName,
      this.mobileNo,
      this.email,
      this.dateOfBirth,
      this.genderId,
      this.identityNo,
      this.profilePictureImagePath,
      this.vehicleTypeId,
      this.vehicleNumber,
      this.licenseNo,
      this.password,
      this.cityId,
      this.streetNo,
      this.houseNo,
      this.address,
      this.branchId,
      this.action,
      this.isActive,
      this.title});

  Register.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['FullName'];
    mobileNo = json['MobileNo'];
    email = json['Email'];
    dateOfBirth = json['DateOfBirth'];
    genderId = json['GenderId'];
    identityNo = json['IdentityNo'];
    profilePictureImagePath = json['ProfilePictureImagePath'];
    vehicleTypeId = json['VehicleTypeId'];
    vehicleNumber = json['VehicleNumber'];
    licenseNo = json['LicenseNo'];
    password = json['Password'];
    cityId = json['CityId'];
    streetNo = json['StreetNo'];
    houseNo = json['HouseNo'];
    address = json['Address'];
    branchId = json['BranchId'];
    action = json['Action'];
    isActive = json['IsActive'];
    title = json['Title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['FullName'] = fullName;
    data['MobileNo'] = mobileNo;
    data['Email'] = email;
    data['DateOfBirth'] = dateOfBirth;
    data['GenderId'] = genderId;
    data['IdentityNo'] = identityNo;
    data['ProfilePictureImagePath'] = profilePictureImagePath;
    data['VehicleTypeId'] = vehicleTypeId;
    data['VehicleNumber'] = vehicleNumber;
    data['LicenseNo'] = licenseNo;
    data['Password'] = password;
    data['CityId'] = cityId;
    data['StreetNo'] = streetNo;
    data['HouseNo'] = houseNo;
    data['Address'] = address;
    data['BranchId'] = branchId;
    data['Action'] = action;
    data['IsActive'] = isActive;
    data['Title'] = title;
    return data;
  }
}
