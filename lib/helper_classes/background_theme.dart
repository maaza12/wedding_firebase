import 'package:flutter/material.dart';

class BackgroundTheme extends StatelessWidget {
  Widget child;

  BackgroundTheme({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            color: Colors.white
        ),
        child: child);
  }
}
