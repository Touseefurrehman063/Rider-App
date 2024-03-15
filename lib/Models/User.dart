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

  User({
    this.UserName,
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
  });

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

    return data;
  }
}
