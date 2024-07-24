import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:laptopfyp/helper_classes/custom_elevated_button.dart';

class PendingRequest extends StatefulWidget {
  PendingRequest({super.key});

  @override
  State<PendingRequest> createState() => _PendingRequestState();
}

class _PendingRequestState extends State<PendingRequest> {
  TextEditingController rejectionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundTheme(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('company_verification_requests').where("company_status", isEqualTo: "").snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No pending Requests anymore'));
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
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Form Number ${index + 1}', style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text('Company Name: ${request['company_name'] ?? "Nothing"}'),
                          Text('Email: ${request['email']}'),
                          Text('Contact Number: ${request['contact_number']}'),
                          Text('Physical Address: ${request['physical_address']}'),
                          Text('LinkedIn Profile: ${request['linkedin_profile']}'),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 35,
                                width: 120,
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
                                                  FirebaseFirestore.instance.collection('company_verification_requests').doc(docId).update({
                                                    "company_status": "approved",
                                                    "company_rejection_reason": "",
                                                  }).then((result) {
                                                    Navigator.of(context).pop(); // Close the dialog

                                                    print("Status approved");
                                                  }).catchError((onError) {
                                                    print("error:$onError");
                                                  });
                                                },
                                                child: const Text("Confirmed"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    text: "Approve"),
                              ),
                              SizedBox(
                                height: 35,
                                width: 120,
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
                                                // validation code here
                                                validator: (value) {
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please enter your Reason';
                                                  }
                                                  if (RegExp(r'^[\s0-9!@#\$%\^&*(),.?":{}|<>]').hasMatch(value[0])) {
                                                    return 'Reason cannot start with a number or special character';
                                                  }
                                                }),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop(); // Close the dialog
                                                },
                                                child: const Text("Cancel"),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  FirebaseFirestore.instance.collection('company_verification_requests').doc(docId).update({
                                                    "company_status": "rejected",
                                                    "company_rejection_reason": rejectionController.text,
                                                  }).then((result) {
                                                    rejectionController.clear();
                                                    Navigator.of(context).pop();
                                                    print("Status rejected");
                                                  }).catchError((onError) {
                                                    print("error:$onError");
                                                  });
                                                },
                                                child: const Text("Confirmed"),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    text: "Reject"),
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
