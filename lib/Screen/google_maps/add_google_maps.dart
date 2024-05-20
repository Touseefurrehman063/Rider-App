import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Components/primary_button.dart';
import 'package:flutter_riderapp/Widgets/Utils/custom_text_field.dart';
import 'package:flutter_riderapp/controllers/addres_controller/address_controller.dart';
import 'package:flutter_riderapp/controllers/google_maps_controller/google_maps_controller.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:flutter_riderapp/helpers/values_manager.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LabGoogleMaps extends StatefulWidget {
  const LabGoogleMaps({super.key});

  @override
  State<LabGoogleMaps> createState() => _LabGoogleMapsState();
}

class _LabGoogleMapsState extends State<LabGoogleMaps> {
  @override
  void initState() {
    LabAddressController.i.getcurrentLocation().then((value) {
      LabAddressController.i.latitude = value.latitude;
      LabAddressController.i.longitude = value.longitude;
      LabAddressController.i.initialAddress(value.latitude, value.longitude);
      log('latitude: ${LabAddressController.i.latitude} , longitude ${LabAddressController.i.longitude}');
      LabAddressController.i.markers.clear();
      LabAddressController.i.markers.add(Marker(
          infoWindow: const InfoWindow(
              title: 'Current Location',
              snippet: 'This is my current Location'),
          position: LatLng(LabAddressController.i.latitude!,
              LabAddressController.i.longitude!),
          markerId: const MarkerId('1')));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          "Select Location",
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
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p20),
        child: Stack(
          children: [
            SizedBox(
              height: Get.height * 0.02,
            ),
            SizedBox(
              height: Get.height * 0.8,
              child: GetBuilder<LabAddressController>(builder: (address) {
                return address.latitude != null && address.longitude != null
                    ? GoogleMap(
                        // myLocationEnabled: true,
                        onTap: (argument) async {
                          setState(() {
                            address.markers.clear();
                            address.markers.add(Marker(
                                infoWindow: const InfoWindow(
                                    title: 'Current Location',
                                    snippet: 'This is my current Location'),
                                position: LatLng(
                                    argument.latitude, argument.longitude),
                                markerId: const MarkerId('1')));
                            address.currentPlaceList.clear();
                          });
                          GoogleMapController controller =
                              await LabAddressController.i.mapController.future;

                          controller.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  zoom: 14,
                                  target: LatLng(
                                      argument.latitude, argument.longitude))));
                          log(LabAddressController.i.currentLocation
                              .toString());

                          List<Placemark>? placemark =
                              await placemarkFromCoordinates(
                            argument.latitude,
                            argument.longitude,
                          );

                          address.updateAddress(
                              '${placemark[0].subLocality} ${placemark[0].locality} ${placemark[0].country} ${placemark[0].street}');
                          log(LabAddressController.address.toString());
                          address.currentLocation = await locationFromAddress(
                              LabAddressController.address!);
                        },
                        initialCameraPosition: CameraPosition(
                            target: LatLng(LabAddressController.i.latitude!,
                                LabAddressController.i.longitude!),
                            zoom: 14),
                        mapType: MapType.normal,
                        markers: Set.of(LabAddressController.i.markers),
                        onMapCreated: (controller) {
                          LabAddressController.i.mapController
                              .complete(controller);
                        },
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              }),
            ),
            Column(
              children: [
                GetBuilder<LabAddressController>(builder: (cont) {
                  return Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: cont.controller,
                          onchanged: (value) {
                            log(value.toString());
                            setState(() {
                              LabAddressController.i.getSuggestion(value);
                            });
                          },
                          hintText: 'search'.tr,
                          prefixIcon: const Icon(
                            Icons.search,
                            color: ColorManager.kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                GetBuilder<LabAddressController>(builder: (address) {
                  return ListView.builder(
                      itemCount: address.currentPlaceList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            if (address.currentPlaceList.isNotEmpty) {
                              address.currentLocation =
                                  await locationFromAddress(address
                                      .currentPlaceList[index]['description']);
                            }

                            setState(() {
                              address.currentPlaceList.clear();
                              address.markers.clear();
                              address.markers.add(Marker(
                                  infoWindow: const InfoWindow(
                                      title: 'Current Location',
                                      snippet: 'This is my current Location'),
                                  position: LatLng(
                                      address.currentLocation!.reversed.last
                                          .latitude,
                                      address.currentLocation!.reversed.last
                                          .longitude),
                                  markerId: const MarkerId('1')));
                            });

                            GoogleMapController controller =
                                await LabAddressController
                                    .i.mapController.future;
                            controller.animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                                    zoom: 10,
                                    target: LatLng(
                                        LabAddressController.i.currentLocation!
                                            .reversed.last.latitude,
                                        LabAddressController.i.currentLocation!
                                            .reversed.last.longitude))));
                            log(LabAddressController.i.currentLocation
                                .toString());

                            List<Placemark>? placemark =
                                await placemarkFromCoordinates(
                                    address.currentLocation!.last.latitude,
                                    address.currentLocation!.last.longitude);

                            address.updateAddress(
                                '${placemark[0].subLocality} ${placemark[0].locality} ${placemark[0].country} ${placemark[0].street}');
                            log(LabAddressController.address.toString());
                            address.currentLocation = await locationFromAddress(
                                LabAddressController.address!);
                            CameraUpdate.newCameraPosition(CameraPosition(
                                zoom: 10,
                                target: LatLng(
                                    address.currentLocation!.reversed.last
                                        .latitude,
                                    address.currentLocation!.reversed.last
                                        .longitude)));
                          },
                          child: Container(
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                LabAddressController.i.currentPlaceList[index]
                                    ['description'],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        );
                      });
                }),
                const Spacer(),
                PrimaryButton(
                    fontSize: 14,
                    title: 'Select Location'.tr,
                    onPressed: () async {
                      LabAddressController.i.markers.clear();
                      Get.back();
                      LabAddressController.i.currentLocation =
                          await locationFromAddress(
                              LabAddressController.address!);
                    },
                    color: ColorManager.kPrimaryColor,
                    textcolor: ColorManager.kWhiteColor)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
