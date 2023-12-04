import 'package:flutter/material.dart';
import 'package:flutter_riderapp/View/_editprofile.dart';
import 'package:flutter_riderapp/Widgets/Custombutton.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:flutter_riderapp/View/_dashboard.dart';
import 'package:intl/intl.dart';



// ignore: must_be_immutable
class Profile extends StatefulWidget {

  String empId;
  String userName;
   Profile({required this.empId,required this.userName,super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
// User user= User();

// instance() async
// {
//   user= await api.getprofile();
// }


  // @override
  // void initState() {
  //   instance();
  //   // TODO: implement initState
  //   super.initState();
  // }
   String _getGreetingMessage() {
    var now = DateTime.now();
    var hour = now.hour;

    if (hour < 10) {
      return 'Good Morning';
    } else if (hour < 18) {
      return 'Good Afternoon';
    } else if (hour < 22) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  final items = [
    const Icon(Icons.notifications, size: 30,color: Colors.white),
    const Icon(Icons.home, size: 30,color: Colors.white,),
    const Icon(Icons.person, size: 30,color: Colors.white),
  ];

    // ignore: unused_field
    XFile? _imageFile;
//  final ImagePicker _picker = ImagePicker();
  PickedFile? pickedFile;
   int index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0.0,
        
        title: Center(
          child: SizedBox(
            width: 150,
                                height: MediaQuery.of(context).size.height*0.05,
            
            child: Text("Profile",style: GoogleFonts.poppins(color: Colors.blue,fontWeight: FontWeight.bold,fontSize: 30),)),
        ),
    leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios_new,color: Color(0xff0F64C6),)),
  ),

      
    drawer: const DrawerContent(),
  body:Container(
    child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 15),
             child: Row(
               children: [
                SizedBox(
  width: MediaQuery.of(context).size.width*0.25,
  child: Stack(
    alignment: Alignment.center,
    children: [
      
      
      Image.asset("assets/pp.jpg"),
      Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.orange,
                          width: 2,
                        ),
                        image: DecorationImage(
                          image: NetworkImage(
                           " ${userprofile?.imagePath}"
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
      // Positioned(
      //     bottom: 5.0,
      //     right: 5.0,
      //     child: InkWell(
      //       onTap: () {
      //         showModalBottomSheet(
      //             context: context, builder: (builder) => bottomsheet());
      //       },
      //       child: const Icon(
      //         Icons.camera_alt,
      //         color: Colors.blue,
      //         size: 28.0,
      //       ),
      //     ),
      //   )
    ],
  ),
),

           
                              Container(
                                child: RichText(
                                  text: TextSpan(
                                    style: GoogleFonts.readexPro(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      height: 1.25,
                                      color: const Color(0xff1272d3),
                                    ),
                                    children: [
                                      TextSpan(
                                       text: 'Hi, ${(userprofile?.fullName ?? "Tabib Rider").length > 10 ? '${(userprofile?.fullName ?? "Tabib Rider").substring(0, 10)}...' : (userprofile?.fullName ?? "Tabib Rider")}',

                                        style: GoogleFonts.raleway(
                                          fontSize: 23 ,
                                          fontWeight: FontWeight.w800,
                                          height: 1.175,
                                          color: const Color(0xff1272d3),
                                        ),
                                      ),
                                      TextSpan(
                                        text: '\n',
                                        style: GoogleFonts.readexPro(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: const Color(0xff1272d3),
                                        ),
                                      ),
                                      TextSpan(
                                        text: _getGreetingMessage(),
                                        style: GoogleFonts.raleway(
                                          fontSize:15,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 4.5,
                                          color: const Color(0xff1272d3),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
           
           
               ],
             ),
           ),
                            


        ),
      Expanded(
  child: Container(
    
   
    decoration: BoxDecoration( 
      color: Colors.blue,
      borderRadius: BorderRadius.circular(20), 
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 5,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: SingleChildScrollView(
      child: Container(
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.09,),
            SizedBox(

              child: Row(
                
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Vehicle Number",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              
                            ),
                             Text(
                                          ":",
                                          style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                                          ),
                                        ),
                          ],
                        ),
                      ),
                      
                  const SizedBox(height: 30,), 
                 SizedBox(
                        width: MediaQuery.of(context).size.width*0.55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Government ID",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              
                            ),
                             Text(
                                          ":",
                                          style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                                          ),
                                        ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30,), 
                 SizedBox(
                        width: MediaQuery.of(context).size.width*0.55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Contact No",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              
                            ),
                             Text(
                                          ":",
                                          style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                                          ),
                                        ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30,), 
                 SizedBox(
                        width: MediaQuery.of(context).size.width*0.55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Date of Birth",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              
                            ),
                             Text(
                                          ":",
                                          style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                                          ),
                                        ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30,), 
                 SizedBox(
                        width: MediaQuery.of(context).size.width*0.55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Address",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              
                            ),
                             Text(
                                          ":",
                                          style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                                          ),
                                        ),
                          ],
                        ),
                      ),
                      
                
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              userprofile?.vehicleNumber??"_",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              
                            ),
                            
                          ],
                        ),
                      ),
                      
                  const SizedBox(height: 30,), 
                 SizedBox(
                        width: MediaQuery.of(context).size.width*0.45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                               userprofile?.cNICNumber??"_",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              
                            ),
                             
                          ],
                        ),
                      ),

                      const SizedBox(height: 30,), 
                 SizedBox(
                        width: MediaQuery.of(context).size.width*0.45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                            
                               userprofile?.cellNumber??"_",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              
                            ),
                             
                          ],
                        ),
                      ),
                      const SizedBox(height: 30,), 
                 SizedBox(
                        width: MediaQuery.of(context).size.width*0.45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                            userprofile?.dateofBirth != null
            ? DateFormat('dd MMMM yyyy').format(DateTime.parse(userprofile!.dateofBirth!))
            : '_', 
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              
                              
                            ),
                           
                          ],
                        ),
                      ),
                      const SizedBox(height: 30,), 
                 SizedBox(
                        width: MediaQuery.of(context).size.width*0.45,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              userprofile?.userAddress??"_",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              
                            ),
                             
                          ],
                        ),
                      ),
                     
                    ],
                  ),
                 
                   const SizedBox(height: 30,), 
                  
                 
                  
                ],
                
              ),
            ),
            const SizedBox(height: 20,), 
             CustomButton(onPressed: ()async{
                                   await Navigator.push(context, MaterialPageRoute(builder: (context)=> const EditProfile()));
                                    setState(() {
                                      userprofile;
                                    });
                                  }, title: "Edit Profile",
                                  radius: 20,
                                  style: GoogleFonts.poppins(color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold),
                                  primcolor: Colors.white,
                                  
                                  ),
          ],
        ),
       
        
      ),
    ),

    
  
    
  ),
),


  
      
    ]),
    

   
  ),

    );
  }

//   Widget bottomsheet() {
//     return Container(
//       height: 100.0,
//       width: MediaQuery.of(context).size.width,
//       margin: const EdgeInsets.symmetric(
//         horizontal: 10,
//         vertical: 20,
//       ),
//       child: Column(
//         children: <Widget>[
//           Text(
//             "Choose Profile Photo",
//            style: GoogleFonts.raleway(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blue),
//           ),
//           const SizedBox(height: 20,),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               TextButton.icon(
//                 icon: const Icon(Icons.camera),
//                 onPressed: () {
//                   TakePhoto(ImageSource.camera);
//                 },
//                 label: Text("camera",
//                 style: GoogleFonts.raleway(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),
//                 ),
//               ),
//               TextButton.icon(
//                 icon: const Icon(Icons.image),
//                 onPressed: () {
//                   TakePhoto(ImageSource.gallery);
//                 },
//                 label: Text("Gallery",
                
//                 style: GoogleFonts.raleway(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.blue),
//                 ),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
//   void TakePhoto(ImageSource source) async {
//   final XFile? pickedFile = await _picker.pickImage(source: source);
//   if (pickedFile != null) {
//     setState(() {
//       _imageFile = pickedFile;
//     });
//   } else {
//     // Handle the case when the user cancels the image selection
//     // or if there was an error while picking the image.
//   }
// }
}
