import 'dart:io';
import 'package:flutter_riderapp/Widgets/Utils/mask.dart';
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
import 'package:flutter_riderapp/controllers/viewinformation.dart';
import 'package:flutter_riderapp/data/Notification_repo/auth_repo.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                                // validator: (value) {
                                //   if (edit.selectedpersonalTitle?.id == null ||
                                //       edit.selectedpersonalTitle?.id == "") {
                                //     return 'Please Select Sersonal Title'.tr;
                                //   } else {
                                //     return null;
                                //   }
                                // },
                                onTap: () async {
                                  edit.selectedpersonalTitle = null;
                                  PTitle generic = await searchabledropdown1(
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
                                labelText: 'Title'.tr,
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
                                labelText: 'First Name'.tr,
                                controller: edit.firstname,
                                hintText: 'First Name'.tr,
                              ),
                              EditProfileCustomTextField(
                                // validator: (p0) {
                                //   if (p0!.isEmpty) {
                                //     return 'Please Enter Middle Name'.tr;
                                //   }
                                //   return null;
                                // },
                                labelText: 'Middle Name'.tr,
                                controller: edit.middlename,
                                hintText: 'Middle Name'.tr,
                              ),
                              EditProfileCustomTextField(
                                // validator: (p0) {
                                //   if (p0!.isEmpty) {
                                //     return 'Please Enter Last Name'.tr;
                                //   }
                                //   return null;
                                // },
                                labelText: 'Last Name'.tr,
                                controller: edit.lastname,
                                hintText: 'Last Name'.tr,
                              ),
                              EditProfileCustomTextField1(
                                keyboardTypenew: TextInputType.number,
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return 'Enter Emirates Id'.tr;
                                  }
                                  return null;
                                },
                                labelText: 'Emirates Id'.tr,
                                controller: edit.nationalid,
                                hintText: 'Emirates Id'.tr,
                                // formatters: [Masks().maskFormatter],
                              ),
                              EditProfileCustomTextField(
                                  onTap: () async {
                                    edit.ontap = true;
                                    edit.selectDateAndTime(
                                        context,
                                        EditPatientController.arrival,
                                        edit.formatearrival);
                                  },
                                  labelText: "Date of Birth",
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
                                labelText: 'Mobile Number'.tr,
                              ),
                              EditProfileCustomTextField(
                                validator: (p0) {
                                  if (p0!.isEmpty) {
                                    return 'Please Enter Email'.tr;
                                  }
                                  return null;
                                },
                                controller: edit.email,
                                labelText: 'Email'.tr,
                                hintText: 'Email'.tr,
                              ),
                              EditProfileCustomTextField(
                                suffixIcon: const Icon(Icons.arrow_drop_down),
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
                                      await searchabledropdown1(
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
                                labelText: 'Gender'.tr,
                                readonly: true,
                                hintText: edit.selectedgender?.id == "" ||
                                        edit.selectedgender?.id == null
                                    ? 'Gender'.tr
                                    : edit.selectedgender?.name.toString(),
                              ),
                              EditProfileCustomTextField(
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                                validator: (p0) {
                                  if (edit.selectedmaritalStatus?.id == null ||
                                      edit.selectedmaritalStatus?.id == "") {
                                    return 'Please Select Marital Status'.tr;
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  edit.selectedmaritalStatus = null;
                                  MSData generic = await searchabledropdown1(
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
                                labelText: 'Marital Status'.tr,
                                hintText: edit.selectedmaritalStatus?.id ==
                                            "" ||
                                        edit.selectedmaritalStatus?.id == null
                                    ? 'Marital Status'.tr
                                    : edit.selectedmaritalStatus?.name
                                        .toString(),
                              ),
                              EditProfileCustomTextField(
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                                validator: (p0) {
                                  if (edit.selectedcountry?.id == null ||
                                      edit.selectedcountry?.id == "") {
                                    return 'Please Select Country'.tr;
                                  }
                                  return null;
                                },
                                onTap: () async {
                                  Countries generic = await searchabledropdown1(
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
                                labelText: 'Country'.tr,
                                readonly: true,
                                hintText: edit.selectedcountry?.id == "" ||
                                        edit.selectedcountry?.id == null
                                    ? 'Country'.tr
                                    : edit.selectedcountry?.name ??
                                        "Country".tr,
                              ),
                              EditProfileCustomTextField(
                                suffixIcon: const Icon(Icons.arrow_drop_down),
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
                                        await searchabledropdown1(
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
                                labelText: 'State'.tr,
                                hintText: edit.selectedprovince?.id == "" ||
                                        edit.selectedprovince?.id == null
                                    ? 'State'.tr
                                    : edit.selectedprovince?.name == null
                                        ? 'State'.tr
                                        : edit.selectedprovince?.name ?? "",
                              ),
                              EditProfileCustomTextField(
                                suffixIcon: const Icon(Icons.arrow_drop_down),
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
                                    Cities generic = await searchabledropdown1(
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
                                labelText: 'City'.tr,
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
                                labelText: 'Address'.tr,
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
                                    if (formkey.currentState!.validate() &&
                                            edit.formatearrival != null ||
                                        edit.formatearrival?.value != "") {
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
  final List<TextInputFormatter>? formatters;
  String? labelText;
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
    this.formatters,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: Get.height * 0.01),
          child: Text(
            labelText ?? "",
            style: const TextStyle(
              color: ColorManager.kblackColor,
              fontSize: 12,
            ),
          ),
        ),
        TextFormField(
          inputFormatters: formatters,
          maxLength: maxLength,
          keyboardType: keyboardTypenew,
          controller: controller,
          onChanged: onchanged,
          validator: validator,
          onTap: onTap ?? () {},
          maxLines: maxlines ?? 1,
          readOnly: readonly,
          decoration: InputDecoration(
              counterText: "",
              errorStyle: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.red, fontSize: 12),
              suffixIcon: suffixIcon,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
              // label: readonly == false
              //     ? Text(labelText ?? "")
              //     : const SizedBox.shrink(),
              // labelStyle: readonly == false
              //     ? const TextStyle(
              //         color: ColorManager.kblackColor, fontSize: 12)
              //     : const TextStyle(
              //         color: ColorManager.kWhiteColor, fontSize: 0),
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

class EditProfileCustomTextField1 extends StatelessWidget {
  final TextEditingController? controller;
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
  final List<TextInputFormatter>? formatters;
  String? labelText;

  EditProfileCustomTextField1({
    Key? key,
    this.keyboardTypenew,
    this.hintText,
    this.suffixIcon,
    this.fillColor = Colors.white,
    this.readonly = false,
    this.isSizedBoxAvailable = true,
    this.suffixText,
    this.suffixStyle,
    this.prefixIcon,
    this.maxlines,
    this.padding,
    this.onTap,
    this.validator,
    this.onchanged,
    this.controller,
    this.maxLength,
    this.formatters,
    this.labelText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: Get.height * 0.01),
          child: Text(
            labelText ?? "",
            style: const TextStyle(
              color: ColorManager.kblackColor,
              fontSize: 12,
            ),
          ),
        ),
        TextFormField(
          maxLength: maxLength,
          keyboardType: keyboardTypenew,
          controller: controller,
          onChanged: onchanged,
          validator: validator,
          onTap: onTap ?? () {},
          maxLines: maxlines ?? 1,
          readOnly: readonly,
          inputFormatters: [
            MaskedTextInputFormatter(
              mask: '###-####-#######-#',
            ),
            ...?formatters,
          ],
          decoration: InputDecoration(
            counterText: "",
            errorStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.red, fontSize: 12),
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black, fontSize: 14),
            // label: readonly == false
            //     ? Text(labelText ?? "")
            //     : const SizedBox.shrink(),
            // labelStyle: readonly == false
            //     ? const TextStyle(color: ColorManager.kblackColor, fontSize: 12)
            //     : const TextStyle(color: ColorManager.kWhiteColor, fontSize: 0),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.grey),
            ),
          ),
        ),
        if (isSizedBoxAvailable == true)
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
      ],
    );
  }
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;

  MaskedTextInputFormatter({required this.mask});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (oldValue.text.length >= newValue.text.length) {
      return newValue;
    }

    int selectionIndex = newValue.selection.end;
    String maskedText = '';
    int maskIndex = 0;

    for (int i = 0; i < newValue.text.length; i++) {
      if (maskIndex >= mask.length) break;

      if (mask[maskIndex] == '#') {
        if (int.tryParse(newValue.text[i]) != null) {
          maskedText += newValue.text[i];
          maskIndex++;
        } else {
          break;
        }
      } else {
        maskedText += mask[maskIndex];
        if (newValue.text[i] == mask[maskIndex]) {
          maskIndex++;
        }
      }
    }

    return TextEditingValue(
      text: maskedText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}

searchabledropdown1(BuildContext context, List<dynamic> list) async {
  TextEditingController search = TextEditingController();
  dynamic generic;
  String title = "";
  await showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return SizedBox(
              width: Get.width,
              height: MediaQuery.of(context).size.height * 0.7,
              child: AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          hintStyle: GoogleFonts.poppins(
                              color: ColorManager.kPrimaryColor),
                          hintText: 'search'.tr,
                          filled: true,
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: ColorManager.kPrimaryLightColor),
                              borderRadius: BorderRadius.circular(8)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: const BorderSide(
                                color: ColorManager.kPrimaryLightColor),
                          ),
                          fillColor: ColorManager.kPrimaryLightColor,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: ColorManager.kPrimaryColor,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ColorManager.kPrimaryLightColor),
                            borderRadius: BorderRadius.all(
                              Radius.circular(0.0),
                            ),
                          ),
                        ),
                        controller: search,
                        onChanged: (val) {
                          title = val;
                          setState(() {
                            title = val;
                          });
                        },
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.6,
                          child: ListView.builder(
                            itemCount: list.length,
                            itemBuilder: ((context, index) {
                              if (search.text.isEmpty) {
                                return InkWell(
                                  onTap: () {
                                    generic = list[index];
                                    Navigator.pop(context);
                                    //    LabInvestigationController.i.updateLabTest(generic!);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      Text(
                                        list[index].name.toString(),
                                        style: const TextStyle(
                                            color: ColorManager.kblackColor),
                                      ),
                                      const Divider()
                                    ],
                                  ),
                                );
                              } else if (list[index]
                                  .name
                                  .toString()
                                  .toLowerCase()
                                  .contains(title.toLowerCase())) {
                                return InkWell(
                                  onTap: () {
                                    generic = list[index];
                                    Navigator.pop(context);
                                    //  LabInvestigationController.i.updateLabTest(generic!);
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.02,
                                      ),
                                      Text(
                                        list[index].name.toString(),
                                        style: const TextStyle(
                                            color: ColorManager.kblackColor),
                                      ),
                                      const Divider()
                                    ],
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                          ))
                    ],
                  ),
                ),
              ),
            );
          },
        );
      });
  if (generic != null) {
    return generic;
  }
  return [];
  //  search.clear();
}
