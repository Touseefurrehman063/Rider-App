import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Components/images/Images.dart';
import 'package:flutter_riderapp/Controller/api.dart';
import 'package:flutter_riderapp/Models/User.dart';
import 'package:flutter_riderapp/Models/labtest.dart';
import 'package:flutter_riderapp/Screen/Login/_signup.dart';
import 'package:flutter_riderapp/Screen/labqueue/labqeue.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/Widgets/Utils/imagecontainer.dart';
import 'package:flutter_riderapp/Widgets/Utils/toaster.dart';
import 'package:flutter_riderapp/Widgets/searchabledropdown.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:flutter_riderapp/helpers/values_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Labinvestigation extends StatefulWidget {
  final User user;
  const Labinvestigation({super.key, required this.user});

  @override
  State<Labinvestigation> createState() => _LabinvestigationState();
}

class _LabinvestigationState extends State<Labinvestigation> {
  bool? discountValue;
  String? TypeValue;
  var item1 = [
    'percentage'.tr,
    'amount'.tr,
  ];
  @override
  void initState() {
    super.initState();

    call();
  }

  call() async {
    labtests = await getlabtest();
    await appointmentserviceapi(widget.user.branchlocationid ?? "",
        userprofile?.id ?? "", widget.user.patientid, widget.user.LabNo);
    setState(() {});
  }

  List<Labtest> labtests = [];
  List<Labtest> selectedlabtestlist = [];
  Labtest? selectedlabtest;
  dynamic subtotal = 0;
  double grandtotal = 0;
  @override
  Widget build(BuildContext context) {
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
            'labinvestigation'.tr,
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const ImageContainer(
                    isSvg: false,
                    imagePath: Images.microscope,

                    // color: ColorManager.kWhiteColor,
                    backgroundColor: ColorManager.kPrimaryColor,
                  ),

                  InkWell(
                    onTap: () async {
                      Labtest? generic =
                          await searchabledropdown(context, labtests);

                      if (generic != null) {
                        selectedlabtest = generic;
                      }
                      setState(() {});
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorManager.kPrimaryLightColor,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        color: ColorManager.kPrimaryLightColor,
                      ),
                      width: Get.width * 0.55,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              selectedlabtest?.name ?? "selecttest".tr,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color:
                                      // cont.selectedLabtest?.name != null
                                      //     ? ColorManager.kPrimaryColor
                                      ColorManager.kPrimaryColor,
                                  fontWeight: FontWeight.w900),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: MediaQuery.of(context).size.width * 0.06,
                            color: Colors.grey[700],
                          )
                        ],
                      ),
                    ),
                  ),

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

                  ImageContainer(
                    onpressed: () {
                      if (selectedlabtestlist.contains(selectedlabtest)) {
                        Showtoaster().classtoaster("Lab Test Already added");
                      } else {
                        subtotal = subtotal + selectedlabtest?.actualPrice;
                        selectedlabtestlist.add(selectedlabtest ?? Labtest());
                      }
                      setState(() {});
                    },
                    imagePath: Images.plus,
                    isSvg: false,
                    color: ColorManager.kWhiteColor,
                    backgroundColor: ColorManager.kPrimaryColor,
                  )
                ],
              ),
              SizedBox(
                height: Get.height * 0.035,
              ),
              Container(
                width: Get.width * 0.9,
                padding: const EdgeInsets.all(AppPadding.p20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: const Color.fromARGB(255, 232, 227, 227),
                    )),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${'test'.tr} ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Price',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: selectedlabtestlist.length,
                        itemBuilder: (itemBuilder, index) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        subtotal = subtotal -
                                            selectedlabtestlist[index]
                                                .actualPrice;
                                        selectedlabtestlist.removeAt(index);
                                        setState(() {});
                                      },
                                      child: Image.asset(
                                        'assets/crpss.png',
                                        height: Get.height * 0.022,
                                      )),
                                  SizedBox(
                                    width: Get.width * 0.01,
                                  ),
                                  Expanded(
                                      child: Text(
                                    "${selectedlabtestlist[index].name}",
                                    overflow: TextOverflow.ellipsis,
                                  )),
                                  const Spacer(),
                                  Text("${selectedlabtestlist[index].price}"),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.01,
                              )
                            ],
                          );
                        }),
                    SizedBox(
                      height: Get.height * 0.03,
                    ),
                    const Divider(
                      color: ColorManager.kblackColor,
                    ),
                    SizedBox(
                      height: Get.height * 0.01,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'discount'.tr,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w900),
                                ),
                                Text(
                                  'yes'.tr,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                  width: Get.width * 0.08,
                                  child: Radio(
                                    value: true,
                                    groupValue: discountValue,
                                    onChanged: (value) {
                                      setState(() {
                                        discountValue = value;
                                      });
                                    },
                                  ),
                                ),
                                Text(
                                  'no'.tr,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  height: Get.height * 0.02,
                                  width: Get.width * 0.08,
                                  child: Radio(
                                    value: false,
                                    groupValue: discountValue,
                                    onChanged: (value) {
                                      setState(() {
                                        discountValue = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black, width: 0.5),
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                              ),
                              width: Get.width * 0.4,
                              height:
                                  MediaQuery.of(context).size.height * 0.045,
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
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
                                height: Get.height * 0.045,
                                width: Get.width * 0.4,
                                child: const AuthTextField()),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            SizedBox(
                              height: Get.height * 0.045,
                              width: Get.width * 0.4,
                              child: ElevatedButton(
                                  onPressed: () {
                                    double temp = 0.0;
                                    for (int i = 0;
                                        i < selectedlabtestlist.length;
                                        i++) {
                                      print(
                                          "${selectedlabtestlist[i].vATPercentageAmount ?? 0.0}");
                                      if (selectedlabtestlist[i]
                                                  .vATPercentageAmount ==
                                              null
                                          //     &&
                                          // selectedlabtestlist[i]
                                          //         .vATPercentageAmount !=
                                          //     0.0
                                          ) {
                                        temp =
                                            selectedlabtestlist[i].actualPrice;
                                      } else {
                                        temp =
                                            selectedlabtestlist[i].actualPrice /
                                                    selectedlabtestlist[i]
                                                        .vATPercentageAmount ??
                                                0.0;
                                      }
                                      grandtotal = grandtotal - temp;

                                      // grandtotal=selectedlabtestlist[i].vATPercentageAmount
                                    }
                                    setState(() {});
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1272D3),
                                  ),
                                  child: const Text("Add")),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Sub Total: $subtotal",
                                style: GoogleFonts.poppins(fontSize: 12)),
                            SizedBox(
                              height: Get.height * 0.009,
                            ),
                            Text("Discount: 0.0",
                                style: GoogleFonts.poppins(fontSize: 12)),
                            SizedBox(
                              height: Get.height * 0.009,
                            ),
                            Text("Grand Total: 0.0",
                                style: GoogleFonts.poppins(
                                    fontSize: 12, fontWeight: FontWeight.bold)),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              InkWell(
                onTap: () {
                  // paymentMethodDialogue(context);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 12, horizontal: 10)
                            .copyWith(right: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorManager.kPrimaryLightColor),
                    child: Row(
                      children: [
                        Text("paymentmethod".tr,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: ColorManager.kPrimaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900)),
                        const Spacer(),
                        Image.asset(
                          Images.mastercard,
                          height: Get.height * 0.05,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Get.height * 0.05,
              ),
              Column(
                children: [
                    CupertinoButton(
                              color: CupertinoColors.activeBlue,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 120, vertical: 0.5),
                              borderRadius: BorderRadius.circular(8),
                              onPressed: () async {
                                 await checkinapi(widget.user.appointmentno ?? "",
                          widget.user.branchlocationid ?? "");
                      Get.to(const Labqeue());
                              },
                              child: Text(
                                "checkin".tr,
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: CupertinoColors.white),
                              )),
                
                ],
              ),
            ],
          ),
        ));
  }
}
