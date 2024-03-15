class PatientRegistrationModal {
  String? firstName;
  String? middleName;
  String? lastName;
  String? guardianName;
  String? CNICNumber;
  String? otherIdentity;
  String? passport;
  String? identityRelation;
  String? dateOfBirth;
  String? address;
  String? cellNumber;
  String? telephoneNumber;
  String? email;
  String? nOKFirstName;
  String? nOKLastName;
  String? nOKCNICNumber;
  String? nOKCellNumber;
  String? picturePath;
  String? panelEntitleLetter;
  String? panelEntitleLetterB;
  String? occupationId;
  String? panelOrganizationPackageId;
  String? genderId;
  String? relationshipTypeId;
  String? personTitleId;
  String? patientTypeId;
  String? maritalStatusId;
  String? bloodGroupId;
  String? countryId;
  String? stateOrProvinceId;
  String? cityId;
  String? nOKRelationId;
  String? prefix;
  String? identityTypeId;
  String? organizationId;
  String? branchId;
  String? referenceId;
  String? panelOrganizationId;
  String? panelType;
  String? panelValidDate;
  String? panelEmployeeCardNo;
  String? panelDepartment;
  String? panelDesignation;
  String? panelRelation;
  String? panelEmployeeCardNoDependent;
  String? onPanelValidDate;
  String? onPanelEmployeeNo;
  String? onPanelDepartment;
  String? onPanelDesignation;
  String? onPanelRelationId;
  String? onPanelOrganizationId;
  String? onPanelOrganizationPackageId;
  String? onPanelEmployeeCardNoDependent;
  String? isTakeRegistrationFee;
  String? workingSessionId;
  String? patientAppointmentId;
  String? discountType;
  String? discount;
  String? reference;
  String? remarks;
  String? dependentStatus;
  String? password;
  String? confirmPassword;

  PatientRegistrationModal(
      {this.firstName,
        this.middleName,
        this.lastName,
        this.guardianName,
        this.CNICNumber,
        this.otherIdentity,
        this.passport,
        this.identityRelation,
        this.dateOfBirth,
        this.address,
        this.cellNumber,
        this.telephoneNumber,
        this.email,
        this.nOKFirstName,
        this.nOKLastName,
        this.nOKCNICNumber,
        this.nOKCellNumber,
        this.picturePath,
        this.panelEntitleLetter,
        this.panelEntitleLetterB,
        this.occupationId,
        this.panelOrganizationPackageId,
        this.genderId,
        this.relationshipTypeId,
        this.personTitleId,
        this.patientTypeId,
        this.maritalStatusId,
        this.bloodGroupId,
        this.countryId,
        this.stateOrProvinceId,
        this.cityId,
        this.nOKRelationId,
        this.prefix,
        this.identityTypeId,
        this.organizationId,
        this.branchId,
        this.referenceId,
        this.panelOrganizationId,
        this.panelType,
        this.panelValidDate,
        this.panelEmployeeCardNo,
        this.panelDepartment,
        this.panelDesignation,
        this.panelRelation,
        this.panelEmployeeCardNoDependent,
        this.onPanelValidDate,
        this.onPanelEmployeeNo,
        this.onPanelDepartment,
        this.onPanelDesignation,
        this.onPanelRelationId,
        this.onPanelOrganizationId,
        this.onPanelOrganizationPackageId,
        this.onPanelEmployeeCardNoDependent,
        this.isTakeRegistrationFee,
        this.workingSessionId,
        this.patientAppointmentId,
        this.discountType,
        this.discount,
        this.reference,
        this.remarks,
        this.dependentStatus,
        this.password,
        this.confirmPassword});

  PatientRegistrationModal.fromJson(Map<String, dynamic> json) {
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    guardianName = json['GuardianName'];
    CNICNumber = json['CNICNumber'];
    otherIdentity = json['OtherIdentity'];
    passport = json['Passport'];
    identityRelation = json['IdentityRelation'];
    dateOfBirth = json['DateOfBirth'];
    address = json['Address'];
    cellNumber = json['CellNumber'];
    telephoneNumber = json['TelephoneNumber'];
    email = json['Email'];
    nOKFirstName = json['NOKFirstName'];
    nOKLastName = json['NOKLastName'];
    nOKCNICNumber = json['NOKCNICNumber'];
    nOKCellNumber = json['NOKCellNumber'];
    picturePath = json['PicturePath'];
    panelEntitleLetter = json['PanelEntitleLetter'];
    panelEntitleLetterB = json['PanelEntitleLetterB'];
    occupationId = json['OccupationId'];
    panelOrganizationPackageId = json['PanelOrganizationPackageId'];
    genderId = json['GenderId'];
    relationshipTypeId = json['RelationshipTypeId'];
    personTitleId = json['PersonTitleId'];
    patientTypeId = json['PatientTypeId'];
    maritalStatusId = json['MaritalStatusId'];
    bloodGroupId = json['BloodGroupId'];
    countryId = json['CountryId'];
    stateOrProvinceId = json['StateOrProvinceId'];
    cityId = json['CityId'];
    nOKRelationId = json['NOKRelationId'];
    prefix = json['Prefix'];
    identityTypeId = json['IdentityTypeId'];
    organizationId = json['OrganizationId'];
    branchId = json['BranchId'];
    referenceId = json['ReferenceId'];
    panelOrganizationId = json['PanelOrganizationId'];
    panelType = json['PanelType'];
    panelValidDate = json['PanelValidDate'];
    panelEmployeeCardNo = json['PanelEmployeeCardNo'];
    panelDepartment = json['PanelDepartment'];
    panelDesignation = json['PanelDesignation'];
    panelRelation = json['PanelRelation'];
    panelEmployeeCardNoDependent = json['PanelEmployeeCardNoDependent'];
    onPanelValidDate = json['OnPanelValidDate'];
    onPanelEmployeeNo = json['OnPanelEmployeeNo'];
    onPanelDepartment = json['OnPanelDepartment'];
    onPanelDesignation = json['OnPanelDesignation'];
    onPanelRelationId = json['OnPanelRelationId'];
    onPanelOrganizationId = json['OnPanelOrganizationId'];
    onPanelOrganizationPackageId = json['OnPanelOrganizationPackageId'];
    onPanelEmployeeCardNoDependent = json['OnPanelEmployeeCardNoDependent'];
    isTakeRegistrationFee = json['IsTakeRegistrationFee'];
    workingSessionId = json['WorkingSessionId'];
    patientAppointmentId = json['PatientAppointmentId'];
    discountType = json['DiscountType'];
    discount = json['Discount'];
    reference = json['Reference'];
    remarks = json['Remarks'];
    dependentStatus = json['DependentStatus'];
    password = json['Password'];
    confirmPassword = json['ConfirmPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FirstName'] = firstName;
    data['MiddleName'] = middleName;
    data['LastName'] = lastName;
    data['GuardianName'] = guardianName;
    data['CNICNumber'] = CNICNumber;
    data['OtherIdentity'] = otherIdentity;
    data['Passport'] = passport;
    data['IdentityRelation'] = identityRelation;
    data['DateOfBirth'] = dateOfBirth;
    data['Address'] = address;
    data['CellNumber'] = cellNumber;
    data['TelephoneNumber'] = telephoneNumber;
    data['Email'] = email;
    data['NOKFirstName'] = nOKFirstName;
    data['NOKLastName'] = nOKLastName;
    data['NOKCNICNumber'] = nOKCNICNumber;
    data['NOKCellNumber'] = nOKCellNumber;
    data['PicturePath'] = picturePath;
    data['PanelEntitleLetter'] = panelEntitleLetter;
    data['PanelEntitleLetterB'] = panelEntitleLetterB;
    data['OccupationId'] = occupationId;
    data['PanelOrganizationPackageId'] = panelOrganizationPackageId;
    data['GenderId'] = genderId;
    data['RelationshipTypeId'] = relationshipTypeId;
    data['PersonTitleId'] = personTitleId;
    data['PatientTypeId'] = patientTypeId;
    data['MaritalStatusId'] = maritalStatusId;
    data['BloodGroupId'] = bloodGroupId;
    data['CountryId'] = countryId;
    data['StateOrProvinceId'] = stateOrProvinceId;
    data['CityId'] = cityId;
    data['NOKRelationId'] = nOKRelationId;
    data['Prefix'] = prefix;
    data['IdentityTypeId'] = identityTypeId;
    data['OrganizationId'] = organizationId;
    data['BranchId'] = branchId;
    data['ReferenceId'] = referenceId;
    data['PanelOrganizationId'] = panelOrganizationId;
    data['PanelType'] = panelType;
    data['PanelValidDate'] = panelValidDate;
    data['PanelEmployeeCardNo'] = panelEmployeeCardNo;
    data['PanelDepartment'] = panelDepartment;
    data['PanelDesignation'] = panelDesignation;
    data['PanelRelation'] = panelRelation;
    data['PanelEmployeeCardNoDependent'] = panelEmployeeCardNoDependent;
    data['OnPanelValidDate'] = onPanelValidDate;
    data['OnPanelEmployeeNo'] = onPanelEmployeeNo;
    data['OnPanelDepartment'] = onPanelDepartment;
    data['OnPanelDesignation'] = onPanelDesignation;
    data['OnPanelRelationId'] = onPanelRelationId;
    data['OnPanelOrganizationId'] = onPanelOrganizationId;
    data['OnPanelOrganizationPackageId'] = onPanelOrganizationPackageId;
    data['OnPanelEmployeeCardNoDependent'] =
        onPanelEmployeeCardNoDependent;
    data['IsTakeRegistrationFee'] = isTakeRegistrationFee;
    data['WorkingSessionId'] = workingSessionId;
    data['PatientAppointmentId'] = patientAppointmentId;
    data['DiscountType'] = discountType;
    data['Discount'] = discount;
    data['Reference'] = reference;
    data['Remarks'] = remarks;
    data['DependentStatus'] = dependentStatus;
    data['Password'] = password;
    data['ConfirmPassword'] = confirmPassword;
    return data;
  }
}