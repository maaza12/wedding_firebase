// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:laptopfyp/helper_classes/signout_dialog_box.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   bool enableVariable = false;
//   File? _image;
//   final picker = ImagePicker();
//   Future<Map<String, dynamic>?>? userDataFuture;
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController mobileNumController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController workExperienceController = TextEditingController();
//   TextEditingController degreeController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     userDataFuture = fetchUserData();
//     userDataFuture!.then((data) {
//       if (data != null) {
//         usernameController.text = data['username'] ?? '';
//         mobileNumController.text = data['mobile_num'] ?? '';
//         emailController.text = data['email'] ?? '';
//         workExperienceController.text = data['work_experience'] ?? '';
//         degreeController.text = data['degree'] ?? '';
//       }
//     });
//   }
//
//   Future<Map<String, dynamic>?> fetchUserData() async {
//     try {
//       DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
//       return userDoc.data() as Map<String, dynamic>?;
//     } catch (e) {
//       print("Error fetching user data: $e");
//       return null;
//     }
//   }
//
//   Future<void> updateUserData() async {
//     Map<String, dynamic> newData = {
//       'username': usernameController.text,
//       'mobile_num': mobileNumController.text,
//       'email': emailController.text,
//       'work_experience': workExperienceController.text,
//       'degree': degreeController.text,
//     };
//
//     // Update Firestore document
//     await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).update(newData);
//   }
//
//   Future<void> _getImage(ImageSource source) async {
//     final pickedFile = await picker.pickImage(source: source);
//
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       } else {
//         print('No image selected.');
//       }
//     });
//   }
//
//
//
//
//   Widget build(BuildContext context) {
//     double height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Profile Management", style: TextStyle(fontWeight: FontWeight.bold)),
//         centerTitle: true,
//         actions: [
//           InkWell(
//             onTap: () async {
//               if (enableVariable) {
//                 await updateUserData();
//                 // Save updated user data
//               }
//               setState(() {
//                 enableVariable = !enableVariable; // Toggle editing state
//               });
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(right: 15.0),
//               child: Text(
//                 enableVariable ? "Save" : "Edit",
//                 style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: FutureBuilder<Map<String, dynamic>?>(
//           future: userDataFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text("Error: ${snapshot.error}"));
//             } else if (snapshot.hasData) {
//               final userData = snapshot.data;
//               return Column(
//                 children: [
//                   _buildProfilePicture(),
//                   buildProfileForm(userData, height),
//                 ],
//               );
//             }
//             return const SizedBox();
//           },
//         ),
//       ),
//     );
//   }
//   // profile pic ko view krwaya hy
//   Widget _buildProfilePicture() {
//     return GestureDetector(
//       onTap: () {
//         if (_image != null) {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => Scaffold(
//                 appBar: AppBar(),
//                 body: Center(
//                   child: Image.file(_image!), // Display the tapped image
//                 ),
//               ),
//             ),
//           );
//         } else {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: const Text("No Profile Picture"),
//                 content: const Text("You haven't set a profile picture yet."),
//                 actions: <Widget>[
//                   TextButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                     child: const Text("OK"),
//                   ),
//                 ],
//               );
//             },
//           );
//         }
//       },
//       child: Stack(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               width: double.infinity,
//               height: 200,
//               decoration: BoxDecoration(
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(30),
//                   topRight: Radius.circular(30),
//                   bottomLeft: Radius.circular(30),
//                   bottomRight: Radius.circular(30),
//                 ),
//                 image: _image != null
//                     ? DecorationImage(
//                   image: FileImage(_image!),
//                   fit: BoxFit.cover,
//                 )
//                     : null,
//               ),
//               child: _image == null
//                   ? const Icon(
//                 Icons.account_circle,
//                 size: 100,
//                 color: Colors.grey,
//               )
//                   : null,
//             ),
//           ),
//           Positioned(
//             bottom: 10,
//             right: 10,
//             child: FloatingActionButton(
//               onPressed: () {
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       title: const Text("Choose an option"),
//                       content: SingleChildScrollView(
//                         child: ListBody(
//                           children: <Widget>[
//                             GestureDetector(
//                               child: const Row(
//                                 children: [
//                                   Icon(Icons.camera), // Icon
//                                   SizedBox(width: 8), // Spacer between icon and text
//                                   Text("Take a picture"), // Text
//                                 ],
//                               ),
//                               onTap: () {
//                                 _getImage(ImageSource.camera);
//                                 Navigator.of(context).pop();
//                               },
//                             ),
//                             const Padding(
//                               padding: EdgeInsets.all(8.0),
//                             ),
//                             GestureDetector(
//                               child: const Row(
//                                 children: [
//                                   Icon(Icons.image), // Icon
//                                   SizedBox(width: 8), // Spacer between icon and text
//                                   Text("Select from gallery"), // Text
//                                 ],
//                               ),
//                               onTap: () {
//                                 _getImage(ImageSource.gallery);
//                                 Navigator.of(context).pop();
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//               child: const Icon(Icons.camera_alt),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   Widget buildProfileForm(Map<String, dynamic>? userData, double height) {
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           SizedBox(height: height * 0.01),
//           const Text('Personal Information', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//           SizedBox(height: height * 0.02),
//           const Text(
//             '  Username',
//             style: TextStyle(fontSize: 17,  ),
//           ),
//           TextFormField(
//             controller: usernameController,
//             enabled: enableVariable,
//             decoration: InputDecoration(
//               hintText: userData?['username'],
//               hintStyle: const TextStyle(
//                 color: Colors.black,
//               ),
//               labelStyle: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//               disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//               enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//               focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//               errorStyle: const TextStyle(color: Colors.black), // Error text color
//             ),
//           ),
//           SizedBox(height: height * 0.02),
//           const Text(
//             '  Mobile Number',
//             style: TextStyle(fontSize: 18,  ),
//           ),
//           TextFormField(
//             controller: mobileNumController,
//             enabled: enableVariable,
//             decoration: InputDecoration(
//               hintText: userData?['mobile_num'] ?? "03xx-xxxxxxxx",
//               labelStyle: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//               disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//               enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//               focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//               errorStyle: const TextStyle(color: Colors.black), // Error text color
//             ),
//           ),
//           SizedBox(height: height * 0.02),
//           const Text(
//             '  Email',
//             style: TextStyle(fontSize: 18,  ),
//           ),
//           TextFormField(
//             controller: emailController,
//             enabled: enableVariable,
//             decoration: InputDecoration(
//               prefixIconColor: Colors.black,
//               hintText: userData?['email'],
//               labelStyle: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//               disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//               enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//               focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//               errorStyle: const TextStyle(color: Colors.black), // Error text color
//             ),
//           ),
//           SizedBox(height: height * 0.03),
//           const Text(
//             '  Professional Information',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: height * 0.02),
//           const Text(
//             '  Work Experience',
//             style: TextStyle(fontSize: 17,  ),
//           ),
//           TextFormField(
//             controller: workExperienceController,
//             enabled: enableVariable,
//             decoration: InputDecoration(
//               hintText: userData?['work_experience'] ?? "eg. 6 month, 1 year",
//               labelStyle: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//               disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//               enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//               focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//               errorStyle: const TextStyle(color: Colors.black), // Error text color
//             ),
//           ),
//           SizedBox(height: height * 0.02),
//           const Text(
//             '  Degree',
//             style: TextStyle(
//               fontSize: 17,
//                ,
//             ),
//           ),
//           TextFormField(
//             controller: degreeController,
//             enabled: enableVariable,
//             decoration: InputDecoration(
//               hintText: userData?['degree'] ?? "eg. Matric, Inter0",
//               labelStyle: const TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//               disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//               enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//               focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
//               errorStyle: const TextStyle(color: Colors.black), // Error text color
//             ),
//           ),
//           SizedBox(height: height * 0.02),
//           // Add more form fields as needed...
//           InkWell(
//             onTap: () => showSignOutConfirmationDialog(context),
//             child: Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 border: Border.all(width: 2, color: Colors.black26),
//                 borderRadius: const BorderRadius.all(Radius.circular(25)),
//               ),
//               child: const Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Center(
//                   child: Text(
//                     "Log Out",
//                     style: TextStyle(
//                       fontSize: 17,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:laptopfyp/helper_classes/custom_toast.dart';
import 'package:laptopfyp/helper_classes/signout_dialog_box.dart';
import 'package:path_provider/path_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool enableVariable = false;
  File? _image;
  final picker = ImagePicker();
  TextEditingController usernameController = TextEditingController();
  TextEditingController mobileNumController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController workExperienceController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  late Future<Map<String, dynamic>?> userDataFuture;

  @override
  void initState() {
    super.initState();
    // Initialize userDataFuture
    userDataFuture = fetchUserData().then((data) {
      if (data != null) {
        setState(() {
          usernameController.text = data['username'] ?? '';
          mobileNumController.text = data['mobile_num'] ?? '';
          emailController.text = data['email'] ?? '';
          workExperienceController.text = data['work_experience'] ?? '';
          degreeController.text = data['degree'] ?? '';
          addressController.text = data['address'] ?? '';
          ageController.text = data['age'] ?? '';

          String? imageUrl = data['profile_picture'];
          if (imageUrl != null) {
            downloadImage(imageUrl).then((imageFile) {
              if (imageFile != null) {
                setState(() {
                  _image = imageFile;
                });
              }
            });
          }
        });
      }
      return data;
    });
  }

  Future<Map<String, dynamic>?> fetchUserData() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      return userDoc.data() as Map<String, dynamic>?;
    } catch (e) {
      print("Error fetching user data: $e");
      return null;
    }
  }

  Future<File?> downloadImage(String imageUrl) async {
    try {
      final response = await http.get(Uri.parse(imageUrl));
      final bytes = response.bodyBytes;
      final fileName = imageUrl.split('/').last;
      final directory = await getTemporaryDirectory();
      final file = File('${directory.path}/$fileName');
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      print("Error downloading image: $e");
      return null;
    }
  }

  Future<void> updateUserData() async {
    Map<String, dynamic> newData = {
      'username': usernameController.text,
      'mobile_num': mobileNumController.text,
      'address': addressController.text,
      'age': ageController.text,
      'work_experience': workExperienceController.text,
      'degree': degreeController.text,
    };

    // Update Firestore document
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(newData);
  }

  Future<String?> _uploadImage(File imageFile) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(fileName);
      UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      print("Image DownloadURL $downloadUrl");
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }

  Future<void> _saveImageUrl(String imageUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'profile_picture': imageUrl,
      });
    } catch (e) {
      print("Error saving image URL to Firestore: $e");
    }
  }

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      String? imageUrl = await _uploadImage(imageFile);
      if (imageUrl != null) {
        await _saveImageUrl(imageUrl);
        setState(() {
          _image = imageFile;
        });
      } else {
        print('Failed to upload image.');
      }
    } else {
      print('No image selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 1,
        title: const Text("User Profile",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () async {
              if (enableVariable) {
                // Save updated user data
                updateUserData();
              }
              setState(() {
                enableVariable = !enableVariable; // Toggle editing state
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Text(
                enableVariable ? "Save" : "Edit",
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<Map<String, dynamic>?>(
          future: userDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CupertinoActivityIndicator(
                radius: 20,
              ));
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (snapshot.hasData) {
              final userData = snapshot.data;
              return Column(
                children: [
                  _buildProfilePicture(userData),
                  buildProfileForm(userData, height),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildProfilePicture(userData) {
    return GestureDetector(
      onTap: () {
        if (userData?['profile_picture'] != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(),
                body: Center(
                  child: Image.network(userData?['profile_picture']),
                ),
              ),
            ),
          );
        } else {
          CustomToast.toastErrorMessage("Please Upload a profile picture");
        }
      },
      child: Stack(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: userData?['profile_picture'] != null &&
                      userData!['profile_picture'].toString().isNotEmpty
                  ? SizedBox(
                      height: 150,
                      width: 150,
                      child: ClipOval(
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(
                              userData!['profile_picture'],
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                } else {
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                }
                              },
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return const Center(
                                  child: Text(
                                    "Failed to load image",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      height: 150,
                      width: 150,
                      decoration: const BoxDecoration(
                          color: Colors.grey, shape: BoxShape.circle),
                      child: const ClipOval(
                        child: Center(
                            child: Icon(
                          Icons.person,
                          size: 150,
                        )),
                      ),
                    )),
          Positioned(
            bottom: 10,
            right: 10,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Choose an option"),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            GestureDetector(
                              child: const Row(
                                children: [
                                  Icon(Icons.camera),
                                  SizedBox(width: 8),
                                  Text("Take a picture"),
                                ],
                              ),
                              onTap: () {
                                _getImage(ImageSource.camera);
                                Navigator.of(context).pop();
                              },
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                            ),
                            GestureDetector(
                              child: const Row(
                                children: [
                                  Icon(Icons.image),
                                  SizedBox(width: 8),
                                  Text("Select from gallery"),
                                ],
                              ),
                              onTap: () {
                                _getImage(ImageSource.gallery);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const CircleAvatar(
                child: Icon(Icons.camera_alt),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileForm(Map<String, dynamic>? userData, double height) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.02),
          const Text(
            '  Username',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          TextFormField(
            controller: usernameController,
            enabled: enableVariable,
            decoration: InputDecoration(
              hintText: userData?['username'],
              hintStyle: const TextStyle(
                color: Colors.black,
              ),
              labelStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              disabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              errorStyle:
                  const TextStyle(color: Colors.black), // Error text color
            ),
          ),
          SizedBox(height: height * 0.02),
          const Text(
            '  Mobile Number',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          TextFormField(
            controller: mobileNumController,
            enabled: enableVariable,
            decoration: InputDecoration(
              hintText: userData?['mobile_num'] ?? "03xx-xxxxxxxx",
              labelStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              disabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              errorStyle:
                  const TextStyle(color: Colors.black), // Error text color
            ),
          ),
          SizedBox(height: height * 0.02),
          const Text(
            '  Email',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          TextFormField(
            controller: emailController,
            enabled: enableVariable,
            decoration: InputDecoration(
              prefixIconColor: Colors.black,
              hintText: userData?['email'],
              labelStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              disabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              errorStyle:
                  const TextStyle(color: Colors.black), // Error text color
            ),
          ),
          SizedBox(height: height * 0.02),
          const Text(
            '  Address',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          TextFormField(
            controller: addressController,
            enabled: enableVariable,
            decoration: InputDecoration(
              prefixIconColor: Colors.black,
              hintText: userData?['address'] ?? "Address",
              labelStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              disabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              errorStyle:
                  const TextStyle(color: Colors.black), // Error text color
            ),
          ),
          SizedBox(height: height * 0.02),
          const Text(
            '  Age',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          TextFormField(
            controller: ageController,
            enabled: enableVariable,
            decoration: InputDecoration(
              prefixIconColor: Colors.black,
              hintText: userData?['age'] ?? "Age",
              labelStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              disabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              enabledBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              errorStyle:
                  const TextStyle(color: Colors.black), // Error text color
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () => showSignOutConfirmationDialog(context),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.black26),
                borderRadius: const BorderRadius.all(Radius.circular(25)),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Log Out",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
