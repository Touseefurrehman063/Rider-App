// ignore_for_file: unrelated_type_equality_checks, use_build_context_synchronously, unused_local_variable, must_be_immutable

import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riderapp/Components/images/Images.dart';
import 'package:flutter_riderapp/Components/payment_status_radio/payment_status1.dart';
import 'package:flutter_riderapp/Components/payment_status_radio/payment_status_radio.dart';
import 'package:flutter_riderapp/Components/primary_button.dart';
import 'package:flutter_riderapp/Components/samples_radio_button/sample_radio_button.dart';
import 'package:flutter_riderapp/LocalDb/localDB.dart';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Models/lab_packages/lab_packages_model.dart';
import 'package:flutter_riderapp/Models/lab_test_model/lab_test_model.dart';
import 'package:flutter_riderapp/Models/labtest.dart';
import 'package:flutter_riderapp/Models/labtest_home_model/labtest_home_model.dart';
import 'package:flutter_riderapp/Models/payment_response/payment_response.dart';
import 'package:flutter_riderapp/Models/upcoming_labinvestigation_list/upcoming_lab_investigation_list.dart';
import 'package:flutter_riderapp/Repositeries/lab_investigation_repo/add_lab_investigation_repo.dart';
import 'package:flutter_riderapp/Repositeries/lab_investigation_repo/lab_investigation_repo.dart';
import 'package:flutter_riderapp/Repositeries/packages_repo/packages_repo.dart';
import 'package:flutter_riderapp/Repositeries/schedule_repo/schedule_repo.dart';
import 'package:flutter_riderapp/Screen/Appointments_Screen/_today_appoinments.dart';
import 'package:flutter_riderapp/Screen/Login/_signup.dart';
import 'package:flutter_riderapp/Screen/google_maps/add_google_maps.dart';
import 'package:flutter_riderapp/Screen/google_maps/google_mpas.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/Widgets/Utils/custom_dropdown4.dart';
import 'package:flutter_riderapp/Widgets/Utils/custom_text_field.dart';
import 'package:flutter_riderapp/Widgets/Utils/imagecontainer.dart';
import 'package:flutter_riderapp/Widgets/Utils/new_dropdown.dart';
import 'package:flutter_riderapp/Widgets/Utils/toast+manager.dart';
import 'package:flutter_riderapp/Widgets/searchabledropdown.dart';
import 'package:flutter_riderapp/controllers/Auth_Controller/auth_controller.dart';
import 'package:flutter_riderapp/controllers/addres_controller/address_controller.dart';
import 'package:flutter_riderapp/controllers/bookappointment_controller/book_appointment_controller.dart';
import 'package:flutter_riderapp/controllers/google_maps_controller/google_maps_controller.dart';
import 'package:flutter_riderapp/controllers/lab_controller/lab_controller.dart';
import 'package:flutter_riderapp/controllers/labinvestigation_controller/add_labinvestigation.dart';
import 'package:flutter_riderapp/controllers/labinvestigation_controller/lab_investigation_controller.dart';
import 'package:flutter_riderapp/controllers/packages_controller/packages_controller.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:flutter_riderapp/helpers/values_manager.dart';
import 'package:flutter_riderapp/main.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class AddLabInvestigation extends StatefulWidget {
  final bool? isHereFromReports;
  final bool? isLabInvestigationBooking;
  final bool? isHereFromInvestigatiosAndServices;
  final String? imagePath;
  final UpComingLabIvestigationDataList? list;
  final DateTime? date;
  final TimeOfDay? timeOfDay;
  final LabTests? labTest;
  final bool? isReschedule;
  final bool? isHomeSamle;
  final String? title;
  final String? patientid;

  const AddLabInvestigation(
      {super.key,
      this.title,
      this.isHomeSamle,
      this.isReschedule = false,
      this.labTest,
      this.date,
      this.timeOfDay,
      this.list,
      this.imagePath,
      this.isHereFromInvestigatiosAndServices = false,
      this.isLabInvestigationBooking = false,
      this.isHereFromReports = false,
      required this.patientid});

  @override
  State<AddLabInvestigation> createState() => _AddLabInvestigationState();
}

class _AddLabInvestigationState extends State<AddLabInvestigation> {
  TextEditingController discreb = TextEditingController();
  TextEditingController discountamount1 = TextEditingController();
  var cont = LabAddressController.i;
  final FocusNode _focusNode = FocusNode();
  bool? discountValue;
  String? TypeValue = 'percentage'.tr;
  var item1 = [
    'percentage'.tr,
    'Amount',
  ];
  bool isLoading = false;

  int counter = 1;
  List<Labtest> labtests = [];
  List<Labtest> selectedlabtestlist = [];
  Labtest? selectedlabtest;
  dynamic subtotal = 0;
  double grandtotal = 0;

  callfunc() async {
    await LabInvestigationController.i.addfunction();
    LabInvestigationController.i.getserviceslist();
    await LabInvestigationController.i.updateGrandTotal(
        TypeValue.toString(),
        LabInvestigationController.i.totalprice.toString(),
        LabInvestigationController.i.discountamount);
    String? pid = widget.patientid;

    await LabInvestigationController.i.getLabTests(pid);
    setState(() {});
  }

  @override
  void initState() {
    callfunc();
    LabInvestigationController1.i.quantitycont.text = "1";

    BookAppointmentController.i.getPaymentMethods();

    // LabInvestigationController1.i.updateLabTest();
    // LabInvestigationRepo1().getLabTests();
    LabInvestigationController1.i.selectedservice = null;
    // LabInvestigationController1.i.updateGrandTotal(
    //     LabInvestigationController1.i.discountamount.text, TypeValue.toString());
    // LabInvestigationController1.i.discountamount.text = "0.0";
    if (widget.isHereFromReports == true) {
      addLabTestsFromReports();
    }

    // LabInvestigationController1.i.selectedLabtest =
    //     LabInvestigationController1.i.labtests?[0];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      LabInvestigationController1.i.updateSelecteddoctor(0);
      BookAppointmentController.i.getPaymentMethods();
      // LabInvestigationController1.i.selectedDoctor =
      //     LabInvestigationController1.i.doctors[0];
      callback();

      LabInvestigationController1.selectedTime = TimeOfDay.now();
      // LabInvestigationController1.i.initTime(Get.context!);
    });

    super.initState();
  }

  addLabTestsFromReports() async {
    for (int i = 0; i < Reportcontroller.j.labTests.length; i++) {
      var report = Reportcontroller.j.labTests[i];
      var labController = LabInvestigationController1.i;
      labController.selectedLabtest = LabInvestigationController1.i.labtests!
          .firstWhereOrNull((element) => element.id == report.labtestId);
      labController.addLabTest();
    }
  }

  callback() async {
    Packages lt = await PackagesRepo().getsearchpackages();
    PackagesController.i.updatepackage(lt.data ?? []);
  }

  @override
  void dispose() {
    LabInvestigationController1.i.selectedLabTests = [];
    LabInvestigationController1.i.selectedLabtest = null;
    LabInvestigationController1.i.prescribedBy = null;
    LabInvestigationController1.i.totalSum = 0.0;
    LabInvestigationController1.i.totalprice = 0.0;
    LabInvestigationController1.i.selectedDate = DateTime.now();
    PackagesController.i.selectedLabPackages = [];
    PackagesController.i.selectedLabPackage = null;
    PackagesController.i.selectedLabPackage?.total;
    _focusNode.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  final _formKey = GlobalKey<FormState>();
  String discount = "0.0";
  @override
  Widget build(BuildContext context) {
    var cont =
        Get.put<LabInvestigationController1>(LabInvestigationController1());
    var controller = Get.put<PackagesController>(PackagesController());
    var reports = Get.put<Reportcontroller>(Reportcontroller());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Color(0xff0F64C6),
            )),
        title: Text(
          "Services",
          textAlign: TextAlign.center,
          style: GoogleFonts.raleway(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1.175,
            color: const Color(0xFF1272D3),
          ),
        ),
        centerTitle: true,
      ),
      body: GetBuilder<LabInvestigationController1>(builder: (cont) {
        // return cont.isLoading == false
        return Padding(
            padding: const EdgeInsets.all(AppPadding.p16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   height: Get.height * 0.02,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: ImageContainer(
                            height: Get.height * 0.06,
                            width: Get.width * 0.13,
                            pic: Images.microscope,
                            // color: ColorManager.kWhiteColor,
                            backgroundColor: ColorManager.kPrimaryColor,
                          ),
                        ),

                        GetBuilder<LabInvestigationController>(builder: (cntr) {
                          return Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  // if (cntr.labtests?.isNotEmpty ?? false) {
                                  // ToastManager.showToast(
                                  //     "${cont.labtests!.length}");
                                  // cont.selectedLabtest = null;
                                  LabTestHome generic =
                                      await searchableDropdown4(
                                          context, cont.labtests ?? []);
                                  LabInvestigationController.i
                                      .getLabTests(widget.patientid);
                                  cont.selectedLabtest = null;
                                  cont.updateLabTest(generic);

                                  if (generic != '') {
                                    cont.selectedLabtest = generic;
                                    cont.selectedLabtest = (generic == '')
                                        ? null
                                        : cont.selectedLabtest;
                                  }
                                  setState(() {});
                                  //}
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorManager.kPrimaryLightColor,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: ColorManager.kPrimaryLightColor,
                                  ),
                                  width: Get.width * 0.45,
                                  height:
                                      MediaQuery.of(context).size.height * 0.06,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${(cont.selectedLabtest != null && cont.selectedLabtest!.name != null) ? (cont.selectedLabtest!.name!.length > 15 ? ('${cont.selectedLabtest!.name!.substring(0, 15)}...') : cont.selectedLabtest!.name) : "Select Tests".tr}",
                                        semanticsLabel:
                                            "${(cont.selectedLabtest != null && cont.selectedLabtest!.name != null) ? (cont.selectedLabtest!.name!.length > 15 ? ('${cont.selectedLabtest!.name!.substring(0, 10)}...') : cont.selectedLabtest!.name) : "Select Tests".tr}",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: cont.selectedLabtest?.name !=
                                                    null
                                                ? ColorManager.kPrimaryColor
                                                : ColorManager.kPrimaryColor,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        size:
                                            MediaQuery.of(context).size.width *
                                                0.06,
                                        color: cont.selectedLabtest != null
                                            ? Colors.black
                                            : Colors.grey[700],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.02,
                              ),
                              // Initial counter value

                              // Container(
                              //   height: Get.height * 0.06,
                              //   width: Get.width * 0.14,
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: 10),
                              //   decoration: BoxDecoration(
                              //     border: Border.all(
                              //       color: ColorManager.kPrimaryLightColor,
                              //     ),
                              //     borderRadius: BorderRadius.circular(10.0),
                              //     color: ColorManager.kPrimaryLightColor,
                              //   ),
                              // )
                              Container(
                                width: 60.0,
                                foregroundDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  border: Border.all(
                                    color: ColorManager.kDarkBlue,
                                    width: 2.0,
                                  ),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: TextFormField(
                                        textAlign: TextAlign.center,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(8.0),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                        ),
                                        controller: cont.quantitycont,
                                        // readOnly: true,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter
                                              .digitsOnly,
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 38.0,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            decoration: const BoxDecoration(
                                              border: Border(
                                                bottom: BorderSide(
                                                  width: 0.5,
                                                ),
                                              ),
                                            ),
                                            child: InkWell(
                                              child: const Icon(
                                                Icons.arrow_drop_up,
                                                size: 18.0,
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  int currentValue =
                                                      int.tryParse(cont
                                                              .quantitycont
                                                              .text) ??
                                                          0;
                                                  currentValue++;
                                                  cont.quantitycont.text =
                                                      currentValue.toString();
                                                });
                                              },
                                            ),
                                          ),
                                          InkWell(
                                            child: const Icon(
                                              Icons.arrow_drop_down,
                                              size: 18.0,
                                            ),
                                            onTap: () {
                                              setState(() {
                                                int currentValue = int.tryParse(
                                                        cont.quantitycont
                                                            .text) ??
                                                    0;
                                                if (currentValue > 0) {
                                                  currentValue--;
                                                }
                                                cont.quantitycont.text =
                                                    currentValue.toString();
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          );
                        }),
                        // SizedBox(
                        //   width: Get.width * 0.01,
                        // ),

                        // GetBuilder<PackagesController>(
                        //     builder: (cont) {
                        //   return Flexible(
                        //     child: DropdownDataWidget<LabPackages>(
                        //         hint: 'Lab Packages',
                        //         items: cont.packages,
                        //         selectedValue: cont.selectedLabPackage,
                        //         onChanged: (value) {
                        //           // cont.updateLabTest(value!);
                        //           // cont.totalLabPackagesPrice(false);
                        //           log(cont.selectedLabPackage!
                        //               .toJson()
                        //               .toString());
                        //         },
                        //         itemTextExtractor: (value) => value.packageGroupName!),
                        //   );
                        // }),
                        // SizedBox(
                        //   width: Get.width * 0.02,
                        // ),
                        ImageContainer(
                          height: Get.height * 0.06,
                          width: Get.width * 0.13,
                          onpressed: () {
                            LabInvestigationController1.i.updatefinalsubtotal(
                                LabInvestigationController1
                                    .i.selectedLabtest!.price!);
                            LabInvestigationController1.i.updatequantity(
                                LabInvestigationController1.i.quantitycont.text
                                    .toString());
                            cont.addLabTest();
                          },
                          pic: Images.add,
                          // isSvg: false,
                          color: ColorManager.kWhiteColor,
                          backgroundColor: ColorManager.kPrimaryColor,
                        )
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),

                    // GetBuilder<PackagesController>(builder: (controller) {
                    //   return Row(
                    //     children: [
                    //       InkWell(
                    //         onTap: () async {
                    //           // Get.to(() => const PackagesList());
                    //           // cont.selectedLabtest = null;
                    //           // LabPackages generic = await searchablepackage(
                    //           //     context, controller.packages);
                    //           // controller.updateselectednewpackage(generic);

                    //           // if (generic != '') {
                    //           //   controller.selectedLabPackage = generic;
                    //           //   controller.selectedLabPackage =
                    //           //       (generic == '')
                    //           //           ? null
                    //           //           : controller.selectedLabPackage;
                    //           // }
                    //           // setState(() {});
                    //         },
                    //         child: Container(
                    //           padding: const EdgeInsets.symmetric(
                    //               horizontal: 10),
                    //           decoration: BoxDecoration(
                    //             border: Border.all(
                    //               color: ColorManager.kPrimaryLightColor,
                    //             ),
                    //             borderRadius: BorderRadius.circular(10.0),
                    //             color: ColorManager.kPrimaryLightColor,
                    //           ),
                    //           width: Get.width * 0.72,
                    //           height:
                    //               MediaQuery.of(context).size.height * 0.06,
                    //           child: Row(
                    //             mainAxisAlignment:
                    //                 MainAxisAlignment.spaceBetween,
                    //             children: [
                    //               Text(
                    //                 "${(controller.selectedLabPackage != null && controller.selectedLabPackage?.packageGroupName != null) ? (controller.selectedLabPackage!.packageGroupName!.length > 20 ? ('${controller.selectedLabPackage?.packageGroupName!.substring(0, 20)}...') : controller.selectedLabPackage?.packageGroupName) : "Select Package".tr}",
                    //                 semanticsLabel:
                    //                     "${(controller.selectedLabPackage != null) ? (controller.selectedLabPackage!.packageGroupName!.length > 20 ? ('${controller.selectedLabPackage?.packageGroupName!.substring(0, 10)}...') : controller.selectedLabPackage) : "Select Package".tr}",
                    //                 style: TextStyle(
                    //                     fontSize: 12,
                    //                     color: controller.selectedLabPackage
                    //                                 ?.packageGroupName !=
                    //                             null
                    //                         ? ColorManager.kPrimaryColor
                    //                         : ColorManager.kPrimaryColor,
                    //                     fontWeight: FontWeight.w900),
                    //               ),
                    //               Icon(
                    //                 Icons.arrow_drop_down,
                    //                 size:
                    //                     MediaQuery.of(context).size.width *
                    //                         0.06,
                    //                 color: controller.selectedLabPackage !=
                    //                         null
                    //                     ? Colors.black
                    //                     : Colors.grey[700],
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    //       const Spacer(),
                    //       GetBuilder<PackagesController>(
                    //           builder: (packageContr) {
                    //         return ImageContainer(
                    //           height: Get.height * 0.06,
                    //           width: Get.width * 0.13,
                    //           onpressed: () async {
                    //             await PackagesController.i.updatediscount(
                    //                 PackagesController.i.selectedLabPackage!
                    //                     .packageGroupDiscountRate!,
                    //                 PackagesController
                    //                     .i.selectedLabPackage!.total!);
                    //             // await controller.addlabpackage();
                    //           },
                    //           pic: Images.add,
                    //           isSvg: false,
                    //           color: ColorManager.kWhiteColor,
                    //           backgroundColor: ColorManager.kPrimaryColor,
                    //         );
                    //       })
                    //     ],
                    //   );
                    // }

                    // ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text(
                      'Test ${PackagesController.i.selectedLabPackages!.isNotEmpty && PackagesController.i.selectedLabPackages!.length < 2 ? ('(Package)') : PackagesController.i.selectedLabPackages!.length > 1 ? '(Packages)' : ''}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: ColorManager.kPrimaryColor),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Container(
                      padding: const EdgeInsets.all(AppPadding.p12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: ColorManager.kGreyColor)),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Test',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                              ),
                              Text(
                                'Price',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12),
                              ),
                            ],
                          ),
                          PackagesController.i.selectedLabPackages!.isNotEmpty
                              ? SizedBox(
                                  height: Get.height * 0.02,
                                )
                              : const SizedBox.shrink(),
                          GetBuilder<LabInvestigationController1>(
                              builder: (cont) {
                            return GetBuilder<PackagesController>(
                                builder: (packagesContr) {
                              return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      packagesContr.selectedLabPackages?.length,
                                  itemBuilder: (context, index) {
                                    final test = packagesContr
                                        .selectedLabPackages![index];
                                    int myindex = index;
                                    return ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount:
                                            test.dTOPackageGroupDetail?.length,
                                        itemBuilder: (context, index) {
                                          final data = test
                                              .dTOPackageGroupDetail?[index];
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  // log(index.toString());
                                                  int groupIndex = test
                                                      .dTOPackageGroupDetail!
                                                      .indexOf(data!);
                                                  int index = await cont
                                                      .updateSelectedIndex(
                                                          groupIndex);
                                                  packagesContr
                                                      .removepackage(myindex);
                                                },
                                                child: cont.selectedIndex ==
                                                        index
                                                    ? const Icon(
                                                        Icons.cancel,
                                                        color: ColorManager
                                                            .kRedColor,
                                                        size: 15,
                                                      )
                                                    : const SizedBox(width: 15),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.5,
                                                child: Text(
                                                  testName(data!.name!)
                                                      .toString(),
                                                  textAlign: TextAlign.start,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium!
                                                      .copyWith(fontSize: 12),
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                data.total
                                                    .toString()
                                                    .replaceAllMapped(
                                                        RegExp(
                                                            r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                        (Match m) =>
                                                            '${m[1]},'),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(fontSize: 14),
                                              ),
                                            ],
                                          );
                                        });
                                  });
                            });
                          }),
                          GetBuilder<LabInvestigationController1>(
                              builder: (cont) {
                            return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: cont.selectedLabTests.length,
                                itemBuilder: (context, index) {
                                  final test = cont.selectedLabTests[index];
                                  return Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          cont.removeLabTest(index);
                                        },
                                        child: const Icon(
                                          Icons.cancel,
                                          color: ColorManager.kRedColor,
                                          size: 15,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.5,
                                        child: Text(
                                          '${test.name}(${test.quantity})',
                                          textAlign: TextAlign.start,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(fontSize: 12),
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        test.actualPrice
                                            .toString()
                                            .replaceAllMapped(
                                                RegExp(
                                                    r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                (Match m) => '${m[1]},'),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(fontSize: 14),
                                      ),
                                    ],
                                  );
                                });
                          }),
                          const Divider(
                            color: ColorManager.kblackColor,
                          ),

                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${'Sub Total'.tr} : ${cont.totalprice}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          FutureBuilder<String>(
                              future: cont.returnDiscountOfPackages(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data == '') {
                                    return const SizedBox.shrink();
                                  } else {
                                    return Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        'Discount : ${snapshot.data.toString()}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontSize: 12,
                                            ),
                                      ),
                                    );
                                  }
                                } else if (!snapshot.hasData) {
                                  return const SizedBox.shrink();
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }),

                          FutureBuilder<double>(
                              future: PackagesController.i
                                  .totalVatPercentOfPackages(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data == 0.0) {
                                    return const SizedBox.shrink();
                                  } else {
                                    return Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${'Vat Amount'.tr} : ${snapshot.data.toString()}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600),
                                      ),
                                    );
                                  }
                                } else if (!snapshot.hasData) {
                                  return const SizedBox.shrink();
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }),
                          //  Align(
                          //               alignment: Alignment.centerRight,
                          //               child: Text(
                          //                 '${'Grand Total'.tr} : ${}',
                          //                 style: Theme.of(context)
                          //                     .textTheme
                          //                     .bodyMedium
                          //                     ?.copyWith(
                          //                         fontSize: 12,
                          //                         fontWeight:
                          //                             FontWeight.w600),
                          //               ),
                          //             );
                        ],
                      ),
                    ),

                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    const Divider(
                      color: ColorManager.kblackColor,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Text(
                      'discount'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 12, fontWeight: FontWeight.w900),
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    // const SamplesRadioButton(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 0.5),
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                              ),
                              width: Get.width * 0.4,
                              height:
                                  MediaQuery.of(context).size.height * 0.055,
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                  // hintText: "Percentage",
                                  contentPadding: EdgeInsets.only(bottom: 22),
                                  border: InputBorder.none,
                                ),
                                value: TypeValue,
                                items: item1.map((String items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Center(
                                      child: Text(
                                        "  $items",
                                        //  textAlign: AlignmentDirectional.topCenter,
                                      ),
                                    ),
                                  );
                                }).toList(),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    TypeValue = newValue!;
                                  });
                                },
                                alignment: Alignment.center,
                                elevation: 0,
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            SizedBox(
                                height: Get.height * 0.055,
                                width: Get.width * 0.4,
                                child: AuthTextField(
                                  hintText: cont.discountamount.text.isEmpty
                                      ? "0.0"
                                      : discount,
                                  controller: cont.discountamount,
                                  function: (String a) {
                                    discount = a;
                                    cont.updateGrandTotal1(
                                        TypeValue.toString(),
                                        LabInvestigationController1.i.totalprice
                                            .toString(),
                                        LabInvestigationController1
                                            .i.discountamount);

                                    setState(() {});
                                  },
                                  keyboardType: TextInputType.number,
                                )),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            // SizedBox(
                            //   height: Get.height * 0.045,
                            //   width: Get.width * 0.4,
                            //   child: ElevatedButton(
                            //       onPressed: () {
                            //         double temp = 0.0;
                            //         for (int i = 0;
                            //             i < selectedlabtestlist.length;
                            //             i++) {
                            //           print(
                            //               "${selectedlabtestlist[i].vATPercentageAmount ?? 0.0}");
                            //           if (selectedlabtestlist[i]
                            //                       .vATPercentageAmount ==
                            //                   null
                            //               //     &&
                            //               // selectedlabtestlist[i]
                            //               //         .vATPercentageAmount !=
                            //               //     0.0
                            //               ) {
                            //             temp = selectedlabtestlist[i]
                            //                 .actualPrice;
                            //           } else {
                            //             temp = selectedlabtestlist[i]
                            //                         .actualPrice /
                            //                     selectedlabtestlist[i]
                            //                         .vATPercentageAmount ??
                            //                 0.0;
                            //           }
                            //           grandtotal = grandtotal - temp;

                            //           // grandtotal=selectedlabtestlist[i].vATPercentageAmount
                            //         }
                            //         setState(() {});
                            //       },
                            //       style: ElevatedButton.styleFrom(
                            //         backgroundColor:
                            //             const Color(0xFF1272D3),
                            //       ),
                            //       child: const Text("Add")),
                            // )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                'Discount: ${cont.discountamount.text == "" ? '0.0' : (TypeValue == 'Percentage' ? '${cont.discountamount.text}%' : cont.discountamount.text)}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '${'Grand Total'.tr} : ${cont.discountamount.text == "0.0" || cont.discountamount.text.isEmpty || cont.discountamount.text == "0" ? cont.totalprice : cont.grandprice1}',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                    // SizedBox(
                    //   height: Get.height * 0.01,
                    // ),
                    const Divider(
                      color: ColorManager.kblackColor,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    // Container(
                    //   height: Get.height * 0.13,
                    //   decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(8),
                    //       color: ColorManager.kPrimaryLightColor),
                    //   child: DatePicker(
                    //     DateTime.now(),
                    //     dateTextStyle: Theme.of(context)
                    //         .textTheme
                    //         .bodyMedium!
                    //         .copyWith(
                    //             color: ColorManager.kPrimaryColor,
                    //             fontWeight: FontWeight.w900,
                    //             fontSize: 12),
                    //     dayTextStyle: Theme.of(context)
                    //         .textTheme
                    //         .bodyMedium!
                    //         .copyWith(
                    //             color: ColorManager.kPrimaryColor,
                    //             fontWeight: FontWeight.w900,
                    //             fontSize: 12),
                    //     monthTextStyle: Theme.of(context)
                    //         .textTheme
                    //         .bodyMedium!
                    //         .copyWith(
                    //             color: ColorManager.kPrimaryColor,
                    //             fontWeight: FontWeight.w300,
                    //             fontSize: 12),
                    //     deactivatedColor: ColorManager.kPrimaryLightColor,
                    //     // height: Get.height * 0.14,
                    //     initialSelectedDate: DateTime.now(),
                    //     selectionColor: ColorManager.kPrimaryColor,
                    //     selectedTextColor: Colors.white,
                    //     onDateChange: (date) {
                    //       cont.updateSelectedDatae(date);
                    //       log('${cont.selectedDate}');
                    //     },
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: Get.height * 0.02,
                    // ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "From Date",
                                style: GoogleFonts.poppins(
                                    color: ColorManager.kmenuBlue),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: Get.width * 0.23),
                                child: Text(
                                  "From Time",
                                  style: GoogleFonts.poppins(
                                      color: ColorManager.kmenuBlue),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                final date = await cont.selectDate(context);
                                cont.updateselecteddate(date);
                              },
                              child: Container(
                                // padding: const EdgeInsets.all(6),
                                width: Get.width * 0.4,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorManager.kDarkBlue),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: const Padding(
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Icons.calendar_today_outlined,
                                            color: ColorManager.kDarkBlue,
                                          )),
                                    ),
                                    Text(
                                        "${cont.formattedDate(cont.selectedDate.toString())}")
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.05,
                            ),
                            InkWell(
                              onTap: () async {
                                cont.selectTime(
                                    context,
                                    LabInvestigationController1.selectedTime,
                                    cont.formattedSelectedTime);
                              },
                              child: Container(
                                width: Get.width * 0.4,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorManager.kDarkBlue),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: const Padding(
                                        padding: EdgeInsets.all(4),
                                        child: Icon(
                                          Icons.timer_outlined,
                                          color: ColorManager.kDarkBlue,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.03,
                                    ),
                                    Text(
                                      cont.formattedSelectedTime ??
                                          'Select Time'.tr,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.03,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "To Date",
                                style: GoogleFonts.poppins(
                                    color: ColorManager.kmenuBlue),
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.only(right: Get.width * 0.28),
                                child: Text(
                                  "To Time",
                                  style: GoogleFonts.poppins(
                                      color: ColorManager.kmenuBlue),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // const SizedBox(
                        //   height: 5,
                        // ),
                        InkWell(
                          onTap: () async {
                            final date = await cont.selectDate1(context);
                            cont.updateselecteddate1(date);
                          },
                          child: Row(
                            children: [
                              Container(
                                // padding: const EdgeInsets.all(6),
                                width: Get.width * 0.4,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: ColorManager.kDarkBlue),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  children: [
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: const Padding(
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Icons.calendar_today_outlined,
                                            color: ColorManager.kDarkBlue,
                                          )),
                                    ),
                                    Text(
                                        "${cont.formattedDate(cont.selectedDate1.toString())}")
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: Get.width * 0.05,
                              ),
                              InkWell(
                                onTap: () async {
                                  cont.selectTimeto(
                                      context,
                                      LabInvestigationController1
                                          .selectedTimeto,
                                      cont.formattedSelectedTimeto);
                                },
                                child: Container(
                                  width: Get.width * 0.4,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: ColorManager.kDarkBlue),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    children: [
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: const Padding(
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Icons.timer_outlined,
                                            color: ColorManager.kDarkBlue,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.03,
                                      ),
                                      Text(
                                        cont.formattedSelectedTimeto ??
                                            'Select Time'.tr,
                                      ),
                                      SizedBox(
                                        width: Get.width * 0.03,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    // GetBuilder<LabInvestigationController1>(builder: (cont) {
                    //   return InkWell(
                    //     onTap: () {
                    //       cont.selectTime(
                    //           context,
                    //           LabInvestigationController1.selectedTime,
                    //           cont.formattedSelectedTime);
                    //     },
                    //     child: Container(
                    //       decoration: BoxDecoration(
                    //           borderRadius: BorderRadius.circular(10),
                    //           color: ColorManager.kPrimaryLightColor),
                    //       padding: const EdgeInsets.symmetric(
                    //           horizontal: 15, vertical: 15),
                    //       child: Row(
                    //         mainAxisAlignment:
                    //             MainAxisAlignment.spaceBetween,
                    //         children: [
                    //           Text(
                    //             '${'Timer'.tr} : ',
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .bodyMedium
                    //                 ?.copyWith(
                    //                     color: ColorManager.kPrimaryColor,
                    //                     fontSize: 12,
                    //                     fontWeight: FontWeight.bold),
                    //           ),
                    //           Text(
                    //             cont.formattedSelectedTime ??
                    //                 'Select Time'.tr,
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .bodyMedium
                    //                 ?.copyWith(
                    //                     color: ColorManager.kPrimaryColor,
                    //                     fontSize: 12,
                    //                     fontWeight: FontWeight.bold),
                    //           )
                    //         ],
                    //       ),
                    //     ),
                    //   );
                    // }
                    // ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    CustomTextField(
                      padding: const EdgeInsets.all(15).copyWith(top: 10),
                      maxlines: 1,
                      hintText: 'Reference Number'.tr,
                      controller: discreb,
                      focusNode: _focusNode,
                    ),

                    cont.selectedLabValue == 0
                        ? GetBuilder<LabAddressController>(builder: (cont) {
                            return InkWell(
                              onTap: () async {
                                LocationPermission permission;
                                permission = await Geolocator.checkPermission();
                                var isFirstTime = await LocalDb()
                                    .getDisclosureDialogueValue();
                                if (permission ==
                                        LocationPermission.whileInUse ||
                                    permission == LocationPermission.always ||
                                    isFirstTime == true) {
                                  log('test a');
                                  Get.to(() => const LabGoogleMaps());
                                } else {
                                  await showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          child: SizedBox(
                                            height: Get.height * 0.5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Text(
                                                    "Permissions".tr,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  const Divider(
                                                    thickness: 2,
                                                    color: Colors.black,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                        "SIDRA Rider collects Location data to enable Home Sampling Services even when is closed or not in use"
                                                            .tr),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                        child: ElevatedButton(
                                                            style: ButtonStyle(
                                                                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20)))),
                                                            child: Text(
                                                              "Agree".tr,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                      color: ColorManager
                                                                          .kWhiteColor,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              await LocalDb()
                                                                  .disclosureDialogvalue();
                                                              Get.back();
                                                              await determinePosition()
                                                                  .then(
                                                                      (value) {
                                                                setState(() {
                                                                  LabAddressController
                                                                      .i.markers
                                                                      .clear();
                                                                  LabAddressController.i.markers.add(Marker(
                                                                      infoWindow: const InfoWindow(
                                                                          title:
                                                                              'Current Location',
                                                                          snippet:
                                                                              'current Location'),
                                                                      position: LatLng(
                                                                          value?.latitude ??
                                                                              0.0,
                                                                          value?.longitude ??
                                                                              0.0),
                                                                      markerId:
                                                                          const MarkerId(
                                                                              '1')));
                                                                  LabAddressController
                                                                      .i
                                                                      .currentPlaceList
                                                                      .clear();
                                                                  LabAddressController
                                                                      .i
                                                                      .getcurrentLocation()
                                                                      .then(
                                                                          (value) {
                                                                    LabAddressController
                                                                            .i
                                                                            .latitude =
                                                                        value
                                                                            .latitude;
                                                                    LabAddressController
                                                                            .i
                                                                            .longitude =
                                                                        value
                                                                            .longitude;
                                                                    LabAddressController
                                                                        .i
                                                                        .initialAddress(
                                                                            value.latitude,
                                                                            value.longitude);
                                                                    log('latitude: ${LabAddressController.i.latitude} , longitude ${LabAddressController.i.longitude}');
                                                                    LabAddressController
                                                                        .i
                                                                        .markers
                                                                        .clear();
                                                                    LabAddressController.i.markers.add(Marker(
                                                                        infoWindow: const InfoWindow(
                                                                            title:
                                                                                'Current Location',
                                                                            snippet:
                                                                                'This is my current Location'),
                                                                        position: LatLng(
                                                                            LabAddressController
                                                                                .i.latitude!,
                                                                            LabAddressController
                                                                                .i.longitude!),
                                                                        markerId:
                                                                            const MarkerId('1')));
                                                                  });
                                                                });
                                                              });
                                                              Get.to(() =>
                                                                  const LabGoogleMaps());
                                                            }),
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.3,
                                                        child: ElevatedButton(
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty
                                                                        .all(Colors
                                                                            .white),
                                                                shape: MaterialStatePropertyAll(
                                                                    RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)))),
                                                            child: Text(
                                                              "Deny".tr,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .bodyMedium
                                                                  ?.copyWith(
                                                                      color: ColorManager
                                                                          .kPrimaryColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          12),
                                                            ),
                                                            onPressed: () {
                                                              Get.back();
                                                            }),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                        vertical: 12, horizontal: 10)
                                    .copyWith(right: 15),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorManager.kPrimaryLightColor),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: ColorManager.kPrimaryColor,
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.035,
                                    ),
                                    Flexible(
                                      child: Text(
                                          LabAddressController.address ==
                                                      null ||
                                                  LabAddressController
                                                          .address ==
                                                      ''
                                              ? 'Address'.tr
                                              : '${LabAddressController.address}',
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  color: ColorManager
                                                      .kPrimaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w900)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })
                        : const SizedBox.shrink(),
                    cont.selectedLabValue == 0
                        ? SizedBox(
                            height: Get.height * 0.02,
                          )
                        : const SizedBox.shrink(),
                    // Text(
                    //   'paymentMethod'.tr,
                    //   style:
                    //       Theme.of(context).textTheme.bodyMedium!.copyWith(
                    //             color: ColorManager.kPrimaryColor,
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w900,
                    //           ),
                    // ),

                    InkWell(
                      onTap: () {
                        paymentMethodDialogue(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10)
                            .copyWith(right: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorManager.kPrimaryLightColor),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.payment,
                              color: ColorManager.kPrimaryColor,
                            ),
                            SizedBox(
                              width: Get.width * 0.035,
                            ),
                            Text(
                                cont.selectedPaymentMethod != null
                                    ? '${cont.selectedPaymentMethod!.name}'
                                    : 'Mode Of Payment'.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: ColorManager.kPrimaryColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900)),
                            const Spacer(),
                            Image(
                                height: Get.height * 0.03,
                                image: const AssetImage(Images.mastercard))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    // Text(
                    //   'Prescribed By'.tr,
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .titleLarge!
                    //       .copyWith(
                    //           color: ColorManager.kPrimaryColor,
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.bold),
                    // ),

                    // const RadioButtonRow(),

                    // Visibility(
                    //   visible: cont.selectedalue == 1,
                    //   child: DropdownDataWidget<Doctors>(
                    //       hint: 'doctor'.tr,
                    //       items: cont.doctors,
                    //       selectedValue: cont.selectedDoctor,
                    //       onChanged: (value) {
                    //         cont.updateDoctor(value!);
                    //         // cont.addLabTest();
                    //         // cont.totalLabPackagesPrice(false);
                    //       },
                    //       itemTextExtractor: (value) => value.name!),
                    // ),
                    // Visibility(
                    //   visible: cont.selectedalue == 2,
                    //   child: Column(
                    //     children: [
                    //       // SizedBox(
                    //       //   height: Get.height * 0.02,
                    //       // ),
                    //       CustomTextField(
                    //         hintText: 'doctorName'.tr,
                    //       ),
                    //       // SizedBox(
                    //       //   height: Get.height * 0.02,
                    //       // ),
                    //       PrimaryButton(
                    //           border: Border.all(
                    //               color: ColorManager.kPrimaryColor,
                    //               width: 2),
                    //           title: 'attachPrescription'.tr,
                    //           onPressed: () async {
                    //             LabInvestigationController1.i.file =
                    //                 await AuthController.i.pickImage(
                    //                     type: FileType.image,
                    //                     context: context);
                    //           },
                    //           fontSize: 20,
                    //           color: ColorManager.kWhiteColor,
                    //           textcolor: ColorManager.kPrimaryColor),
                    //       SizedBox(
                    //         height: Get.height * 0.01,
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height:
                    //       cont.selectedalue == 0 || cont.selectedalue == 2
                    //           ? 0
                    //           : Get.height * 0.01,
                    // ),
                    Text(
                      'Payment Status'.tr,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: ColorManager.kPrimaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const PaymentStatusRadioButton1(),

                    // Text(
                    //   'Summary'.tr,
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .titleLarge!
                    //       .copyWith(
                    //           color: ColorManager.kPrimaryColor,
                    //           fontSize: 12,
                    //           fontWeight: FontWeight.bold),
                    // ),
                    // SizedBox(
                    //   height: Get.height * 0.01,
                    // ),
                    // SummaryWidget(
                    //   title: widget.title,
                    // ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    isLoading == true
                        ? const Center(child: CircularProgressIndicator())
                        : PrimaryButton(
                            title: 'Book Appointment'.tr,
                            fontSize: 14,
                            onPressed: () async {
                              String apiTime = cont.formattedSelectedTime
                                  .toString()
                                  .split(' ')
                                  .first;
                              apiTime = apiTime.replaceAll(' at 5', '');

                              DateTime parsedTime =
                                  DateFormat.jm().parse(apiTime);
                              String formattedTime =
                                  DateFormat('hh:mm:ss').format(parsedTime);

                              if (cont.selectedLabTests.isEmpty) {
                                isLoading = false;
                                setState(() {});
                                ToastManager.showToast(
                                    ' Lab Test  not Selected'.tr);
                              } else if (cont.selectedPaymentMethod == null) {
                                isLoading = false;
                                setState(() {});
                                ToastManager.showToast(
                                    'Payment Method not selected'.tr);
                              } else
                              // if (cont.selectedDate.day ==
                              //         DateTime.now().day &&
                              //     (LabInvestigationController1
                              //                 .selectedTime.hour <
                              //             TimeOfDay.now().hour ||
                              //         (LabInvestigationController1
                              //                     .selectedTime.hour ==
                              //                 DateTime.now().hour &&
                              //             LabInvestigationController1
                              //                     .selectedTime.minute <=
                              //                 DateTime.now().minute))) {
                              //   log(LabInvestigationController1.selectedTime
                              //       .toString());
                              //   ToastManager.showToast(
                              //       'This Date and time is before the current Time. Please try again'
                              //           .tr);
                              // } else
                              if (cont.selectedLabValue == 0 &&
                                  (LabAddressController.address == null ||
                                      LabAddressController.address == "")) {
                                ToastManager.showToast(
                                    'Address Not Selected'.tr);
                                isLoading = false;
                                setState(() {});
                              } else {
                                // bool? isLoggedin =
                                //     await LocalDb().getLoginStatus();
                                // log('$isLoggedin');
                                if (_formKey.currentState!.validate()) {
                                  LabInvestigationRepo1()
                                      .bookLabInvestigationOrHomeSampling(
                                    widget.patientid ?? "",
                                    discount,
                                    TypeValue,
                                    discreb.text,
                                    formattedTime,
                                    isHereFromReports: widget.isHereFromReports,
                                    isHerefromHomeSample: widget.isHomeSamle,
                                    isLabInvestigationBooking:
                                        widget.isLabInvestigationBooking,
                                  );
                                  isLoading = false;
                                  setState(() {});
                                  // Get.to(() => TodayAppoinments(
                                  //       empId: userprofile?.id ?? "",
                                  //     ));
                                } else {}
                              }
                            },
                            color: ColorManager.kPrimaryColor,
                            textcolor: ColorManager.kWhiteColor)
                  ],
                ),
              ),
            ));
      }),
    );
  }

  paymentMethodDialogue(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return FractionallySizedBox(
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    const Text('Mode of Payment'),
                    const Spacer(),
                    CircleAvatar(
                        radius: 15,
                        backgroundColor: ColorManager.kRedColor,
                        child: IconButton(
                          icon: const Icon(
                            Icons.close,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          iconSize: 15,
                          color: ColorManager.kWhiteColor,
                        ))
                  ]),
              content: SizedBox(
                width: double.maxFinite,
                child: BookAppointmentController.i.paymentMethods.isNotEmpty
                    ? ListView.builder(
                        itemCount:
                            BookAppointmentController.i.paymentMethods.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final payment =
                              BookAppointmentController.i.paymentMethods[index];
                          return buildStyledContainer(
                              '${payment.name}',
                              context,
                              index,
                              payment.imagePath ?? '',
                              true, () {
                            BookAppointmentController.i
                                .updateSelectedIndex(index);
                            LabInvestigationController1.i
                                .updatePaymentMethod(payment);
                            LabInvestigationController1.i.updatePayment(false);
                            Get.back();
                          });
                        },
                      )
                    : Text(
                        'No Payments Found'.tr,
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
          );
        });
  }

  buildStyledContainer(String text, BuildContext context, int index,
      String payment, bool? hasMasterCardImage, Function()? onTap,
      {PaymentMethod? method}) {
    return GetBuilder<BookAppointmentController>(builder: (cont) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: Get.width,
            decoration: BoxDecoration(
              color: cont.selectedIndex == index
                  ? ColorManager.kPrimaryColor
                  : ColorManager.kWhiteColor,
              border: Border.all(color: ColorManager.kPrimaryColor),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text,
                    style: TextStyle(
                        fontSize: 12,
                        color: cont.selectedIndex == index
                            ? ColorManager.kWhiteColor
                            : ColorManager.kPrimaryColor)),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                CachedNetworkImage(
                  imageUrl:
                      '${containsFile(method?.imagePath)}${method?.imagePath}',
                  errorWidget: (context, url, error) {
                    return const SizedBox.shrink();
                  },
                )
                // Image.network(payment)
              ],
            ),
          ),
        ),
      );
    });
  }
}

class SummaryWidget extends StatelessWidget {
  final String? title;
  SummaryWidget({
    this.title,
    super.key,
  });

  double discount = 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppPadding.p8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: ColorManager.kGreyColor,
          )),
      child: GetBuilder<LabInvestigationController1>(builder: (cont) {
        if (PackagesController.i.selectedLabPackage != null) {
          // sum = LabInvestigationController1.i.totalSum+PackagesController.i.selectedLabPackage!.total!;
          discount = PackagesController
              .i.selectedLabPackage!.packageGroupDiscountRate!;
        }

        return Column(
          children: [
            LabInvestigationController1.i.formattedSelectedTime != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${'Date'.tr} & ${'Time'.tr}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 12),
                      ),
                      Text(
                        '${cont.selectedDate.toString().split(' ').first} | ${cont.formattedSelectedTime}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 12),
                      )
                    ],
                  )
                : const SizedBox.shrink(),
            // LabInvestigationController1.i.prescribedBy != null
            //     ? Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Text(
            //             'prescribedBy'.tr,
            //             style: Theme.of(context)
            //                 .textTheme
            //                 .bodyMedium
            //                 ?.copyWith(fontSize: 12),
            //           ),
            //           Text(
            //             '${cont.prescribedBy == 'Doctor' ? cont.selectedDoctor?.name : cont.prescribedBy}',
            //             style: Theme.of(context)
            //                 .textTheme
            //                 .bodyMedium
            //                 ?.copyWith(fontSize: 12),
            //           )
            //         ],
            //       )
            //     : const SizedBox.shrink(),
            LabInvestigationController1.i.selectedPaymentMethod != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Mode of Payment'.tr,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 12),
                      ),
                      Text(
                        '${cont.selectedPaymentMethod?.name}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 12),
                      )
                    ],
                  )
                : const SizedBox.shrink(),
            const Divider(
              color: ColorManager.kblackColor,
            ),
          ],
        );
      }),
    );
  }
}

class SummaryContainer extends StatelessWidget {
  final String? title;
  final bool? isOnlinePay;
  final List<Widget> summaryWidgets;

  const SummaryContainer({
    Key? key,
    this.isOnlinePay = false,
    this.title,
    required this.summaryWidgets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontSize: 14, fontWeight: FontWeight.w900),
        ),
        SizedBox(height: Get.height * 0.02),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(color: ColorManager.kGreyColor),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: summaryWidgets, // Use the passed list of widgets
          ),
        ),
      ],
    );
  }
}

class DetailsRow extends StatelessWidget {
  final String? title;
  final String? description;
  const DetailsRow({
    super.key,
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w300, fontSize: 12),
            ),
            Text(
              '$description',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w900, fontSize: 12),
            )
          ],
        ),
        SizedBox(
          height: Get.height * 0.02,
        )
      ],
    );
  }
}

String parseInvestigationData(String input) {
  List<String> parts = input.split(';');

  if (parts.length == 3) {
    String investigationName = parts[0];
    int value1 = int.tryParse(parts[1]) ?? 0;
    int value2 = int.tryParse(parts[2]) ?? 0;

    return investigationName;
  } else {
    return "Invalid data format";
  }
}

String testName(String input) {
  String? testName = parseInvestigationData(input);
  String? result = testName.split('--').last;
  return result;
}