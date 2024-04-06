import 'package:http/http.dart' as http;

class User {
  dynamic UserName;
  dynamic Password;
  dynamic empId;
  dynamic start;
  dynamic StartDate;
  dynamic EndDate;
  dynamic patientName;
  dynamic test;
  dynamic address;
  dynamic status;
  dynamic patientid;
  dynamic message;
  dynamic ride_CancelRemarks;
  dynamic appointmentno;
  dynamic branchlocationid;
  dynamic Patientappoinmentid;
  dynamic LabNo;
  dynamic url;
  dynamic imagePath;
  dynamic cNICNumber;
  dynamic latitude;
  dynamic longitude;
  dynamic vehicleno;
  dynamic dob;
  dynamic cellNumber;
  dynamic token;
  dynamic labTestChallanNo;
  dynamic time;
  dynamic Labid;
  dynamic inroutelat;
  dynamic inroutelon;
  dynamic paymentstatusname;
  dynamic paymentstatusvalue;
  dynamic visitno;

  // New fields
  dynamic PatientServiceAppointmentId;
  dynamic StatusValue;
  dynamic MRNo;
  dynamic LabName;
  dynamic LabTestIds;
  dynamic PrescribedBy;
  dynamic Action;
  dynamic ModifiedOn;
  dynamic PrescribeByDoctorId;
  dynamic PatientTypesHtmlValue;
  dynamic FlightNo;
  dynamic FlightDate;
  dynamic AirlineId;
  dynamic FlightDestinationId;
  dynamic PassengerNameRecord;
  dynamic StatusType;
  dynamic PaymentMethodId;
  dynamic LastProcessedBy;
  dynamic LastProcessedOn;
  dynamic IsNotCompleted;
  dynamic InRouteDeliveryBranchLocationId;
  dynamic AppointmentStatusCount;
  dynamic AppointmentStatus;
  dynamic InvoiceURL;
  dynamic TypeBit;
  dynamic IsAlreadyCheckedIn;
  dynamic TotalAppointmentFee;
  dynamic referencetype;
  dynamic amount;
  dynamic discounttype;
  dynamic discount;
  dynamic totalamount;
  dynamic iscombine;
  dynamic refNo;
  String? id;
  String? mRNo;
  String? email;
  String? switchUserId;
  String? switchByUser;
  bool? isChildAccount;
  bool? isSwitchAccount;
  String? username;
  String? fullName;
  String? firstName;
  String? displayname;
  String? branchName;
  String? organizationPicturePath;
  String? branchId;
  String? branchAddress;
  String? branchTelNo;
  String? branchEmail;
  int? userType;
  String? errorMessage;
  String? workingSessionId;
  String? countryId;
  String? cityId;
  String? stateOrProvinceId;
  String? country;
  String? city;
  String? stateOrProvince;
  String? deviceToken;
  String? webToken;
  String? patientAddress;
  String? passport;
  int? isFlightDetail;
  String? workingSessions;
  String? genderName;
  String? registrationDate;
  String? panelExpiryDate;
  String? panelOrganizationName;
  String? panelPackageName;
  String? panelPackageDiscount;
  String? panelPackageDiscountType;
  String? dateofbirth;
  String? maritalStatus;

  User(
      {this.UserName,
      this.Password,
      this.empId,
      this.start,
      this.visitno,
      this.StartDate,
      this.Labid,
      this.patientName,
      this.test,
      this.EndDate,
      this.address,
      this.status,
      this.patientid,
      this.message,
      this.ride_CancelRemarks,
      this.appointmentno,
      this.branchlocationid,
      this.Patientappoinmentid,
      this.LabNo,
      this.url,
      this.imagePath,
      this.cNICNumber,
      this.latitude,
      this.longitude,
      this.vehicleno,
      this.dob,
      this.cellNumber,
      this.token,
      this.labTestChallanNo,
      this.time,
      this.inroutelat,
      this.inroutelon,
      this.paymentstatusname,
      this.paymentstatusvalue,
      // New fields
      this.PatientServiceAppointmentId,
      this.StatusValue,
      this.MRNo,
      this.LabName,
      this.LabTestIds,
      this.PrescribedBy,
      this.Action,
      this.ModifiedOn,
      this.PrescribeByDoctorId,
      this.PatientTypesHtmlValue,
      this.FlightNo,
      this.FlightDate,
      this.AirlineId,
      this.FlightDestinationId,
      this.PassengerNameRecord,
      this.StatusType,
      this.PaymentMethodId,
      this.LastProcessedBy,
      this.LastProcessedOn,
      this.IsNotCompleted,
      this.InRouteDeliveryBranchLocationId,
      this.AppointmentStatusCount,
      this.AppointmentStatus,
      this.InvoiceURL,
      this.TypeBit,
      this.IsAlreadyCheckedIn,
      this.TotalAppointmentFee,
      this.referencetype,
      this.amount,
      this.discount,
      this.discounttype,
      this.iscombine,
      this.totalamount,
      this.refNo,
      //new
      this.id,
      this.mRNo,
      this.email,
      this.switchUserId,
      this.switchByUser,
      this.isChildAccount,
      this.isSwitchAccount,
      this.username,
      this.fullName,
      this.firstName,
      this.displayname,
      this.branchName,
      this.organizationPicturePath,
      this.branchId,
      this.branchAddress,
      this.branchTelNo,
      this.branchEmail,
      this.userType,
      this.errorMessage,
      this.workingSessionId,
      this.countryId,
      this.cityId,
      this.stateOrProvinceId,
      this.country,
      this.city,
      this.stateOrProvince,
      this.deviceToken,
      this.webToken,
      this.patientAddress,
      this.passport,
      this.isFlightDetail,
      this.workingSessions,
      this.genderName,
      this.registrationDate,
      this.panelExpiryDate,
      this.panelOrganizationName,
      this.panelPackageName,
      this.panelPackageDiscount,
      this.panelPackageDiscountType,
      this.dateofbirth,
      this.maritalStatus});

  User.fromJson(Map<String, dynamic> json) {
    // Existing fields
    UserName = json["UserName"];
    Password = json["Password"];
    empId = json["UserId"];
    Labid = json["LabId"];
    visitno = json['VisitNo'];
    StartDate = json["BookingDate"];
    start = json["start"];
    EndDate = json["EndDate"];
    patientName = json["PatientName"];
    test = json["LabTest"];
    address = json["PickupAddress"];
    status = json["Status"];
    patientid = json["PatientId"];
    message = json["Message"];
    ride_CancelRemarks = json["RideCancelRemarks"];
    appointmentno = json["AppointmentNo"];
    branchlocationid = json["BranchLocationId"];
    Patientappoinmentid = json["PatientAppointmentId"];
    LabNo = json["LabNo"];
    url = json["RiderLocationURL"];
    imagePath = json["ImagePath"];
    cNICNumber = json["CNICNumber"];
    latitude = json["Latitude"];
    longitude = json["Longitude"];
    vehicleno = json["VehicleNumber"];
    dob = json["DateofBirth"];
    cellNumber = json["CellNumber"];
    token = json["Token"];
    labTestChallanNo = json['LabTestChallanNo'];
    time = json['Time'];
    inroutelat = json['InRouteLatitude'];
    inroutelon = json['InRouteLongitude'];
    paymentstatusname = json['PaymentStatusName'];
    paymentstatusvalue = json['PaymentStatusValue'];

    // New fields
    PatientServiceAppointmentId = json['PatientServiceAppointmentId'];
    StatusValue = json['StatusValue'];
    MRNo = json['MRNo'];
    LabName = json['LabName'];
    LabTestIds = json['LabTestIds'];
    PrescribedBy = json['PrescribedBy'];
    Action = json['Action'];
    ModifiedOn = json['ModifiedOn'];
    PrescribeByDoctorId = json['PrescribeByDoctorId'];
    PatientTypesHtmlValue = json['PatientTypesHtmlValue'];
    FlightNo = json['FlightNo'];
    FlightDate = json['FlightDate'];
    AirlineId = json['AirlineId'];
    FlightDestinationId = json['FlightDestinationId'];
    PassengerNameRecord = json['PassengerNameRecord'];
    StatusType = json['StatusType'];
    PaymentMethodId = json['PaymentMethodId'];
    LastProcessedBy = json['LastProcessedBy'];
    LastProcessedOn = json['LastProcessedOn'];
    IsNotCompleted = json['IsNotCompleted'];
    InRouteDeliveryBranchLocationId = json['InRouteDeliveryBranchLocationId'];
    AppointmentStatusCount = json['AppointmentStatusCount'];
    AppointmentStatus = json['AppointmentStatus'];
    InvoiceURL = json['InvoiceURL'];
    TypeBit = json['TypeBit'];
    IsAlreadyCheckedIn = json['IsAlreadyCheckedIn'];
    TotalAppointmentFee = json['TotalAppointmentFee'];
    referencetype = json['ReferenceType'];
    amount = json['Amount'];
    refNo = json['ReferenceNumber'];
    discounttype = json['DiscountType'];
    discount = json['Discount'];
    totalamount = json['Total'];
    iscombine = json['IsCombineMultiServices'];

    //new
    id = json['Id'];
    mRNo = json['MRNo'];
    cNICNumber = json['CNICNumber'];
    email = json['Email'];
    switchUserId = json['SwitchUserId'];
    switchByUser = json['SwitchByUser'];
    isChildAccount = json['IsChildAccount'];
    isSwitchAccount = json['IsSwitchAccount'];
    username = json['Username'];
    fullName = json['FullName'];
    firstName = json['FirstName'];
    displayname = json['Displayname'];
    branchName = json['BranchName'];

    organizationPicturePath = json['OrganizationPicturePath'];
    branchId = json['BranchId'];
    branchAddress = json['BranchAddress'];
    branchTelNo = json['BranchTelNo'];
    branchEmail = json['BranchEmail'];
    userType = json['UserType'];
    token = json['Token'];
    status = json['Status'];
    errorMessage = json['ErrorMessage'];
    workingSessionId = json['WorkingSessionId'];
    countryId = json['CountryId'];
    cityId = json['CityId'];
    stateOrProvinceId = json['StateOrProvinceId'];
    country = json['Country'];
    city = json['City'];
    stateOrProvince = json['StateOrProvince'];
    deviceToken = json['DeviceToken'];
    webToken = json['WebToken'];
    cellNumber = json['CellNumber'];
    patientAddress = json['PatientAddress'];
    passport = json['Passport'];
    isFlightDetail = json['IsFlightDetail'];
    maritalStatus = json['MaritalStatus'];
    workingSessions = json['WorkingSessions'];
    genderName = json['GenderName'] ?? 'Male';
    registrationDate = json['RegistrationDate'];
    panelExpiryDate = json['PanelExpiryDate'];
    panelOrganizationName = json['PanelOrganizationName'];
    panelPackageName = json['PanelPackageName'];
    panelPackageDiscount = json['PanelPackageDiscount'].toString();
    panelPackageDiscountType = json['PanelPackageDiscountType'];
    // address = json['Address'];
    dateofbirth = json['DateOfBirth'];
  }

  Map<String, dynamic> toJson(http.Response response) {
    final Map<String, dynamic> data = <String, dynamic>{};
    // Existing fields
    data['UserName'] = UserName;
    data['Password'] = Password;
    data['UserId'] = empId;
    data['start'] = start;
    data['BookingDate'] = StartDate;
    data['EndDate'] = EndDate;
    data['PatientName'] = patientName;
    data['LabTest'] = test;
    data['PickupAddress'] = address;
    data['Status'] = status;
    data['VisitNo'] = visitno;
    data['PatientId'] = patientid;
    data['Message'] = message;
    data['RideCancelRemarks'] = ride_CancelRemarks;
    data['AppointmentNo'] = appointmentno;
    data['BranchLocationId'] = branchlocationid;
    data['PatientAppointmentId'] = Patientappoinmentid;
    data['LabNo'] = LabNo;
    data['LabId'] = Labid;
    data['RiderLocationURL'] = url;
    data['ImagePath'] = imagePath;
    data['CNICNumber'] = cNICNumber;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['VehicleNumber'] = vehicleno;
    data['DateofBirth'] = dob;
    data['CellNumber'] = cellNumber;
    data['Token'] = token;
    data['LabTestChallanNo'] = labTestChallanNo;
    data['Time'] = time;
    data['InRouteLatitude'] = inroutelat;
    data['InRouteLongitude'] = inroutelon;
    data['PaymentStatusName'] = paymentstatusname;
    data['PaymentStatusValue'] = paymentstatusvalue;

    // New fields
    data['PatientServiceAppointmentId'] = PatientServiceAppointmentId;
    data['StatusValue'] = StatusValue;
    data['MRNo'] = MRNo;
    data['LabName'] = LabName;
    data['LabTestIds'] = LabTestIds;
    data['PrescribedBy'] = PrescribedBy;
    data['Action'] = Action;
    data['ModifiedOn'] = ModifiedOn;
    data['PrescribeByDoctorId'] = PrescribeByDoctorId;
    data['PatientTypesHtmlValue'] = PatientTypesHtmlValue;
    data['FlightNo'] = FlightNo;
    data['FlightDate'] = FlightDate;
    data['AirlineId'] = AirlineId;
    data['FlightDestinationId'] = FlightDestinationId;
    data['PassengerNameRecord'] = PassengerNameRecord;
    data['StatusType'] = StatusType;
    data['PaymentMethodId'] = PaymentMethodId;
    data['LastProcessedBy'] = LastProcessedBy;
    data['LastProcessedOn'] = LastProcessedOn;
    data['IsNotCompleted'] = IsNotCompleted;
    data['InRouteDeliveryBranchLocationId'] = InRouteDeliveryBranchLocationId;
    data['AppointmentStatusCount'] = AppointmentStatusCount;
    data['AppointmentStatus'] = AppointmentStatus;
    data['InvoiceURL'] = InvoiceURL;
    data['TypeBit'] = TypeBit;
    data['IsAlreadyCheckedIn'] = IsAlreadyCheckedIn;
    data['TotalAppointmentFee'] = TotalAppointmentFee;
    data['ReferenceType'] = referencetype;
    data['ReferenceNumber'] = refNo;
    data['Amount'] = amount;
    data['DiscountType'] = discounttype;
    data['Discount'] = discount;
    data['Total'] = totalamount;
    data['IsCombineMultiServices'] = iscombine;
    data['Id'] = id;
    data['MRNo'] = mRNo;
    data['CNICNumber'] = cNICNumber;
    data['Email'] = email;
    data['SwitchUserId'] = switchUserId;
    data['SwitchByUser'] = switchByUser;
    data['IsChildAccount'] = isChildAccount;
    data['IsSwitchAccount'] = isSwitchAccount;
    data['Username'] = username;
    data['FullName'] = fullName;
    data['FirstName'] = firstName;
    data['Displayname'] = displayname;
    data['BranchName'] = branchName;
    data['ImagePath'] = imagePath;
    data['OrganizationPicturePath'] = organizationPicturePath;
    data['BranchId'] = branchId;
    data['BranchAddress'] = branchAddress;
    data['BranchTelNo'] = branchTelNo;
    data['BranchEmail'] = branchEmail;
    data['UserType'] = userType;
    data['Token'] = token;
    data['Status'] = status;
    data['ErrorMessage'] = errorMessage;
    data['WorkingSessionId'] = workingSessionId;
    data['CountryId'] = countryId;
    data['CityId'] = cityId;
    data['StateOrProvinceId'] = stateOrProvinceId;
    data['Country'] = country;
    data['City'] = city;
    data['StateOrProvince'] = stateOrProvince;
    data['DeviceToken'] = deviceToken;
    data['WebToken'] = webToken;
    data['CellNumber'] = cellNumber;
    data['PatientAddress'] = patientAddress;
    data['Passport'] = passport;
    data['IsFlightDetail'] = isFlightDetail;
    data['WorkingSessions'] = workingSessions;
    data['MaritalStatus'] = maritalStatus;

    data['GenderName'] = genderName;
    data['RegistrationDate'] = registrationDate;
    data['PanelExpiryDate'] = panelExpiryDate;
    data['PanelOrganizationName'] = panelOrganizationName;
    data['PanelPackageName'] = panelPackageName;
    data['PanelPackageDiscount'] = panelPackageDiscount;
    data['PanelPackageDiscountType'] = panelPackageDiscountType;
    data['DateofBirth'] = dob;
    data['Address'] = address;
    data['DateOfBirth'] = dateofbirth;
    return data;
  }
}
