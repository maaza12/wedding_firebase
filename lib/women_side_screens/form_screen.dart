import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:laptopfyp/custom_bottom_navbar/bottom_navbar_for_women.dart';
import 'package:laptopfyp/helper_classes/custom_elevated_button.dart';
import 'package:laptopfyp/helper_classes/custom_textformfield.dart';
import 'package:laptopfyp/helper_classes/custom_toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:laptopfyp/testFile.dart';
import 'package:laptopfyp/women_side_screens/dashboard_woman.dart';

class FormScreen extends StatefulWidget {
  String postCreatorId = "";

  FormScreen({super.key, required this.postCreatorId});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String? selection1;
  String? selection2;
  final _formKey = GlobalKey<FormState>();
  Future<Map<String, dynamic>?>? userDataFuture;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController workExpController = TextEditingController();
  TextEditingController degreeController = TextEditingController();

  File? _file;

  @override
  void initState() {
    super.initState();
    userDataFuture = fetchUserData(); // Fetch data once on state initialization
    userDataFuture!.then((data) {
      if (data != null) {}
    });
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _file = File(result.files.single.path!);
      });
    } else {
      // User canceled the picker
    }
  }

  Future<Map<String, dynamic>?> fetchUserData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      return userDoc.data() as Map<String, dynamic>?;
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          "Hall Booking",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: userDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              final userData = snapshot.data;

              // Set the text only if the controller is empty to avoid overriding user input
              if (fullNameController.text.isEmpty && userData != null) {
                fullNameController.text = userData['username'] ?? ""; // Default to empty if null
                mobileNumberController.text = userData['mobile_num'] ?? "";
                emailController.text = userData['email'] ?? "";
                addressController.text = userData['address'] ?? "";
                ageController.text = userData['age'] ?? "";
                workExpController.text = userData['work_experience'] ?? "";
                degreeController.text = userData['degree'] ?? "";
              }

              return Container(
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(onPressed: () {
                          Get.to(WeatherForecastScreen());
                        }, child: Text("Weather")),
                        SizedBox(height: height * 0.02),
                        CustomTextFormField(
                          hintText: "",
                          controller: fullNameController,
                          prefixIcon: const Icon(Icons.person),
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }

                            if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                              return 'Please enter a valid full name';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        CustomTextFormField(
                          controller: mobileNumberController,
                          prefixIcon: const Icon(Icons.numbers),
                          hintText: "Mobile Num",
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your mobile number';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Please enter a valid mobile number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        CustomTextFormField(
                          controller: emailController,
                          prefixIcon: const Icon(Icons.email),
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
                          controller: addressController,
                          prefixIcon: const Icon(Icons.location_on),
                          hintText: "Address",
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        CustomTextFormField(
                          controller: ageController,
                          prefixIcon: const Icon(Icons.person),
                          hintText: "Age",
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your age';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Please enter a valid age';
                            }
                            int age = int.parse(value);
                            if (age < 18) {
                              return 'You must be at least 18 years old';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: height * 0.02),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: height * 0.01),
                              const Text(
                                '  Do you prefer: ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              RadioListTile(
                                title: const Text('Evening'),
                                value: 'evening',
                                groupValue: selection1,
                                onChanged: (value) {
                                  setState(() {
                                    selection1 = value as String?;
                                  });
                                  // Handle selection for Evening
                                  print('Selection: $value');
                                },
                              ),
                              RadioListTile(
                                title: const Text('Morning'),
                                value: 'morning',
                                groupValue: selection1,
                                onChanged: (value) {
                                  setState(() {
                                    selection1 = value as String?;
                                  });
                                  // Handle selection for Morning
                                  print('Selection: $value');
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                        Text("Note: if your request will be rejected, your payment will be refundable! "),
                        SizedBox(height: height * 0.02),
                        CustomElevatedButton(onPressed: _pickFile, text: 'Upload your payment slip'),
                        SizedBox(height: height * 0.02),
                        _fileInfo(),
                        CustomElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (selection1 == null) {
                                CustomToast.toastErrorMessage(
                                    "Please select your preferences for time (morning or evening) and work location (on-site or remote).");
                                return; // Prevent form submission if selections are missing
                              }
                              _showConfirmDialog(); // Proceed to show confirmation dialog
                            } else {
                              CustomToast.toastErrorMessage("Please fill in all required fields.");
                            }
                          },
                          text: "Book",
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _fileInfo() {
    if (_file != null) {
      String fileName = _file!.path.split('/').last; // Get file name from path
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              fileName,
              style: const TextStyle(fontSize: 16, overflow: TextOverflow.ellipsis),
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              setState(() {
                _file = null; // Remove the file
              });
            },
          )
        ],
      );
    }
    return Container(); // Return an empty container if no file is selected
  }

  void _submitForm() async {
    if (_file == null) {
      CustomToast.toastErrorMessage("Please upload a CV to apply.");
      return;
    }

    // Upload file to Firebase Storage
    String fileName = 'CVs/${FirebaseAuth.instance.currentUser!.uid}/${_file!.path.split('/').last}';
    UploadTask task = FirebaseStorage.instance.ref(fileName).putFile(_file!);

    try {
      // Wait for the file upload to complete
      TaskSnapshot snapshot = await task;
      // Get the download URL
      String downloadURL = await snapshot.ref.getDownloadURL();

      // Now add document to Firestore
      FirebaseFirestore.instance.collection('woman_form').add({
        'Full_name': fullNameController.text.trim(),
        'mobile_number': mobileNumberController.text.trim(),
        'email': emailController.text.trim(),
        'address': addressController.text.trim(),
        'age': ageController.text.trim(),

        'cv_url': downloadURL, // Store the download URL in Firestore
        'form_status': "",
        'postCreatorID': widget.postCreatorId,
        "formApplierId": FirebaseAuth.instance.currentUser!.uid,
        'form_rejection_reason': "",
      }).then((value) {
        CustomToast.toastErrorMessage("Form submitted successfully");
        Get.to(const CustomBottomNavBarForWomen());
        _formKey.currentState!.reset();
        _file = null; // Reset the file
      }).catchError((error) {
        CustomToast.toastErrorMessage("Failed to submit form: $error");
      });
    } catch (e) {
      print(e); // If there's an error, print it
      CustomToast.toastErrorMessage("Failed to upload CV: $e");
    }
  }

  void _showConfirmDialog() {
    // Ensure that all selections are made and a file is chosen
    // if (selection1 == null || selection2 == null) {
    //   CustomToast.toastErrorMessage("Please select your preferences for time and work location.");
    //   return; // Stop the dialog from opening
    // }

    if (_file == null) {
      CustomToast.toastErrorMessage("Please upload a CV to apply.");
      return; // Stop the dialog from opening
    }

    // Dialog content assuming all checks are passed
    String dialogContent = "Are you sure you want to apply with these details? Please verify your information.";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirm Application"),
          content: Text(dialogContent),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text("Confirm"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _submitForm(); // Proceed with submitting the form
              },
            ),
          ],
        );
      },
    );
  }
}
