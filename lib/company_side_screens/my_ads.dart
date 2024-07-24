import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laptopfyp/company_side_screens/job_details_company.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:laptopfyp/helper_classes/custom_elevated_button.dart';

class MyAds extends StatelessWidget {
  String? type;

  MyAds({super.key, this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 15,
        title: Text(type == "hall" ? "My Hall" : "My Services",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: BackgroundTheme(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection(type == "hall" ? 'post' : "services")
              .where("postCreatorId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    var doc = snapshot.data!.docs;
                    var jobId = doc[index];
                    var Thumbnail = doc[index]['ImagesURL'][0];


                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Thumbnail != null && Thumbnail.toString().isNotEmpty
                                  ? Container(
                                  height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(Thumbnail),
                                    ),
                                  ))
                                  : Container(
                                height: 150,
                                decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                              ),
                              SizedBox(height: 10,),
                              type == "hall"
                                  ? const Text(
                                      "Hall name",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    )
                                  : const Text(
                                      "Service Name",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                              Text(
                                doc[index]['job_title'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              type == "hall"
                                  ? const Text(
                                      "Hall Description",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    )
                                  : const Text(
                                      "Service Description",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                              Text(
                                doc[index]['job_description'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14),
                              ),

                              const SizedBox(
                                height: 10,
                              ),
                              CustomElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => JobDetailsCompany(docId: jobId.id, type: type!,)),
                                    );
                                  },
                                  text:  type == "hall"? "View Halls":"View Services"),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            );
          },
        ),
      ),
    );
  }
}
