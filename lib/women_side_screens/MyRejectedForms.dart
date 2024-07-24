import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:laptopfyp/helper_classes/custom_elevated_button.dart';
import 'package:url_launcher/url_launcher.dart';

class MyRejectedForms extends StatelessWidget {
  String type;

  MyRejectedForms({super.key, required this.type});
  void openWhatsApp(String phoneNumber) async {
    final whatsappUrl = "https://wa.me/$phoneNumber";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw "Could not launch $whatsappUrl";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BackgroundTheme(
      child: StreamBuilder<QuerySnapshot>(
          stream: type == "hall"
              ? FirebaseFirestore.instance.collection('woman_form').where("form_status", isEqualTo: "rejected").where("formApplierId", isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots()
              : FirebaseFirestore.instance.collection('ServicesBooking').where("form_status", isEqualTo: "rejected").where("formApplierId", isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
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
                // print ("jooo${request['cv_url']}");
                return ExpansionTile(
                  title: Text(request['Full_name']),
                  subtitle: Text(request['email']),
                  children: <Widget>[
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                              onTap:(){
                                openWhatsApp(
                                  request['mobile_number']?? "",
                                );
                              },
                              child: Text('Contact Number: ${request['mobile_number']}')),
                          Text('Address: ${request['address']}'),
                          Text('Age: ${request['age']}'),
                          if (requestData.containsKey('cv_url')) // Use containsKey on requestData now
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: ElevatedButton(
                                child: const Text("Download Payment Slip"),
                                onPressed: () {
                                  launchUrl(Uri.parse(request['cv_url']));
                                },
                              ),
                            ),
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
