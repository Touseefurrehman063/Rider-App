import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class customFormField extends StatelessWidget {
  final String hinttext;
   String? val;
  final TextEditingController controller;
  
   customFormField({super.key,required this.hinttext, this.val,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
     
      
    
      child: TextFormField(
        controller: controller,
        inputFormatters: [
         FilteringTextInputFormatter.deny(
                     RegExp(r'\s')),
        ],
        validator: (value) {  if (value == null || value.isEmpty) {
            return 'Please enter a valid data';
          }
          return null;

          
        },
           autofocus: false,
   
    decoration: InputDecoration(
      hintStyle: const TextStyle(
        fontSize: 18,
        color:Colors.black
      ),
      hintText: hinttext,
      // contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 12.0), 
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 0.3,
        ),
      ),
      filled: true,
      fillColor: Colors.transparent,
    ),
    
    
    keyboardType: TextInputType.text,
    style: const TextStyle(
      
      fontSize: 18,
      color: Colors.black,
    ),
    // validator: (value) {
    //   if (value == null || value.isEmpty) {
    //     return 'Please enter a valid name';
    //   }
    //   return null;
    // },
    
  ),

    );
  }
}