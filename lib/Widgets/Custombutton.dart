import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
final Function()? onPressed;
final String title;
final double? width;
final TextStyle? style;
final Color? primcolor;
final double radius;


  const CustomButton({required this.onPressed,required this.title,this.width,this.style, this.primcolor,this.radius=20, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(

width: width ,     
 child: ElevatedButton(
        onPressed: onPressed,
       style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: primcolor, padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30), // Text color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // Rounded corners
                side: const BorderSide(color: Colors.white), )
                ),
        child: Text(title,style: style,),
       
        
       
        
        
        ),
    );
  }
}