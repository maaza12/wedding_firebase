import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:laptopfyp/company_side_screens/waiting_screen.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:laptopfyp/helper_classes/custom_elevated_button.dart';
import 'package:laptopfyp/helper_classes/custom_textformfield.dart';
import 'package:laptopfyp/helper_classes/custom_toast.dart';

class CompanyVerificationScreen extends StatefulWidget {
  const CompanyVerificationScreen({Key? key}) : super(key: key);

  @override
  _CompanyVerificationScreenState createState() => _CompanyVerificationScreenState();
}

class _CompanyVerificationScreenState extends State<CompanyVerificationScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController physicalAddressController = TextEditingController();
  final TextEditingController linkedInProfileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Employer Verification"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BackgroundTheme(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.02),
                  const Text(
                    'Employer Verification',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  const Text(
                    'Submit your details for verification',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  CustomTextFormField(
                    controller: companyNameController,
                    prefixIcon: const Icon(Icons.business),
                    hintText: "Employer Name",
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Employer name';
                      }
                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        return 'Please enter a valid name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  CustomTextFormField(
                    controller: emailController,
                    prefixIcon: const Icon(Icons.email),
                    hintText: "Email",
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  CustomTextFormField(
                    keyboardType: TextInputType.number,
                    controller: contactNumberController,
                    prefixIcon: const Icon(Icons.phone),
                    hintText: "Contact Number",
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your contact number';
                      }
                      if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return 'Contact number can only contain numbers';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  CustomTextFormField(
                    controller: physicalAddressController,
                    prefixIcon: const Icon(Icons.location_on),
                    hintText: "Physical Address",
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your physical address';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.02),
                  CustomTextFormField(
                    controller: linkedInProfileController,
                    prefixIcon: const Icon(Icons.link),
                    hintText: "LinkedIn Profile Link",
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your LinkedIn profile link';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: height * 0.1),
                  CustomElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submitForm();
                      } else {
                        CustomToast.toastErrorMessage("Please fill in all required fields.");
                      }
                    },
                    text: "Submit for Verification",
                  ),
                  SizedBox(height: height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    FirebaseFirestore.instance.collection('company_verification_requests').add({
      'company_name': companyNameController.text.trim(),
      'email': emailController.text.trim(),
      'company_status': "",
      'company_rejection_reason': "",
      'contact_number': contactNumberController.text.trim(),
      'physical_address': physicalAddressController.text.trim(),
      'linkedin_profile': linkedInProfileController.text.trim(),
      'user_id': FirebaseAuth.instance.currentUser!.uid
    }).then((value) {
      CustomToast.toastErrorMessage("Request submitted successfully");

      Get.to(
        WaitingScreen(),
      );

      _formKey.currentState!.reset();
    }).catchError((error) {
      CustomToast.toastErrorMessage("Failed to submit request: $error");
    });
  }
}
