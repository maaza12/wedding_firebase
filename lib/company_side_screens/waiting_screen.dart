/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptopfyp/custom_bottom_navbar/bottom_navbar_for_company.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? statusStream;

  @override
  void initState() {
    super.initState();
    getUserCollectionCount();
  }

  Future<void> getUserCollectionCount() async {
    try {
      var collectionRef =
          FirebaseFirestore.instance.collection('company_verification_requests').where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid);

      statusStream = collectionRef.snapshots();
    } catch (e) {
      // Handle any errors
      print('Error getting user collection count: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Just A Moment !!!"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BackgroundTheme(
        child: Center(
          child: StreamBuilder(
            stream: statusStream,
            builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Text('No data found');
              }

              String? status = snapshot.data!.docs.first['company_status'];

              if (status == "approved") {
                CircularProgressIndicator();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomBottomNavBarForCompany(),
                  ),
                );
                return Container(); // Placeholder widget
              } else {
                return Column(
                  children: [
                    const Text("Your verification is pending or rejected."),
                    Text("Reason: ${snapshot.data!.docs.first['company_rejection_reason'] ?? "Pending"}"),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laptopfyp/authentication_screens/company_verification_screen.dart';
import 'package:laptopfyp/company_side_screens/dashboard_company.dart';
import 'package:laptopfyp/custom_bottom_navbar/bottom_navbar_for_company.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:laptopfyp/helper_classes/custom_elevated_button.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  late Stream<QuerySnapshot<Map<String, dynamic>>> statusStream;

  @override
  void initState() {
    super.initState();
    getUserCollectionCount();
  }

  Future<void> getUserCollectionCount() async {
    try {
      var collectionRef =
          FirebaseFirestore.instance.collection('company_verification_requests').where('user_id', isEqualTo: FirebaseAuth.instance.currentUser!.uid);

      setState(() {
        statusStream = collectionRef.snapshots();
      });
    } catch (e) {
      // Handle any errors
      print('Error getting user collection count: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Just A Moment !!!"),
        elevation: 15,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BackgroundTheme(
        child: Center(
          child: StreamBuilder(
            stream: statusStream,
            builder: (context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Text('No data found');
              }

              String? status = snapshot.data!.docs.first['company_status'];

              if (status == "approved") {
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardCompany(),
                    ),
                  );
                });
                return const CircularProgressIndicator();
              } else {
                return Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(18.0),
                      child: Text(
                        "Your verification is pending or rejected...",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),

                    Text(
                      "If Rejected ==> Reason: ${snapshot.data!.docs.first['company_rejection_reason'] ?? "Pending"}",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),

                    //Text("Reason: ${snapshot.data!.docs.first['company_rejection_reason'] ?? "Pending"}"),
                    const SizedBox(
                      height: 120,
                    ),
                    Container(
                      height: 100,
                      //color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CompanyVerificationScreen()),
                              );
                            },
                            text: "Make Sure you Fill up the Verification Form Correctly"),
                      ),
                    )
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
