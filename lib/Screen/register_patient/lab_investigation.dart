import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Components/images/Images.dart';
import 'package:flutter_riderapp/Screen/Login/_signup.dart';
import 'package:flutter_riderapp/Screen/labqueue/labqeue.dart';
import 'package:flutter_riderapp/Widgets/Custombutton.dart';
import 'package:flutter_riderapp/Widgets/Utils/imagecontainer.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:flutter_riderapp/helpers/values_manager.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Labinvestigation extends StatefulWidget {
  const Labinvestigation({super.key});

  @override
  State<Labinvestigation> createState() => _LabinvestigationState();
}

class _LabinvestigationState extends State<Labinvestigation> {
  bool? discountValue;
  String? TypeValue;
  var item1 = [
    'Type',
    'percentage'.tr,
    'amount'.tr,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Row(
            children: [
              InkWell(
                onTap: Get.back,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Image.asset(
                    "assets/back.png",
                    height: Get.height * 0.1,
                    width: Get.width * 0.08,

                    // color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
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
        body: Column(
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
                    // cont.selectedLabtest = null;
                    // LabTestHome generic = await searchabledropdown(
                    //     context, cont.labtests ?? []);
                    // LabInvestigationController.i.update();
                    // cont.selectedLabtest = null;
                    // cont.updateLabTest(generic);

                    // if (generic != null && generic != '') {
                    //   cont.selectedLabtest = generic;
                    //   cont.selectedLabtest = (generic == '')
                    //       ? null
                    //       : cont.selectedLabtest;
                    // }
                    // setState(() {});
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
                        Text(
                          "selecttest".tr,
                          // "${(cont.selectedLabtest != null && cont.selectedLabtest?.name != null) ? (cont.selectedLabtest!.name!.length > 20 ? ('${cont.selectedLabtest?.name!.substring(0, 20)}...') : cont.selectedLabtest?.name) : "Select Tests".tr}",
                          // semanticsLabel:
                          //     "${(cont.selectedLabtest != null) ? (cont.selectedLabtest!.name!.length > 20 ? ('${cont.selectedLabtest?.name!.substring(0, 10)}...') : cont.selectedLabtest) : "Select Tests".tr}",
                          style: const TextStyle(
                              fontSize: 12,
                              color:
                                  // cont.selectedLabtest?.name != null
                                  //     ? ColorManager.kPrimaryColor
                                  ColorManager.kPrimaryColor,
                              fontWeight: FontWeight.w900),
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
                  onpressed: () {},
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
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Price',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.03,
                  ),
                  const Divider(
                    color: ColorManager.kblackColor,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
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
                            height: MediaQuery.of(context).size.height * 0.045,
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
                                onPressed: () {},
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
                          Text("Sub Total: 0.0",
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
            const Spacer(),
            Expanded(
              child: Column(
                children: [
                  CustomButton(
                    onPressed: () async {
                      Get.to(const Labqeue());
                    },
                    title: 'checkin'.tr,
                    radius: 20,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    primcolor: const Color(0xFF1272D3),
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
