import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptopfyp/helper_classes/custom_toast.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          color: Colors.white
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              const Text(
                'Forget Password',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Reset Your Password',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  prefixIconColor: Colors.black,
                  labelText: "Email",
                  hintText: "Enter your email",
                  labelStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  errorStyle: TextStyle(color: Colors.redAccent),
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: const Color(0xFF405230) // Text color
                  ),
                  onPressed: () async {
                    final email = emailController.text.trim();
                    if (email.isEmpty || !email.contains('@')) {
                      CustomToast.toastErrorMessage("Please enter a valid email address.");
                      return;
                    }
                    try {
                      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                      CustomToast.toastErrorMessage("Email verification link sent!");
                    } on FirebaseAuthException catch (e) {
                      CustomToast.toastErrorMessage("Error: ${e.message}");
                    }
                  },
                  child: const Text("Reset Password"),
                ),
              ),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }
}