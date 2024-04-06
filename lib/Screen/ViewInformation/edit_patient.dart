import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riderapp/Models/cities_model.dart';
import 'package:flutter_riderapp/Models/countries_model.dart';
import 'package:flutter_riderapp/Models/genders_model.dart';
import 'package:flutter_riderapp/Models/marital_status.dart';
import 'package:flutter_riderapp/Models/person_title.dart';
import 'package:flutter_riderapp/Models/provinces_model.dart';
import 'package:flutter_riderapp/Widgets/searchabledropdown.dart';
import 'package:flutter_riderapp/controllers/edit_patient_controller.dart';
import 'package:flutter_riderapp/data/Notification_repo/auth_repo.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPatientNew extends StatefulWidget {
  String pid;
  EditPatientNew({required this.pid, super.key});
  @override
  State<EditPatientNew> createState() => _EditPatientNewState();
}

class _EditPatientNewState extends State<EditPatientNew> {
  final formkey = GlobalKey<FormState>();
  bool isLoading = false;
  _getTitle() async {
    AuthRepo ar = AuthRepo();
    EditPatientController.i.updatepersonalTitleList(
      await ar.getPersonalTitle(),
    );
  }

  _getMaritalStatus() async {
    AuthRepo ar = AuthRepo();
    EditPatientController.i.updatemaritalStatusList(
      await ar.getMaritalStatus(),
    );
  }

  _getGenders() async {
    AuthRepo ar = AuthRepo();
    EditPatientController.i.updategenderList(
      await ar.getGendersList(),
    );
  }

  _getCountries() async {
    AuthRepo ar = AuthRepo();
    EditPatientController.i.updatecountriesList(
      await ar.getCountries(),
    );
  }

  _getProvinces(cid) async {
    AuthRepo ar = AuthRepo();
    cid ??= EditPatientController.i.selectedcountry?.id;
    EditPatientController.i.updateprovinceList(
      await ar.getProvinces(cid),
    );
  }

  _getCities(cid) async {
    AuthRepo ar = AuthRepo();
    cid ??= EditPatientController.i.selectedcity?.id;
    EditPatientController.i.updatecitiesList(
      await ar.getCities(cid),
    );
  }

  @override
  void initState() {
    _getCountries();
    _getProvinces(EditPatientController.i.selectedcountry?.id);
    _getCities(EditPatientController.i.selectedcity?.id);
    _getMaritalStatus();
    _getGenders();
    _getTitle();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var edit = Get.put<EditPatientController>(EditPatientController());

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xff0F64C6),
              )),
          title: Text(
            'Edit Patient'.tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              height: 1.175,
              color: const Color(0xFF1272D3),
            ),
          ),
          centerTitle: true,
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: formkey,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/helpbackgraound.png'),
                    alignment: Alignment.centerLeft,
                  ),
                ),
                child: GetBuilder<EditPatientController>(builder: (cont) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              EditProfileCustomTextField(
                                validator: (value) {
                                  if (edit.selectedpersonalTitle?.id == null ||
                                      edit.selectedpersonalTitle?.id == "") {
                                    return 'Please Select Sersonal Title'.tr;
                                  } else {
                                    return null;
                                  }
                                },
                                onTap: () async {
                                  edit.selectedpersonalTitle = null;
                                  PTitle generic = await searchabledropdown(
                                      context, edit.personalTitleList);
                                  edit.selectedpersonalTitle = null;
                                  edit.updateselectedpersonalTitle(generic);
                                  if (generic.id == null) {
                                    edit.selectedpersonalTitle = generic;
                                    edit.selectedpersonalTitle =
                                        (generic.id == null)
                                            ? null
                                            : edit.selectedpersonalTitle;
                                  }
                                },
                                readonly: true,
                                hintText: edit.selectedpersonalTitle?.id ==
                                            "" ||
                                        edit.selectedpersonalTitle?.id == null
                                    ? 'Title'.tr
                                    : edit.selectedpersonalTitle?.name
                                        .toString(),
                              ),
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return 'Please Enter First Name'.tr;
                                  }
                                  return null;
                                },
                                controller: edit.firstname,
                                hintText: 'First Name'.tr,
                              ),
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return 'Please Enter Middle Name'.tr;
                                  }
                                  return null;
                                },
                                controller: edit.middlename,
                                hintText: 'Middle Name'.tr,
                              ),
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return 'Please Enter Last Name'.tr;
                                  }
                                  return null;
                                },
                                controller: edit.lastname,
                                hintText: 'Last Name'.tr,
                              ),
                              EditProfileCustomTextField(
                                  onTap: () async {
                                    edit.ontap = true;
                                    edit.selectDateAndTime(
                                        context,
                                        EditPatientController.arrival,
                                        edit.formatearrival);
                                  },
                                  readonly: true,
                                  hintText: edit.formatearrival == null ||
                                          edit.formatearrival?.value == ""
                                      ? "Date of Birth"
                                      : edit.formatearrival.toString()),
                              EditProfileCustomTextField(
                                keyboardTypenew: TextInputType.phone,
                                maxLength: 15,
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return 'Please Enter Mobile Number'.tr;
                                  }
                                  return null;
                                },
                                controller: edit.phone,
                                hintText: 'Mobile Number'.tr,
                              ),
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return 'Please Enter Email'.tr;
                                  }
                                  return null;
                                },
                                controller: edit.email,
                                hintText: 'Email'.tr,
                              ),
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (edit.selectedgender?.id == null ||
                                      edit.selectedgender?.id == "") {
                                    return 'Please Select Gender'.tr;
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  edit.selectedgender = null;
                                  GendersData generic =
                                      await searchabledropdown(
                                          context, edit.genderList);
                                  edit.selectedgender = null;
                                  edit.updateselectedgender(generic);

                                  if (generic.id == null) {
                                    edit.selectedgender = generic;
                                    edit.selectedgender = (generic.id == null)
                                        ? null
                                        : edit.selectedgender;
                                  }
                                },
                                readonly: true,
                                hintText: edit.selectedgender?.id == "" ||
                                        edit.selectedgender?.id == null
                                    ? 'Gender'.tr
                                    : edit.selectedgender?.name.toString(),
                              ),
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (edit.selectedmaritalStatus?.id == null ||
                                      edit.selectedmaritalStatus?.id == "") {
                                    return 'Please Select Marital Status'.tr;
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  edit.selectedmaritalStatus = null;
                                  MSData generic = await searchabledropdown(
                                      context, edit.maritalStatusList);
                                  edit.selectedmaritalStatus = null;
                                  edit.updateselectedmaritalStatus(generic);

                                  if (generic.id == null) {
                                    edit.selectedmaritalStatus = generic;
                                    edit.selectedmaritalStatus =
                                        (generic.id == null)
                                            ? null
                                            : edit.selectedmaritalStatus;
                                  }
                                },
                                readonly: true,
                                hintText: edit.selectedmaritalStatus?.id ==
                                            "" ||
                                        edit.selectedmaritalStatus?.id == null
                                    ? 'Marital Status'.tr
                                    : edit.selectedmaritalStatus?.name
                                        .toString(),
                              ),
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (edit.selectedcountry?.id == null ||
                                      edit.selectedcountry?.id == "") {
                                    return 'Please Select Country'.tr;
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  Countries generic = await searchabledropdown(
                                      context, edit.countriesList);
                                  edit.selectedcountry = null;
                                  edit.updateselectedCountry(generic);

                                  if (generic.id != null) {
                                    edit.selectedcity = null;
                                    edit.selectedprovince = null;
                                    edit.selectedcountry = generic;
                                    edit.selectedcountry = (generic.id == null)
                                        ? null
                                        : edit.selectedcountry;
                                  }
                                  String cid =
                                      edit.selectedcountry?.id.toString() ?? "";
                                  setState(() {
                                    _getProvinces(cid);
                                  });
                                },
                                readonly: true,
                                hintText: edit.selectedcountry?.id == "" ||
                                        edit.selectedcountry?.id == null
                                    ? 'Country'.tr
                                    : edit.selectedcountry?.name ??
                                        "Country".tr,
                              ),
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (edit.selectedprovince?.id == null ||
                                      edit.selectedprovince?.id == "") {
                                    return 'Please  Select State'.tr;
                                  }
                                  return null;
                                },
                                readonly: true,
                                onTap: () async {
                                  if (edit.selectedcountry != null) {
                                    Provinces generic =
                                        await searchabledropdown(
                                            context, edit.provinceList);
                                    edit.selectedprovince = null;
                                    edit.updateselectedprovince(generic);

                                    if (generic.id != null) {
                                      edit.selectedcity = null;
                                      edit.selectedprovince = generic;
                                      edit.selectedprovince =
                                          (generic.id == null)
                                              ? null
                                              : edit.selectedprovince;
                                    }
                                    String cid =
                                        edit.selectedprovince?.id.toString() ??
                                            "";
                                    setState(() {
                                      _getCities(cid);
                                    });
                                  }
                                },
                                hintText: edit.selectedprovince?.id == "" ||
                                        edit.selectedprovince?.id == null
                                    ? 'State'.tr
                                    : edit.selectedprovince?.name == null
                                        ? 'State'.tr
                                        : edit.selectedprovince?.name ?? "",
                              ),
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (edit.selectedcity?.id == null ||
                                      edit.selectedcity?.id == "") {
                                    return 'Please Select City'.tr;
                                  }
                                  return null;
                                },
                                readonly: true,
                                onTap: () async {
                                  if (edit.selectedcountry != null &&
                                      edit.selectedprovince != null) {
                                    Cities generic = await searchabledropdown(
                                        context, edit.citiesList);
                                    edit.selectedcity = null;
                                    edit.updateselectedcity(generic);

                                    if (generic.id != null) {
                                      edit.selectedcity = null;
                                      edit.selectedcity = generic;
                                      edit.selectedcity = (generic.id == null)
                                          ? null
                                          : edit.selectedcity;
                                    }
                                    setState(() {});
                                  }
                                },
                                hintText: edit.selectedcity?.id == ""
                                    ? 'City'.tr
                                    : edit.selectedcity?.id == null
                                        ? 'City'.tr
                                        : edit.selectedcity?.name ?? "",
                              ),
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return 'Please Enter Address'.tr;
                                  }
                                  return null;
                                },
                                controller: edit.address,
                                hintText: 'Address'.tr,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              CupertinoButton(
                                  color: CupertinoColors.activeBlue,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 120, vertical: 0.5),
                                  borderRadius: BorderRadius.circular(8),
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      String text = cont.phone.text;
                                      int digitCount = 0;

                                      digitCount = text
                                          .replaceAll(RegExp(r'[^0-9]'), '')
                                          .length;
                                      if (digitCount < 10) {
                                        Fluttertoast.showToast(
                                            msg: "Enter Valid Mobile Number",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor:
                                                ColorManager.kRedColor,
                                            textColor: ColorManager.kWhiteColor,
                                            fontSize: 14.0);
                                      } else {
                                        try {
                                          setState(() {
                                            isLoading = true;
                                          });
                                          AuthRepo ar = AuthRepo();

                                          await ar
                                              .updatePatientProfile(widget.pid);

                                          setState(() {
                                            isLoading = false;
                                          });
                                        } catch (e) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "Fill All Fields",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor:
                                              ColorManager.kRedColor,
                                          textColor: ColorManager.kWhiteColor,
                                          fontSize: 14.0);
                                      setState(() {
                                        isLoading = false;
                                      });
                                    }
                                  },
                                  child: isLoading == true
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : Text(
                                          "Update",
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: CupertinoColors.white),
                                        )),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }),
              ),
            ),
          );
        }));
  }
}

// ignore: must_be_immutable
class EditProfileCustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final int? maxlines;
  final Widget? prefixIcon;
  final TextStyle? suffixStyle;
  final String? suffixText;
  final bool? isSizedBoxAvailable;
  final bool readonly;
  final Color? fillColor;
  final Widget? suffixIcon;
  final String? hintText;
  final Function(String)? onchanged;
  TextInputType? keyboardTypenew;
  final int? maxLength;
  EditProfileCustomTextField({
    super.key,
    this.keyboardTypenew,
    this.hintText,
    this.suffixIcon,
    this.fillColor = ColorManager.kPrimaryLightColor,
    this.readonly = false,
    this.isSizedBoxAvailable = true,
    this.suffixText,
    this.suffixStyle,
    this.prefixIcon,
    this.maxlines,
    this.padding,
    this.onTap,
    this.validator,
    this.inputFormatters,
    this.onchanged,
    this.controller,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextFormField(
          maxLength: maxLength,
          keyboardType: keyboardTypenew,
          controller: controller,
          onChanged: onchanged,
          validator: validator,
          onTap: onTap ?? () {},
          maxLines: maxlines ?? 1,
          readOnly: readonly,
          decoration: InputDecoration(
              errorStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.red, fontSize: 12),
              suffixIcon: suffixIcon,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.red)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey))),
          inputFormatters: inputFormatters,
        ),
        isSizedBoxAvailable == true
            ? SizedBox(
                height: Get.height * 0.02,
              )
            : const SizedBox.shrink()
      ],
    );
  }
}
