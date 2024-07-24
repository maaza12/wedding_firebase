import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';

class RegisteredCompanies extends StatelessWidget {
  final String searchQuery;

  RegisteredCompanies({Key? key, required this.searchQuery}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundTheme(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('company_verification_requests').where("company_status", isEqualTo: "approved").snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            // Extract the list of approved requests from the snapshot
            var companies = snapshot.data!.docs;

            // Filter companies based on the search query
            /*if (searchQuery.isNotEmpty) {
              companies = companies.where((company) {
                return company['company_name']
                    .toString()
                    .toLowerCase()
                    .contains(searchQuery.toLowerCase());
              }).toList();
            }*/

            if (searchQuery.isNotEmpty) {
              companies = companies.where((company) {
                final companyName = company['company_name'].toString().toLowerCase();
                final email = company['email'].toString().toLowerCase();
                final query = searchQuery.toLowerCase();

                return companyName.contains(query) || email.contains(query);
              }).toList();
            }

            return ListView.builder(
              itemCount: companies.length,
              itemBuilder: (BuildContext context, int index) {
                var request = companies[index];
                return ExpansionTile(
                  title: Text(request['company_name']),
                  subtitle: Text(request['email']),
                  children: <Widget>[
                    ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Contact Number: ${request['contact_number']}'),
                          Text('Physical Address: ${request['physical_address']}'),
                          Text('LinkedIn Profile: ${request['linkedin_profile']}'),
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
