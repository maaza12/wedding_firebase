import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:laptopfyp/authentication_screens/company_verification_screen.dart';
import 'package:laptopfyp/authentication_screens/email_verification.dart';
import 'package:laptopfyp/authentication_screens/splash_screen.dart';
import 'package:responsive_config/responsive_config.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveConfig().init(context);

    return const GetMaterialApp(
        debugShowCheckedModeBanner: false,

        // home:Dashboard());
        home: SplashScreen());
    //home: VerifyEmail());
  }
}
