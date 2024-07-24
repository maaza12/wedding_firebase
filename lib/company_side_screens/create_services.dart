import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:laptopfyp/company_side_screens/dashboard_company.dart';
import 'package:laptopfyp/custom_bottom_navbar/bottom_navbar_for_company.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:laptopfyp/helper_classes/custom_elevated_button.dart';
import 'package:laptopfyp/helper_classes/custom_toast.dart';

class CreateServices extends StatefulWidget {
  CreateServices({super.key});

  @override
  State<CreateServices> createState() => _CreateServicesState();
}

class _CreateServicesState extends State<CreateServices> {
  @override
  TextEditingController serviceNameController = TextEditingController();

  TextEditingController SeriveDescriptionController = TextEditingController();

  TextEditingController chooseDateController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController jobSalaryController = TextEditingController();

  String? selectedJobTime;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();

  bool trainingRequired = false;
  List<File> _imageFiles = [];
  List allBookingURLS = [];

  Future<void> pickImagesAndUpload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        setState(() {
          _imageFiles.addAll(files);
        });

        // Upload images to Firebase Storage and save URLs to Firestore
        await uploadImagesAndSaveURLs(files);
      }
    } catch (e) {
      print("Error picking images: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking images: $e')),
      );
    }
  }

  Future<void> uploadImagesAndSaveURLs(List<File> files) async {
    try {
      List<String> downloadURLs = [];

      for (int i = 0; i < files.length; i++) {
        File file = files[i];
        String fileName = DateTime.now().millisecondsSinceEpoch.toString() + '_$i';
        var ref = FirebaseStorage.instance.ref().child('images/$fileName');

        await ref.putFile(file);
        String imageURL = await ref.getDownloadURL();
        downloadURLs.add(imageURL);
      }

      // Save download URLs to Firestore
      await saveURLsToFirestore(downloadURLs);
    } catch (e) {
      print("Error uploading images: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading images: $e')),
      );
    }
  }

  Future<void> saveURLsToFirestore(List<String> urls) async {
    try {
      for (int i = 0; i < urls.length; i++) {
        allBookingURLS.add(urls[i]);
      }
    } catch (e) {
      print("Error saving URLs to Firestore: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving URLs to Firestore: $e')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != DateTime.now()) {
      setState(() {
        _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 15,
        title: const Text(
          "Create a Services",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: InkWell(
        //         onTap: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => const ProfileScreen()),
        //           );
        //         },
        //         child: const CircleAvatar(
        //           backgroundImage: AssetImage("assets/images/logo.png"),
        //         )),
        //   )
        // ],

        //actions: [IconButton(onPressed: () => showSignOutConfirmationDialog(context), icon: const Icon(Icons.logout))],
      ),
      body: BackgroundTheme(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: pickImagesAndUpload,
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(width: 1, color: Colors.black)),
                        child: _imageFiles.isEmpty
                            ? const Center(child: Text("Pick multiple images"))
                            : Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GridView.count(
                                  crossAxisCount: 3,
                                  children: List.generate(_imageFiles.length, (index) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(20),

                                      child: Image.file(
                                        _imageFiles[index],
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  }),
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    TextFormField(
                      controller: serviceNameController,
                      maxLines: null, // Allows the text field to expand
                      decoration: InputDecoration(
                        labelText: "Name",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: SeriveDescriptionController,
                      maxLines: null, // Allows the text field to expand
                      decoration: InputDecoration(
                        labelText: "Description",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your  description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: phoneNumberController,
                      maxLines: null, // Allows the text field to expand
                      decoration: InputDecoration(
                        labelText: "Phone number",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your  Phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _dateController,
                      maxLines: null,
                      // Allows the text field to expand
                      decoration: InputDecoration(
                        labelText: "Choose Date",
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onTap: () {
                        print("Enter");
                        FocusScope.of(context).requestFocus(new FocusNode());
                        // Show the date picker
                        _selectDate(context);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Choose your date';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: jobSalaryController,
                      maxLines: null,
                      // Allows the text field to expand
                      decoration: InputDecoration(
                        labelText: "Price",
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your job Salary';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     const Text(
                    //       "Training Required ",
                    //       style: TextStyle(
                    //         fontSize: 16,
                    //       ),
                    //     ),
                    //     Checkbox(
                    //       value: trainingRequired,
                    //       // Set the value of the checkbox
                    //       onChanged: (value) {
                    //         // Define the onChanged callback function
                    //         setState(() {
                    //           trainingRequired = value!;
                    //         });
                    //       },
                    //     ),
                    //   ],
                    // ),
                    // TextFormField(
                    //   enabled: trainingRequired,
                    //   controller: trainingTitleController,
                    //   maxLines: null,
                    //   // Allows the text field to expand
                    //   decoration: InputDecoration(
                    //     labelText: "Training Title",
                    //     border: const OutlineInputBorder(),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //   ),
                    //   /*validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your training title';
                    //     }
                    //     return null;
                    //   },*/
                    // ),
                    // const SizedBox(height: 20),
                    // TextFormField(
                    //   enabled: trainingRequired,
                    //
                    //   controller: trainingDescController,
                    //   maxLines: null,
                    //   // Allows the text field to expand
                    //   decoration: InputDecoration(
                    //     labelText: "Training Description",
                    //     border: const OutlineInputBorder(),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //   ),
                    //   /*validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your training description';
                    //     }
                    //     return null;
                    //   },*/
                    // ),
                    // const SizedBox(height: 20),
                    // TextFormField(
                    //   enabled: trainingRequired,
                    //
                    //   controller: trainingPeriodController,
                    //   maxLines: null,
                    //   // Allows the text field to expand
                    //   decoration: InputDecoration(
                    //     labelText: "Training Period",
                    //     border: const OutlineInputBorder(),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //   ),
                    //   /*validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your training description';
                    //     }
                    //     return null;
                    //   },*/
                    // ),
                    // const SizedBox(height: 20),
                    // TextFormField(
                    //   enabled: trainingRequired,
                    //   keyboardType: TextInputType.number,
                    //
                    //   controller: trainingFeesController,
                    //   maxLines: null,
                    //   // Allows the text field to expand
                    //   decoration: InputDecoration(
                    //     labelText: "Training Fees",
                    //     border: const OutlineInputBorder(),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //   ),
                    //   /*validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your training description';
                    //     }
                    //     return null;
                    //   },*/
                    // ),
                    // const SizedBox(height: 20),
                    // TextFormField(
                    //   enabled: trainingRequired,
                    //
                    //   controller: trainingReqController,
                    //   maxLines: null,
                    //   // Allows the text field to expand
                    //   decoration: InputDecoration(
                    //     labelText: "Training Requirement",
                    //     border: const OutlineInputBorder(),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //   ),
                    //   /*validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Please enter your training requirement';
                    //     }
                    //     return null;
                    //   },*/
                    // ),
                    //  SizedBox(height: getProportionateScreenHeight(40)),
                    CustomElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          FirebaseFirestore.instance.collection('services').doc().set({
                            "ImagesURL": allBookingURLS,
                            "phoneNumber": phoneNumberController.text.trim(),
                            'postCreatorId': FirebaseAuth.instance.currentUser!.uid,
                            'job_title': serviceNameController.text.trim(),
                            'job_description': SeriveDescriptionController.text.trim(),
                            'selectedDate': _dateController.text.trim(),
                            'job_salary': jobSalaryController.text.trim(),
                          }).then((value) {
                            CustomToast.toastErrorMessage("Job Posted Successfully ");
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CustomBottomNavBarForCompany(),
                              ),
                            );
                          }).catchError((error) => print("Failed to add user: $error"));
                        }
                      },
                      text: ("Create Services"),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
