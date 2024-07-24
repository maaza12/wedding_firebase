import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptopfyp/admin_side_screens/dashboard_admin.dart';
import 'package:laptopfyp/authentication_screens/forget_password.dart';
import 'package:laptopfyp/authentication_screens/sign_up_screen.dart';
import 'package:laptopfyp/company_side_screens/dashboard_company.dart';
import 'package:laptopfyp/company_side_screens/waiting_screen.dart';
import 'package:laptopfyp/custom_bottom_navbar/bottom_navbar_for_company.dart';
import 'package:laptopfyp/custom_bottom_navbar/bottom_navbar_for_women.dart';
import 'package:laptopfyp/helper_classes/custom_toast.dart';
import 'package:laptopfyp/women_side_screens/dashboard_woman.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    super.key,
  });

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isObscure = true;

  final _formKey = GlobalKey<FormState>();

  TextEditingController emailcontroller = TextEditingController();

  TextEditingController passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white
            // color: Color(0xFFD7FFC7),
            ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                const Text(
                  'Sign In',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Sign In To Your Account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 100),
                TextFormField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    prefixIconColor: Colors.black,
                    labelText: "Email",
                    hintText: "Enter your email",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    errorStyle: const TextStyle(color: Colors.black),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }

                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }

                    /*if (RegExp(r'^[0-9!@#\$%\^&*(),.?":{}|<>]').hasMatch(value[0])) {
                      return 'Username cannot start with a number or special character';
                    }*/
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  controller: passwordcontroller,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      child: Icon(
                        color: Colors.black,
                        _isObscure ? Icons.visibility_off : Icons.visibility,
                      ),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    prefixIconColor: Colors.black,
                    labelText: "Password",
                    hintText: "Enter your password",
                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                    errorStyle: const TextStyle(color: Colors.black),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ForgetPassword()),
                          );
                        },
                        child: const Text(
                          "Forget Password?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
                const SizedBox(height: 50),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xFF405230))),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: emailcontroller.text.trim(),
                                    // spaces ignorer -> trim()
                                    password: passwordcontroller.text.trim())
                                .then((value) async {
                              final emailEduPk = emailcontroller.text.trim().endsWith("edu.pk");
                              final emailComPk = emailcontroller.text.trim().endsWith("com.pk");
                              final emailGovPk = emailcontroller.text.trim().endsWith("gov.pk");

                              final emailWomen = emailcontroller.text.trim().endsWith("gmail.com");
                              if (emailComPk == true || emailGovPk == true || emailEduPk == true) {
                                print("Enter");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CustomBottomNavBarForCompany(),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const CustomBottomNavBarForWomen(),
                                  ),
                                );
                              }
                              CustomToast.toastErrorMessage("Successfully Sign In !");
                            });
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              CustomToast.toastErrorMessage("No user found for that email.");
                            }
                            if (e.code == 'wrong-password') {
                              CustomToast.toastErrorMessage("Wrong password provided for that user.");
                            }
                            if (e.code == 'invalid-credential') {
                              CustomToast.toastErrorMessage("Wrong credential provided.");
                            }
                          }
                        }
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )),
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account? ",
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpPage()),
                        );
                      },
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
