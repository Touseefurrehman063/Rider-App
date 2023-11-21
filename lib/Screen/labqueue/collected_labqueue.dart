import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Collectedlabqueue extends StatefulWidget {
  const Collectedlabqueue({super.key});

  @override
  State<Collectedlabqueue> createState() => _CollectedlabqueueState();
}

class _CollectedlabqueueState extends State<Collectedlabqueue> {
    bool isLoadingData = false;
     bool isLoadingmoreData = false;
       final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return  BlurryModalProgressHUD(
      inAsyncCall: isLoadingData,
        blurEffectIntensity: 4,
        progressIndicator: const SpinKitSpinningLines(
          color: Color(0xFF1272d3),
          size: 60,
          
        ),
         dismissible: false,
        opacity: 0.4,
        color: Theme.of(context).scaffoldBackgroundColor,
         child: Scaffold(
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
              'labqeue'.tr,
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
          body: Container(
            // decoration: const BoxDecoration(
            //   image: DecorationImage(
            //       image: AssetImage('assets/helpbackgraound.png'),
            //       alignment: Alignment.centerLeft),
            // ),
            child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width * 1,
                child: Column(
              
                  children: [
                     Expanded(
                          child: ListView.builder(
                            controller: _scrollController,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              
                             
                                        
                                
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, right: 15, left: 15),
                                    child: Card(
                                      color: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15),
                                            side: const BorderSide(color: Colors.grey,width: 0.3)
                                      ),
                                        
                                      child: ListTile(
                                          title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            title: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Test",
                                                  style: TextStyle(
                                                      fontSize: 8,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                "Spiceman",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 20,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                               
                                                
                                               
                                                
                                              ],
                                            ),
                                            
                                          ),
                                         
                                        ],
                                      )),
                                      // child: ListTile(
                                        
                                      //   title: Text(user.patientName ?? "",style: GoogleFonts.poppins(fontSize: 20,color: Colors.white,),),
                                      //   subtitle: Text('Test  | ${user.test ?? ""}' ,style: GoogleFonts.poppins(fontSize: 12,color: Colors.white,)),
                                        
                                      // ),
                                    ),
                                  );
                                },
                              
                              
                           
                        
                ))],
                
            )),
          ),
         ),


    );
  }
}