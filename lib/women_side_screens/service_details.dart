import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:laptopfyp/helper_classes/custom_elevated_button.dart';
import 'package:laptopfyp/women_side_screens/ServicesBookings.dart';
import 'package:laptopfyp/women_side_screens/form_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ServicesDetails extends StatelessWidget {
  final String docId;

  const ServicesDetails({super.key, required this.docId});

  void _openWhatsAppChat(String phoneNumber) async {
    final Uri uri = Uri(
      scheme: 'https',
      path: 'wa.me',
      queryParameters: {
        'text': 'Hi, How are you?',
        'phone': phoneNumber,
      },
    );
    // ignore: deprecated_member_use
    if (await canLaunch(uri.toString())) {
      // ignore: deprecated_member_use
      await launch(uri.toString());
    } else {
      throw 'Could not launch WhatsApp.';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          "Services Details",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('services')
            .doc(docId)
            .snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Something went wrong'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;
          var docID = snapshot.data!.id;
          List imagesCount = data['ImagesURL'];

          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 1, color: Colors.black)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 4.0,
                          mainAxisSpacing: 4.0,
                        ),
                        itemCount: imagesCount.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => _showImagePreview(
                                data['ImagesURL'][index], context),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                data['ImagesURL'][index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    data['job_title'],
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Description",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    data['job_description'],
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Phone number",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _openWhatsAppChat(
                        data['phoneNumber'] ?? "",
                      );
                    },
                    child: Text(
                      data['phoneNumber'],
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),

                  const SizedBox(height: 10),
                  const Text(
                    "Date",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    data['selectedDate'],
                    style: const TextStyle(fontSize: 14),
                  ),

                  const SizedBox(height: 10),
                  const Text(
                    "Price",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    data['job_salary'],
                    style: const TextStyle(fontSize: 14),
                  ),
                  // const Divider(),
                  // const SizedBox(height: 10),
                  // if (data['training_title'] != null) ...[
                  //   const Center(
                  //     child: Text(
                  //       "Services",
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 16,
                  //       ),
                  //     ),
                  //   ),
                  //   const Text(
                  //     "Name",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  //   Text(
                  //     data['training_title'],
                  //     style: const TextStyle(fontSize: 14),
                  //   ),
                  //   const SizedBox(height: 10),
                  //   const Text(
                  //     "Description",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  //   Text(
                  //     data['training_description'] ?? "",
                  //     style: const TextStyle(fontSize: 14),
                  //   ),
                  //   const SizedBox(height: 10),
                  //   const Text(
                  //     "Benefits",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  //   Text(
                  //     data['training_requirement'] ?? "",
                  //     style: const TextStyle(fontSize: 14),
                  //   ),
                  //   const SizedBox(height: 10),
                  //   const Text(
                  //     "Time Period",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  //   Text(
                  //     data['training_period'] ?? "",
                  //     style: const TextStyle(fontSize: 14),
                  //   ),
                  //   const SizedBox(height: 10),
                  //   const Text(
                  //     "Charges",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 16,
                  //     ),
                  //   ),
                  //   Text(
                  //     data['training_fees'] ?? "",
                  //     style: const TextStyle(fontSize: 14),
                  //   ),
                  // ] else ...[
                  //   const Text("XNo Training Required For this Job")
                  // ],
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SerivcesBooking(
                                  postCreatorId: data['postCreatorId'],
                                )),
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xFF405230),
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 10),
                        child: Text(
                          "Order Now",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
