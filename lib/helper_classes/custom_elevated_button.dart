import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  VoidCallback onPressed;
  String text;
  double? buttonWidth;
  CustomElevatedButton(
      {super.key, this.buttonWidth, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 50,
      width:  buttonWidth ?? double.maxFinite,
      child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Color(0xFF405230))),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white
            ),
          )),
    );
  }
}

