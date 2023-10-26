import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



searchabledropdown(
    BuildContext context,
    BoxConstraints constraints,
    List<dynamic> val
    //  TextEditingController fullNameController,
    ) async {
     TextEditingController search=TextEditingController();
     dynamic generic;
     String title="";
    await   showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: AlertDialog(
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
                          ),
                          controller: search,
                          onChanged: (val){
                             title=val;
                             setState((){
                               title;
                             });
                          },
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width*0.7,
                            height: MediaQuery.of(context).size.height*0.3,
                            child: ListView.builder(
                              itemCount: val.length,
                              itemBuilder: (
                                      (context, index)  {
                                    if(search.text.isEmpty)
                                    {
                                      return InkWell(
                                        onTap: (){
                                          generic=val[index];
                                          Navigator.pop(context);
                                        },
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height:  MediaQuery.of(context).size.height*0.02,
                                            ),
                                            Text(
                                                val[index].name
                                            ),
                                            const Divider()
                                          ],
                                        ),
                                      );
                                    }
                                    else if(val[index].name.toString().toLowerCase().contains(title.toLowerCase()))
                                    {
                                      return InkWell(
                                        onTap: (){
                                          generic=val[index];
                                          Navigator.pop(context);
                                        },
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height:  MediaQuery.of(context).size.height*0.02,
                                            ),
                                            Text(val[index].name),
                                            const Divider()
                                          ],
                                        ),
                                      );
                                    }
                                    else
                                    {
                                      return Container(child:
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height:  MediaQuery.of(context).size.height*0.02,
                                          ),

                                          Text(
                                            'No Result Found',
                                            style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.normal,color: Colors.black),
                                          )
                                        ],
                                      ),);
                                    }
                                  }),)
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
    );
    return generic;
  //  search.clear();

    }