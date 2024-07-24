import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:laptopfyp/helper_classes/custom_elevated_button.dart';
import 'package:url_launcher/url_launcher.dart';

class WomenPendingForms extends StatefulWidget {
  String bookingType;

  WomenPendingForms({super.key, required this.bookingType});

  @override
  State<WomenPendingForms> createState() => _WomenPendingFormsState();
}

class _WomenPendingFormsState extends State<WomenPendingForms> {
  TextEditingController rejectionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundTheme(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: widget.bookingType == "hall"
                ? FirebaseFirestore.instance
                    .collection('woman_form')
                    .where("form_status", isEqualTo: "")
                    .where("postCreatorID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots()
                : FirebaseFirestore.instance
                    .collection('ServicesBooking')
                    .where("form_status", isEqualTo: "")
                    .where("postCreatorID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              print("here is the current user id ${FirebaseAuth.instance.currentUser!.uid}");
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No pending Forms anymore'));
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              // Extract the list of pending requests from the snapshot
              var pendingRequests = snapshot.data!.docs;
              return ListView.builder(
                itemCount: pendingRequests.length,
                itemBuilder: (BuildContext context, int index) {
                  var request = pendingRequests[index];
                  var docId = request.id;

                  Map<String, dynamic> requestData = request.data() as Map<String, dynamic>;
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Form Number ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text('Full Name: ${request['Full_name'] ?? "Not specified"}'),
                          Text('Email: ${request['email']}'),
                          Text('Contact Number: ${request['mobile_number']}'),
                          Text('Address: ${request['address']}'),
                          Text('Age: ${request['age']}'),
                          if (requestData.containsKey('cv_url')) // Use containsKey on requestData now
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ElevatedButton(
                                child: const Text("Payment Slip"),
                                onPressed: () {
                                  launchUrl(Uri.parse(requestData['cv_url']));
                                },
                              ),
                            ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 35,
                                width: 130,
                                child: CustomElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Are you sure you want to Approve?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(); // Close the dialog
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                FirebaseFirestore.instance.collection(widget.bookingType == "hall" ? 'woman_form' : "ServicesBooking").doc(docId).update({
                                                  "form_status": "approved",
                                                  "form_rejection_reason": "",
                                                }).then((result) {
                                                  Navigator.of(context).pop(); // Close the dialog
                                                  print("Status approved");
                                                }).catchError((onError) {
                                                  print("error: $onError");
                                                });
                                              },
                                              child: const Text("Confirm"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  text: "Approve",
                                ),
                              ),
                              SizedBox(
                                height: 35,
                                width: 130,
                                child: CustomElevatedButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Rejection Reason"),
                                          content: TextFormField(
                                            controller: rejectionController,
                                            decoration: InputDecoration(
                                              hintText: "Comment your Reason",
                                              labelStyle: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                                              errorStyle: const TextStyle(color: Colors.black), // Error text color
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop(); // Close the dialog
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                if (rejectionController.text.isNotEmpty) {
                                                  FirebaseFirestore.instance
                                                      .collection(widget.bookingType == "hall" ? 'woman_form' : "ServicesBooking")
                                                      .doc(docId)
                                                      .update({
                                                    "form_status": "rejected",
                                                    "form_rejection_reason": rejectionController.text,
                                                  }).then((result) {
                                                    rejectionController.clear();
                                                    Navigator.of(context).pop();
                                                    print("Status rejected");
                                                  }).catchError((onError) {
                                                    print("error: $onError");
                                                  });
                                                }
                                              },
                                              child: const Text("Confirm"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  text: "Reject",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
