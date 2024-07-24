import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laptopfyp/authentication_screens/sign_in_page.dart';
import 'package:laptopfyp/helper_classes/custom_toast.dart';

void showSignOutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Log out"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signOut().then((value) {
                  CustomToast.toastSuccessMessage("Sign Out Successfully");
                  Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (_) => SignInPage()), (route) => false);
                  //Get.offAll(const SignInPage());
                });
              } catch (e) {
                CustomToast.toastErrorMessage(e);
              }
            },
            child: const Text("Yes"),
          ),
        ],
      );
    },
  );
}
