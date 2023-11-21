import 'package:flutter/material.dart';
searchableDropdown(
  BuildContext context,
  BoxConstraints constraints,
  List<dynamic> val,
) async {
  TextEditingController search = TextEditingController();
  dynamic generic;
  String title = "";
  String? errorText; // Added errorText to hold validation error message.

  await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.black,
                            width: 0.3,
                          ),
                        ),
                        fillColor: Colors.transparent,
                        errorText: errorText, // Display validation error text.
                      ),
                      controller: search,
                      onChanged: (val) {
                        title = val;
                        setState(() {
                          title;
                        });
                      },
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: ListView.builder(
                        itemCount: val.length,
                        itemBuilder: ((context, index) {
                          if (search.text.isEmpty ||
                              val[index]
                                  .name
                                  .toString()
                                  .toLowerCase()
                                  .contains(title.toLowerCase())) {
                            return InkWell(
                              onTap: () {
                                generic = val[index];
                                Navigator.pop(context);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height:
                                        MediaQuery.of(context).size.height *
                                            0.02,
                                  ),
                                  Text(val[index].name),
                                  const Divider()
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    if (generic == null) {
                      // Validation check: No item selected.
                      setState(() {
                        errorText = 'Please select an item';
                      });
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        },
      );
    },
  );

  return generic;
}
