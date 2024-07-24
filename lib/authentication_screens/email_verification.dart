import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laptopfyp/authentication_screens/company_verification_screen.dart';
import 'package:laptopfyp/authentication_screens/sign_in_page.dart';
import 'package:laptopfyp/helper_classes/custom_toast.dart';
import 'package:laptopfyp/women_side_screens/dashboard_woman.dart';

class VerifyEmail extends StatefulWidget {

    var emailController;



  VerifyEmail({super.key, required this.emailController});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
      CustomToast.toastSuccessMessage("Verification email sent successfully");
      /*AppToast.appToast(
          "Congratulations!", "Verification email sent successfully.");*/
    });
  }

  Future<void> delayedResendVerification() async {
    await Future.delayed(const Duration(seconds: 3));
    await _handleResendVerification();
  }

  Future<void> _handleResendVerification() async {
    try {
      await FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
        CustomToast.toastSuccessMessage("Verification email sent again.");
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text('Verification email sent again.'),
        //   ),
        // );
      });
    } catch (e) {
      CustomToast.toastSuccessMessage("Wait and then try it");
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text("Email Verification"),
          automaticallyImplyLeading: false,
          centerTitle: true,


        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.01,
              ),
              const Text(
                "Email Verify",
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.01,
              ),
              const Text(
                "Please verify your email address we have just sent you a verification link to proceed further with our app.",
              ),


              const Spacer(),
              InkWell(
                onTap: () async {
                  // try {
                  //   await FirebaseAuth.instance.currentUser!.reload();
                  //
                  //   if (FirebaseAuth.instance.currentUser!.emailVerified) {
                  //     Navigator.of(context).pushReplacement(
                  //       MaterialPageRoute(
                  //         builder: (context) => CustomBottomNavBar(),
                  //       ),
                  //     );
                  //   }
                  // } catch (error) {
                  //   debugPrint("Error is : $error");
                  // }
                 // Get.offAll(() => const DashboardWoman());

                  final emailEduPk = widget.emailController.endsWith("edu.pk");
                  final emailComPk = widget.emailController.endsWith("com.pk");
                  final emailGovPk = widget.emailController.endsWith("gov.pk");
                  if (emailComPk == true || emailGovPk == true || emailEduPk == true) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CompanyVerificationScreen(),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInPage(),
                      ),
                    );
                  }


                },
                child: Container(
                  decoration: BoxDecoration(color: const Color(0xFF405230), borderRadius: BorderRadius.circular(30)),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: h * 0.02),
                      child: const Text(
                        "Verify",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          fontFamily: "Sora",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn’t received code? ",
                  ),
                  InkWell(
                    onTap: delayedResendVerification,
                    child: const Text(
                      "Resend",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        fontFamily: "Sora",
                        color: Color(0xFF405230),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
