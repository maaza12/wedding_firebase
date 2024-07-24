/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:responsive_config/responsive_config.dart';

class JobDetailsCompany extends StatelessWidget {
  final String docId;

  const JobDetailsCompany({super.key, required this.docId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Job Details"),
        centerTitle: true,
        elevation: 15,
        automaticallyImplyLeading: false,

      ),
      body: BackgroundTheme(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('post')
              .doc(docId)
              .snapshots(),
          builder: (BuildContext context,
              AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            var data = snapshot.data!.data() as Map<String, dynamic>;

            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          
                          const SizedBox(height: 10),
                          const Text(
                            "Job Title",
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
                            "Job Description",
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
                            "Job Requirement",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            data['job_requirement'],
                            style: const TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: getProportionateScreenHeight(10)),
                          if (data['training_title'] != null) ...[
                            const SizedBox(height: 10),
                            const Text(
                              "Training Title",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              data['training_title'],
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Training Description",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              data['training_description'] ?? "",
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Training Requirement",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              data['training_requirement'] ?? "",
                              style: const TextStyle(fontSize: 14),
                            ),
                          ]
                          else ...[const Text ("No Training Required For this Job")],

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laptopfyp/company_side_screens/my_ads.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:responsive_config/responsive_config.dart';

class JobDetailsCompany extends StatelessWidget {
  String type;
  final String docId;

  JobDetailsCompany({super.key, required this.docId, required this.type});

  Future<void> _deletePost(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('post').doc(docId).delete().then((value) {
        Get.off(MyAds());
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to delete the post')),
      );
    }
  }

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Post'),
          content: const Text('Are you sure you want to delete this post?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _deletePost(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          type == "hall" ? "Hall Details" : "Service Details",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 15,
        automaticallyImplyLeading: false,
      ),
      body: BackgroundTheme(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection(type == "hall" ? 'post' : "services").doc(docId).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data == null || !snapshot.data!.exists) {
              return const Center(child: Text('Document does not exist'));
            }

            var data = snapshot.data!.data() as Map<String, dynamic>?;

            if (data == null) {
              return const Center(child: Text('Document data is empty'));
            }
            List imagesCount = data['ImagesURL'];

            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 250,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(width: 1, color: Colors.black)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 4.0,
                                mainAxisSpacing: 4.0,
                              ),
                              itemCount: imagesCount.length,
                              itemBuilder: (context, index) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    data['ImagesURL'][index],
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        type == "hall"
                            ? const Text(
                                "Hall Name",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )
                            : const Text(
                                "Service Name",
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
                        type == "hall"
                            ?  const Text(
                          "Hall Description",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        )
                        :const Text(
                          "Service Description",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          data['job_description'],
                          style: const TextStyle(fontSize: 14),
                        ),
                        type == "hall"
                            ? const Text(
                                "Sitting Capacity",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )
                            : const SizedBox(),
                        type == "hall"
                            ? Text(
                                data['job_requirement'],
                                style: const TextStyle(fontSize: 14),
                              )
                            : const SizedBox(),

                        const SizedBox(height: 10),
                        type == "hall"
                            ? const Text(
                                "Hall Location",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )
                            : const SizedBox(),
                        type == "hall"
                            ? Text(
                                data['job_location'],
                                style: const TextStyle(fontSize: 14),
                              )
                            : const SizedBox(),

                        const SizedBox(height: 10),
                        type == "hall"
                            ? const Text(
                                "Hall Timing",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )
                            : const Text(
                                "Date",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                        type == "hall"
                            ? Text(
                                data['job_timing'],
                                style: const TextStyle(fontSize: 14),
                              )
                            : Text(
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

                        const SizedBox(height: 20),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => _showDeleteConfirmationDialog(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF405230), // Button color
                            ),
                            child: const Text(
                              'Delete Post',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        //const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
