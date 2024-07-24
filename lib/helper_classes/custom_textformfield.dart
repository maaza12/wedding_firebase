import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String? Function(String?)? validation;
  final TextEditingController controller;
  final String? hintText;
  final Icon prefixIcon;
  TextInputType? keyboardType;

  CustomTextFormField(
      {super.key, required this.controller, this.keyboardType,  required this.prefixIcon, this.hintText, required this.validation});

  /* jahan class ko use krna h wahan arguments must leny k lye required ka keyword lgana h,
   agr required ka keyword na lgayen to prefixIcon/hintText sy phly ? lga dena h mtlab usko
   nullable bna dena h.*/

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validation,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,

        hintText: hintText,
        /*hintStyle: TextStyle(
          fontWeight: FontWeight.w500,
        ),*/
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        errorStyle: const TextStyle(color: Colors.black), // Error text color
      ),
      keyboardType: keyboardType,

    );
  }
}
