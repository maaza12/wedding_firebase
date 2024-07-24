import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:laptopfyp/women_side_screens/job_details.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPendingForms extends StatefulWidget {
  String type;

  MyPendingForms({super.key, required this.type});

  @override
  State<MyPendingForms> createState() => _MyPendingFormsState();
}

class _MyPendingFormsState extends State<MyPendingForms> {
  TextEditingController rejectionController = TextEditingController();

  void openWhatsApp(String phoneNumber) async {
    final whatsappUrl = "https://wa.me/$phoneNumber";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw "Could not launch $whatsappUrl";
    }
  }

  void _showImagePreview(String imageUrl, context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundTheme(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: widget.type == "hall"
                ? FirebaseFirestore.instance
                    .collection('woman_form')
                    .where("form_status", isEqualTo: "")
                    .where("formApplierId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots()
                : FirebaseFirestore.instance
                    .collection('ServicesBooking')
                    .where("form_status", isEqualTo: "")
                    .where("formApplierId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              print("here is user Id ${FirebaseAuth.instance.currentUser!.uid}");
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No Booking Available!'));
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
                          // Container(
                          //   height: 300,
                          //   child: StreamBuilder<QuerySnapshot>(
                          //     stream: FirebaseFirestore.instance
                          //         .collection('post')
                          //         .where(
                          //       "postCreatorId",
                          //       isEqualTo: request['postCreatorID'],
                          //     )
                          //         .snapshots(),
                          //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          //       print("here is user Id ${FirebaseAuth.instance.currentUser!.uid}");
                          //       if (snapshot.hasError) {
                          //         return const Center(child: Text('Something went wrong'));
                          //       }
                          //       if (!snapshot.hasData) {
                          //         return const Center(child: CircularProgressIndicator());
                          //       }
                          //       if (snapshot.data!.docs.isEmpty) {
                          //         return const Center(child: Text('No Booking Available!'));
                          //       }
                          //
                          //       if (snapshot.connectionState == ConnectionState.waiting) {
                          //         return const Center(child: CircularProgressIndicator());
                          //       }
                          //
                          //       // Extract the list of pending requests from the snapshot
                          //       var pendingRequests = snapshot.data!.docs;
                          //       return ListView.builder(
                          //         itemCount: pendingRequests.length,
                          //         itemBuilder: (BuildContext context, int index) {
                          //           var request = pendingRequests[index];
                          //           var docId = request.id;
                          //           List imagesCount = request['ImagesURL'];
                          //
                          //           Map<String, dynamic> requestData = request.data() as Map<String, dynamic>;
                          //           return Column(
                          //             children: [
                          //               Container(
                          //                 height: 250,
                          //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(width: 1, color: Colors.black)),
                          //                 child: Padding(
                          //                   padding: const EdgeInsets.all(8.0),
                          //                   child: GridView.builder(
                          //                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          //                       crossAxisCount: 3,
                          //                       crossAxisSpacing: 4.0,
                          //                       mainAxisSpacing: 4.0,
                          //                     ),
                          //                     itemCount: imagesCount.length,
                          //                     itemBuilder: (context, index) {
                          //                       return InkWell(
                          //                         onTap: () => _showImagePreview(request['ImagesURL'][index],context),
                          //
                          //                         child: ClipRRect(
                          //                           borderRadius: BorderRadius.circular(20),
                          //                           child: Image.network(
                          //                             request['ImagesURL'][index],
                          //                             fit: BoxFit.cover,
                          //                           ),
                          //                         ),
                          //                       );
                          //                     },
                          //                   ),
                          //                 ),
                          //               ),
                          //               Text('Hall owner Phone number: ${request['phoneNumber'] ?? "Not specified"}'),
                          //             ],
                          //           );
                          //         },
                          //       );
                          //     },
                          //   ),
                          // ),
                          const SizedBox(height: 8),
                          Text('Full Name: ${request['Full_name'] ?? "Not specified"}'),
                          Text('Email: ${request['email']}'),
                          InkWell(
                              onTap: () {
                                openWhatsApp(
                                  request['mobile_number'] ?? "",
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
                                  launchUrl(Uri.parse(requestData['cv_url']));
                                },
                              ),
                            ),

                          const SizedBox(height: 10),
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
