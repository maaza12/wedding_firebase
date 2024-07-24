import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:laptopfyp/helper_classes/custom_elevated_button.dart';

class RejectedRequest extends StatelessWidget {
  const RejectedRequest({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundTheme(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('company_verification_requests').where("company_status", isEqualTo: "rejected" )
                  .snapshots(),
              builder:
                  (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Something went wrong'));
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
                    return ExpansionTile(
                      title: Text(request['company_name']),
                      subtitle: Text(request['email']),
                      children: <Widget>[
                        ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Contact Number: ${request['contact_number']}'),
                                Text(
                                    'Physical Address: ${request['physical_address']}'),
                                Text(
                                    'LinkedIn Profile: ${request['linkedin_profile']}'),
                                Text('Reason: ${request['company_rejection_reason']}'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Want to Approve? "),
                                    SizedBox(
                                      height: 35,
                                      width: 120,
                                      child: CustomElevatedButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      "Are you sure you want to Approve?"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // Close the dialog
                                                      },
                                                      child: const Text("Cancel"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        FirebaseFirestore.instance
                                                            .collection(
                                                            'company_verification_requests')
                                                            .doc(docId)
                                                            .update({
                                                          "company_status":
                                                          "approved",
                                                          "company_rejection_reason":
                                                          "",
                                                        }).then((result) {
                                                          Navigator.of(context)
                                                              .pop(); // Close the dialog

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

                                  ],
                                )

                              ],

                            ),


                        ),
                      ],
                    );
                  },
                );
              }),
        ));
  }
}
