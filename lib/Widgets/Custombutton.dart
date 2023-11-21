import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
final Function()? onPressed;
final String title;
final double? width;
final double? height;
final TextStyle? style;
final Color? primcolor;
final double radius;


  const CustomButton({required this.onPressed,required this.title,this.width,this.height, this.style, this.primcolor,this.radius=20, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
           onPressed: onPressed,
          style: ElevatedButton.styleFrom(
                 foregroundColor: Colors.white, backgroundColor: primcolor, padding:  EdgeInsets.symmetric(vertical: Get.height*0.020, horizontal: Get.width*0.12), 
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(8), 
                   side: const BorderSide(color: Colors.white),
                   
                   
                    )
                   
                   ),
                   
           child: Text(title,style: style,),
          
           
          
           
           
           );
  }
}