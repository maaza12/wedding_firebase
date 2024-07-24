import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:laptopfyp/helper_classes/custom_elevated_button.dart';
import 'package:laptopfyp/women_side_screens/form_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class JobDetails extends StatelessWidget {
  final String docId;

  const JobDetails({super.key, required this.docId});
  void openWhatsApp(String phoneNumber) async {
    final whatsappUrl = "https://wa.me/$phoneNumber";

    if (await canLaunch(whatsappUrl)) {
      await launch(whatsappUrl);
    } else {
      throw "Could not launch $whatsappUrl";
    }
  }
  void _showImagePreview(String imageUrl,context) {
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
        title: const Text("Hall Details",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection('post').doc(docId).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            var data = snapshot.data!.data() as Map<String, dynamic>;
            var docID = snapshot.data!.id;
           List imagesCount = data['ImagesURL']?? "";
            return Padding(
              padding: const EdgeInsets.all(20.0),
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
                        itemCount:  imagesCount.length ,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => _showImagePreview(data['ImagesURL'][index],context),

                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                data['ImagesURL']
                                [index],
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  const Text(
                    "Name",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    data['job_title']?? "",
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
                    data['job_description']?? "",
                    style: const TextStyle(fontSize: 14),
                  ),    const SizedBox(height: 10),
                  const Text(
                    "Phone number",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      openWhatsApp(
                        data['phoneNumber']?? "",
                      );
                    },
                    child: Text(
                      data['phoneNumber'] ?? "",
                      style: const TextStyle(fontSize: 14,),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Location",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    data['job_location'] ?? "",
                    style: const TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Timing",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    data['job_timing'] ?? "",
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
                    data['job_salary'] ?? "",
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
                            builder: (context) => FormScreen(
                              postCreatorId: data['postCreatorId'] ?? "",
                            )),
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(color: const Color(0xFF405230), borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15.0,vertical: 10),
                            child: Text(
                              "Order Now",
                              style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                  ),

                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
