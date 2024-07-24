import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';

class RegisteredWomens extends StatelessWidget {
  final String searchQuery;

  RegisteredWomens({super.key, required this.searchQuery});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundTheme(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where("user_type", isEqualTo: "Job Seeker")
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Extract the list of women from the snapshot
            var users = snapshot.data!.docs;

            // Filter users based on the search query
           /* if (searchQuery.isNotEmpty) {
              users = users.where((user) {
                return user['username']
                    .toString()
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase());
              }).toList();
            }
*/

            if (searchQuery.isNotEmpty) {
              users = users.where((company) {
                final companyName = company['username'].toString().toLowerCase();
                final email = company['email'].toString().toLowerCase();
                final query = searchQuery.toLowerCase();

                return companyName.contains(query) || email.contains(query);
              }).toList();
            }

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                var request = users[index];
                return ExpansionTile(
                  title: Text(request['username']),
                  subtitle: Text(request['email']),
                  children: <Widget>[
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('User Type: ${request['user_type']}'),
                          Text('Username: ${request['username']}'),
                          Text('Email: ${request['email']}'),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
