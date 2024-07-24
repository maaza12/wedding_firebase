import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptopfyp/authentication_screens/company_verification_screen.dart';
import 'package:laptopfyp/authentication_screens/email_verification.dart';
import 'package:laptopfyp/authentication_screens/sign_in_page.dart';
import 'package:laptopfyp/helper_classes/custom_toast.dart';
import 'package:responsive_config/responsive_config.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController idCardController = TextEditingController();

  String dropdownValue = 'User';

  // Default value
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.white),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: getProportionateScreenHeight(100)),
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Create Your Account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 40),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black),
                    color: Color(0xFF405230),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(20),
                      underline: Container(),
                      value: dropdownValue,
                      isExpanded: true,
                      elevation: 36,
                      style: const TextStyle(color: Colors.white),
                      dropdownColor: Color(0xFF405230),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['User', 'Wedding Planner'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SpaceBox(),
                TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: Colors.black,
                      hintText: "Enter your username",
                      labelText: "Username",
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      errorStyle: const TextStyle(color: Colors.black), // Error text color
                    ),
                    // validation code here
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      if (RegExp(r'^[\s0-9!@#\$%\^&*(),.?":{}|<>]').hasMatch(value[0])) {
                        return 'Username cannot start with a number or special character';
                      }
                      return null;
                    }),
                const SpaceBox(),
                TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      prefixIconColor: Colors.black,
                      labelText: "Email",
                      hintText: "Enter your email",
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
                        return 'Please enter your email';
                      }

                      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }

                      /*  if (RegExp(r'^[0-9!@#\$%\^&*(),.?":{}|<>]').hasMatch(value[0])) {
                        return 'Email cannot start with a number or special character';
                      }*/

                      if (dropdownValue == 'Wedding Planner') {
                        final officialEmailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+(edu\.pk|com\.pk|gov\.pk)$');
                        if (!officialEmailRegex.hasMatch(value)) {
                          return 'For employers, use an official email like edu.pk, com.pk, or gov.pk';
                        }
                      } else if (dropdownValue == 'User') {
                        final jobSeekerEmailRegex = RegExp(r'^[\w-\.]+@gmail\.com$');
                        if (!jobSeekerEmailRegex.hasMatch(value)) {
                          return 'Job seekers must use a gmail.com email address';
                        }
                      }

                      return null;
                    }),
                const SpaceBox(),
                TextFormField(
                  controller: passwordController,
                  decoration: InputDecoration(
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
                const SpaceBox(),
                TextFormField(
                  controller: confirmPasswordController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    prefixIconColor: Colors.black,
                    labelText: "Confirm Password",
                    hintText: "Enter your confirm password",
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
                      return 'Please re_enter your password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }

                    if (passwordController.text != confirmPasswordController.text) {
                      return "Password and Confirm Password does not match";
                    }

                    return null;
                  },
                ),
                const SpaceBox(),
                if (dropdownValue == "User") ...[
                  TextFormField(
                    keyboardType: TextInputType.number,
                    maxLength: 13,
                    controller: idCardController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.numbers),
                      prefixIconColor: Colors.black,
                      labelText: "ID Card",
                      hintText: "Enter your ID Card Number",
                      labelStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                      errorStyle: const TextStyle(color: Colors.black),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter your ID card number';
                      if (!RegExp(r'^\d{13}$').hasMatch(value)) return 'ID must be exactly 13 digits';
                      if (int.parse(value[value.length - 1]) % 2 != 0) return 'Last digit must be even';
                      return null;
                    },
                  ),
                ],
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
                                .createUserWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            )
                                .then((value) {
                              final emailEduPk = emailController.text.trim().endsWith("edu.pk");
                              final emailComPk = emailController.text.trim().endsWith("com.pk");
                              final emailGovPk = emailController.text.trim().endsWith("gov.pk");
                              if (emailComPk == true || emailGovPk == true || emailEduPk == true) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignInPage(),
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

                              /*Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>  VerifyEmail(emailController: emailController.text.trim(),),
                                ),
                              );*/
                            }).then((value) {
                              FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set({
                                'user_type': dropdownValue,
                                'email': emailController.text.trim(),
                                'username': usernameController.text.trim(),
                                "userID": FirebaseAuth.instance.currentUser!.uid,
                                "mobile_num": "",
                                "work_experience": "",
                                "degree": "",
                                "profile_picture": "",
                                "address": "",
                                "age": "",
                              }).then((value) {
                                CustomToast.toastErrorMessage("User Created successfully!");
                              });

                              _formKey.currentState!.reset();
                            }).catchError((error) {
                              CustomToast.toastErrorMessage("Failed to submit request: $error");
                            });
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              CustomToast.toastErrorMessage("The password provided is too weak.");
                            } else if (e.code == 'email-already-in-use') {
                              CustomToast.toastErrorMessage("The account already exists for that email.");
                            }
                          }
                        }
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      )),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignInPage()),
                        );
                      },
                      child: const Text(
                        " Sign In",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SpaceBox extends StatelessWidget {
  const SpaceBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(height: 10);
  }
}
