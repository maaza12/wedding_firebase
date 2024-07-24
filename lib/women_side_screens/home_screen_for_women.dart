/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:laptopfyp/helper_classes/custom_elevated_button.dart';
import 'package:laptopfyp/women_side_screens/job_details.dart';
import 'package:laptopfyp/women_side_screens/profile_settings/profile_screen.dart';

class HomeScreenForWomen extends StatefulWidget {
  HomeScreenForWomen({super.key});

  @override
  State<HomeScreenForWomen> createState() => _HomeScreenForWomenState();
}

class _HomeScreenForWomenState extends State<HomeScreenForWomen> {
  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                  );
                },
                child: const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/logo.png"),
                )),
          )
        ],
      ),
      body: BackgroundTheme(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                style: const TextStyle(fontSize: 15),
                decoration: const InputDecoration(
                  hintText: "Search",
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            searchQuery.isNotEmpty
                ? Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('post').snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }

                        final results = snapshot.data!.docs.where((DocumentSnapshot document) {
                          final data = document.data() as Map<String, dynamic>;
                          return data['job_title'].toString().toLowerCase().contains(searchQuery.toLowerCase());
                        }).toList();

                        return ListView.builder(
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            final data = results[index].data() as Map<String, dynamic>;
                            //var jobId = data[index];
                            var jobId = results[index].id;

                            return Card(
                              //color: const Color(0xFFD7FFC7),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(children: [
                                      CircleAvatar(
                                        radius: 27,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "Company Name",
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ]),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Job Title",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    Text(
                                      data['job_title'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Job Description",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    Text(
                                      data['job_description'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Job Requirement",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                    ),
                                    Text(
                                      data['job_requirement'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          height: 35,
                                          width: 335,
                                          child: CustomElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => JobDetails(docId: jobId)),


                                                  //MaterialPageRoute(builder: (context) => JobDetails(docId: jobId.id)),
                                                );
                                              },
                                              text: "View Job"),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            );

                            */
/*    ListTile(
                              title: Text(data['job_title']),
                            );*/ /*

                          },
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('post').snapshots(),
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
                                //var jobId = doc[index];
                                var jobId = doc[index].id;

                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Card(
                                    //color: const Color(0xFFD7FFC7),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Row(children: [
                                            CircleAvatar(
                                              radius: 27,
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Company Name",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ]),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Text(
                                            "Job Title",
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
                                          const Text(
                                            "Job Description",
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
                                          const Text(
                                            "Job Requirement",
                                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                          ),
                                          Text(
                                            doc[index]['job_requirement'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontSize: 14),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: 35,
                                                width: 335,
                                                child: CustomElevatedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => JobDetails(docId: jobId)),

                                                        //MaterialPageRoute(builder: (context) => JobDetails(docId: jobId.id)),
                                                      );
                                                    },
                                                    text: "View details"),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
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
          ],
        ),
      ),
    );
  }
}
*/

// company name display krwaya h

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:laptopfyp/helper_classes/custom_elevated_button.dart';
import 'package:laptopfyp/women_side_screens/job_details.dart';
import 'package:laptopfyp/women_side_screens/profile_screen.dart';

class HomeScreenForWomen extends StatefulWidget {
  HomeScreenForWomen({super.key});

  @override
  State<HomeScreenForWomen> createState() => _HomeScreenForWomenState();
}

class _HomeScreenForWomenState extends State<HomeScreenForWomen> {
  String searchQuery = "";

  Future<String> getUsername(String userId) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return userDoc['username']; // Fetching the 'username' field
  }

  void showUserDetailsDialog(BuildContext context, userID) async {
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(userID).get();

    if (!userDoc.exists) {
      return; // Handle user document not found case
    }

    final userData = userDoc.data() as Map<String, dynamic>;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          title: const Text("User Details"),
          content: SizedBox(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row( mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,children: [

                  userData['profile_picture']!= null &&
                      userData['profile_picture'].toString().isNotEmpty
                      ? CircleAvatar(
                    backgroundImage: NetworkImage(
                        userData['profile_picture']
                    ),
                    radius: 35,
                  )
                      : const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.grey,
                  ),


                ]),
                Text("Full Name: ${userData['username'] ?? 'Not specified'}",style: TextStyle(fontSize: 16),),
                Text("Email: ${userData['email'] ?? 'Not specified'}",style: TextStyle(fontSize: 16),),
                Text("Phone Number: ${userData['mobile_num'] ?? 'Not specified'}",style: TextStyle(fontSize: 16),),
                // Add more fields as necessary
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
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
        backgroundColor: Colors.green.shade100,
        title: const Text("Halls",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
        automaticallyImplyLeading: false,
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.all(8.0),
        //     child: InkWell(
        //         onTap: () {
        //           Navigator.push(
        //             context,
        //             MaterialPageRoute(builder: (context) => const ProfileScreen()),
        //           );
        //         },
        //         child: const CircleAvatar(
        //           backgroundImage: AssetImage("assets/images/logo.png"),
        //         )),
        //   )
        // ],
      ),
      body: BackgroundTheme(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                style: const TextStyle(fontSize: 15),
                decoration: const InputDecoration(
                  hintText: "Search (name,pricing,sitting,location).",
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
            ),
            searchQuery.isNotEmpty
                ? Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('post').snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        /*final results = snapshot.data!.docs.where((DocumentSnapshot document) {
                    final data = document.data() as Map<String, dynamic>;
                    return data['job_title'].toString().toLowerCase().contains(searchQuery.toLowerCase());
                  }).toList();*/

                        final results = snapshot.data!.docs.where((DocumentSnapshot document) {
                          final data = document.data() as Map<String, dynamic>;
                          final searchLower = searchQuery.toLowerCase();
                          return data['job_title'].toString().toLowerCase().contains(searchLower) ||
                              data['job_location'].toString().toLowerCase().contains(searchLower) ||
                              data['job_timing'].toString().toLowerCase().contains(searchLower) ||
                              data['job_salary'].toString().toLowerCase().contains(searchLower) ||
                              data['job_requirement'].toString().toLowerCase().contains(searchLower);
                        }).toList();

                        return ListView.builder(
                          itemCount: results.length,
                          itemBuilder: (context, index) {
                            final data = results[index].data() as Map<String, dynamic>;
                            var jobId = results[index].id;
                            var postCreatorId = data['postCreatorId'];

                            return FutureBuilder(
                                future: FirebaseFirestore.instance.collection('users').doc(postCreatorId).get(),
                                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                                  {
                                    if (!snapshot.hasData) {
                                      return const Card(
                                        child: Padding(
                                          padding: EdgeInsets.all(20.0),
                                          child: Center(child: CircularProgressIndicator()),
                                        ),
                                      );
                                    }
                                    return Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(children: [
                                              const CircleAvatar(
                                                radius: 27,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                snapshot.data!["username"],
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                ),
                                              ),
                                            ]),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            // Thumbnail != null && Thumbnail.toString().isNotEmpty
                                            //     ? Container(
                                            //     height: 150,
                                            //     decoration: BoxDecoration(
                                            //       borderRadius: BorderRadius.circular(10),
                                            //       image: DecorationImage(
                                            //         fit: BoxFit.fill,
                                            //         image: NetworkImage(Thumbnail),
                                            //       ),
                                            //     ))
                                            //     : Container(
                                            //   height: 150,
                                            //   decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                                            // ),

                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Hall name",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                            ),
                                            Text(
                                              data['job_title'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontSize: 14),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Hall Description",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                            ),
                                            Text(
                                              data['job_description'],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontSize: 14),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            const Text(
                                              "Siting capacity",
                                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                            ),
                                            Text(
                                              data['job_requirement'],
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
                                                    MaterialPageRoute(builder: (context) => JobDetails(docId: jobId)),
                                                  );
                                                },
                                                text: "View Details"),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );

                                    // getUsername(postCreatorId),
                                  }
                                });
                          },
                        );
                      },
                    ),
                  )
                : Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('post').snapshots(),
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
                                var jobId = doc[index].id;
                                var postCreatorId = doc[index]['postCreatorId'];
                                var Thumbnail = doc[index]['ImagesURL'][0];

                                return FutureBuilder(
                                  future: FirebaseFirestore.instance.collection('users').doc(postCreatorId).get(),
                                  // getUsername(postCreatorId),
                                  builder: (context, userSnapshot) {
                                    if (!userSnapshot.hasData) {
                                      return const Card(
                                        child: Padding(
                                          padding: EdgeInsets.all(20.0),
                                          child: Center(child: CircularProgressIndicator()),
                                        ),
                                      );
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Card(
                                        color: const Color(0xFFDBF1C8),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  showUserDetailsDialog(
                                                    context,
                                                    userSnapshot.data!["userID"],
                                                  );
                                                },
                                                child: Row(children: [
                                                  userSnapshot.data!["profile_picture"] != null &&
                                                          userSnapshot.data!["profile_picture"].toString().isNotEmpty
                                                      ? CircleAvatar(
                                                          backgroundImage: NetworkImage(
                                                            userSnapshot.data!["profile_picture"],
                                                          ),
                                                          radius: 25,
                                                        )
                                                      : const CircleAvatar(
                                                          radius: 25,
                                                          backgroundColor: Colors.grey,
                                                        ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    userSnapshot.data!["username"],
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Thumbnail != null && Thumbnail.toString().isNotEmpty
                                                  ? Container(
                                                      height: 200,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(Thumbnail),
                                                        ),
                                                      ))
                                                  : Container(
                                                      height: 150,
                                                      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)),
                                                    ),
                                              const SizedBox(
                                                width: 20,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              const Text(
                                                "Hall Name",
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
                                              const Text(
                                                "Hall Description",
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
                                              SizedBox(
                                                height: 35,
                                                child: CustomElevatedButton(
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(builder: (context) => JobDetails(docId: jobId)),
                                                      );
                                                    },
                                                    text: "View Details"),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
