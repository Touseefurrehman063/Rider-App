import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riderapp/LocalDb/localDB.dart';
import 'package:flutter_riderapp/Models/languages_Model/languagesmodel.dart';
import 'package:flutter_riderapp/controllers/Languages_controller/languages_controller.dart';
import 'package:flutter_riderapp/helpers/color_manager.dart';
import 'package:get/get.dart';


Future<String?> languageSelector(
    BuildContext context, List<LanguageModel> languageList) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) =>
        StatefulBuilder(builder: (context, newState) {
      LanguageController.i.updateSelected(LanguageController.i.selected);
      return AlertDialog(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(
          'selectLanguage'.tr,
          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
        ),
        content: SingleChildScrollView(
            child: SizedBox(
          width: Get.width,
          child: GetBuilder<LanguageController>(builder: (cont) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: languageList.length,
                itemBuilder: (context, index) {
                  final lang = languageList[index];
                  log(lang.toJson().toString());
                  return RadioListTile<LanguageModel>(
                    fillColor:
                        MaterialStateProperty.all(ColorManager.kWhiteColor),
                    activeColor: Colors.white,
                    value: lang,
                    groupValue: cont.selected,
                    onChanged: (LanguageModel? lang) {
                      if (lang != null) {
                        newState(
                          () {
                            // log(lang.name.toString());
                            cont.updateSelectedIndex(index);
                            cont.updateSelected(lang);
                          },
                        );
                      }
                    },
                    title: Text(
                      lang.name!,
                      style: const TextStyle(color: ColorManager.kWhiteColor),
                    ),
                  );
                });
          }),
        )),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ColorManager.kPrimaryColor),
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child:  Text('cancel'.tr)),
                ),
                const SizedBox(
                  width: 10,
                ),
                GetBuilder<LanguageController>(builder: (cont) {
                  return Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: ColorManager.kPrimaryLightColor),
                        onPressed: () {
                         
                          cont.updateLocale(cont.selected!.locale!);
                          LocalDb().setLanguage(cont.selected);
                           Navigator.pop(context, 'ok'.tr);
                          
                        },
                        child:  Text(
                          'ok'.tr,
                          style: const TextStyle(color: Colors.black),
                        )),
                  );
                })
              ],
            ),
          )
        ],
      );
    }),
  );
}
