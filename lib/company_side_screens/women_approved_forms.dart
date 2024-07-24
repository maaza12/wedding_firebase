import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:laptopfyp/helper_classes/custom_elevated_button.dart';
import 'package:url_launcher/url_launcher.dart';

class WomenApprovedForms extends StatelessWidget {
  String bookingType;

  WomenApprovedForms({Key? key, required this.bookingType});

  TextEditingController rejectionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundTheme(
      child: StreamBuilder<QuerySnapshot>(
          stream: bookingType == "hall"
              ? FirebaseFirestore.instance
                  .collection('woman_form')
                  .where("form_status", isEqualTo: "approved")
                  .where("postCreatorID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots()
              : FirebaseFirestore.instance
                  .collection('ServicesBooking')
                  .where("form_status", isEqualTo: "approved")
                  .where("postCreatorID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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

                Map<String, dynamic> requestData = request.data() as Map<String, dynamic>;
                print("joo2o${request['cv_url']}");

                return ExpansionTile(
                  title: Text(request['Full_name']),
                  subtitle: Text(request['email']),
                  children: <Widget>[
                    ListTile(
                        title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Contact Number: ${request['mobile_number']}'),
                        Text('Address: ${request['address']}'),
                        Text('Age: ${request['age']}'),
                        if (requestData.containsKey('cv_url')) // Use containsKey on requestData now
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ElevatedButton(
                              child: const Text("Download Payment Slip"),
                              onPressed: () {
                                launchUrl(Uri.parse(requestData['cv_url']));
                              },
                            ),
                          ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Want to Reject? "),
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
                                                FirebaseFirestore.instance.collection(bookingType == "hall" ? 'woman_form' : "ServicesBooking").doc(docId).update({
                                                  "form_status": "rejected",
                                                  "form_rejection_reason": rejectionController.text,
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
                        )
                      ],
                    )),
                  ],
                );
              },
            );
          }),
    ));
  }
}
