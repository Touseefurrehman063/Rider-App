import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riderapp/Screen/Profile/_editprofile.dart';
import 'package:flutter_riderapp/Widgets/Custombutton.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Profile extends StatefulWidget {
  String empId;
  String userName;
  Profile({required this.empId, required this.userName, super.key});

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
    const Icon(Icons.notifications, size: 30, color: Colors.white),
    const Icon(
      Icons.home,
      size: 30,
      color: Colors.white,
    ),
    const Icon(Icons.person, size: 30, color: Colors.white),
  ];

  // ignore: unused_field
  XFile? _imageFile;
//  final ImagePicker _picker = ImagePicker();
  PickedFile? pickedFile;
  int index = 1;
  ZoomDrawerController zoomController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        // leading: Row(
        //   children: [
        //     InkWell(
        //       onTap: Get.back,
        //       child: Padding(
        //         padding: const EdgeInsets.only(left: 10.0),
        //         child: Image.asset(
        //           "assets/back.png",
        //           height: Get.height * 0.1,
        //           width: Get.width * 0.08,

        //           // color: Colors.white,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        title: Text(
          'Profile',
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
      // drawer:  DrawerContent(zoomController: zoomController,),
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                  child: Row(
                    children: [
                     SizedBox(
  width: MediaQuery.of(context).size.width * 0.25,
  child: Stack(
    alignment: Alignment.center,
    children: [
      Image.asset("assets/pp.jpg"),
      if (userprofile?.imagePath != null)
     Container(
    height: 150,
    width: 150,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      
    ),
    child: CachedNetworkImage(
      imageUrl: userprofile?.imagePath ?? '', 
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => Image.asset(
        "assets/pp.jpg",
        fit: BoxFit.contain,
      ),
    ),
  ),
    ]
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
                                text:
                                    'Hi, ${(userprofile?.fullName ?? "Tabib Rider").length > 10 ? '${(userprofile?.fullName ?? "Tabib Rider").substring(0, 10)}...' : (userprofile?.fullName ?? "Tabib Rider")}',
                                style: GoogleFonts.raleway(
                                  fontSize: 23,
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
                                  fontSize: 15,
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
              SingleChildScrollView(
                child: Container(
                  alignment: Alignment.topCenter,
                  width: Get.width,
                  height: Get.height * 0.51,
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.05),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30)),
                      color: Color(0xFF1272D3)),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        RecordWidget(
                          title: "Vehicle Number",
                          name: userprofile?.vehicleNumber ?? "_",
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        RecordWidget(
                          title: "Government ID",
                          name: userprofile?.cNICNumber ?? "_",
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        RecordWidget(
                          title: "Contact No",
                          name: userprofile?.cellNumber ?? "_",
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        RecordWidget(
                          title: "Date of Birth",
                          name:
                                            userprofile?.dateofBirth != null
                                                ? DateFormat('dd MMMM yyyy')
                                                    .format(DateTime.parse(
                                                        userprofile!
                                                            .dateofBirth!))
                                                : '_',
                                           
                                          
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        RecordWidget(
                          title: "Address",
                          name: userprofile?.userAddress ?? "_",
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          width: Get.width*0.7,
                          onPressed: () async {
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EditProfile()));
                            setState(() {
                              userprofile;
                            });
                          },
                          title: "Edit Profile",
                          radius: 20,
                          style: GoogleFonts.poppins(
                              color: Colors.blue,
                              fontSize: 16,
                              
                              fontWeight: FontWeight.bold),
                          primcolor: Colors.white,
                        ),
                      ],
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

class RecordWidget extends StatelessWidget {
  final String? title;
  final String? name;

  const RecordWidget({Key? key, this.title, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '$title',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      ':',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    '$name',
                    maxLines: 2,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
