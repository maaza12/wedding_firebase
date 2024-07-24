import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptopfyp/admin_side_screens/dashboard_admin.dart';
import 'package:laptopfyp/authentication_screens/sign_in_page.dart';
import 'package:laptopfyp/company_side_screens/dashboard_company.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:laptopfyp/custom_bottom_navbar/bottom_navbar_for_admin.dart';
import 'package:laptopfyp/custom_bottom_navbar/bottom_navbar_for_company.dart';
import 'package:laptopfyp/custom_bottom_navbar/bottom_navbar_for_women.dart';
import 'package:laptopfyp/women_side_screens/dashboard_woman.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      final currentUser = FirebaseAuth.instance.currentUser;

      if (currentUser != null) {
        // Navigate to custom bottom navigation bar based on user's email domain
        final email = currentUser.email;
        if (email != null) {
          if (email.endsWith("admin.pk")) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardAdmin()),
            );
          } else if (email.endsWith("com.pk") || email.endsWith("gov.pk") || email.endsWith("edu.pk")) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CustomBottomNavBarForCompany()),
            );
          } else if (email.endsWith("gmail.com")) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CustomBottomNavBarForWomen()),
            );
          } else {
            // Default navigation if email domain doesn't match any specific cases
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CustomBottomNavBarForWomen()),
            );
          }
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignInPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xFF405230),
      body: Center(
          child: Text(
        "Wedding Planner Dulexe",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30, fontStyle: FontStyle.italic),
      )),
    );
  }
}
