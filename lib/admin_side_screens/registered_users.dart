/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laptopfyp/admin_side_screens/registered_companies.dart';
import 'package:laptopfyp/admin_side_screens/registered_womens.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';

class RegisteredUsers extends StatefulWidget {
  const RegisteredUsers({super.key});

  @override
  State<RegisteredUsers> createState() => _RegisteredUsersState();
}

class _RegisteredUsersState extends State<RegisteredUsers> {


  String searchQuery = "";

  Stream<int>? totalCompaniesCount;
  Stream<int>? totalWomanCount;

  @override
  void initState() {
    super.initState();
    totalCompaniesCount = getCompanyCollectionCount();
    totalWomanCount = getWomanCollectionCount();
  }

  Stream<int> getCompanyCollectionCount() {
    try {
      var collectionRef = FirebaseFirestore.instance
          .collection('company_verification_requests')
          .where("company_status", isEqualTo: "approved")
          .snapshots()
          .map((snapshot) => snapshot.size);
      return collectionRef;
    } catch (e) {
      debugPrint('Error getting user collection count: $e');
      return Stream.value(-1);
    }
  }

  Stream<int> getWomanCollectionCount() {
    try {
      var collectionRef =
          FirebaseFirestore.instance.collection('users').where("user_type", isEqualTo: "Woman").snapshots().map((snapshot) => snapshot.size);
      return collectionRef;
    } catch (e) {
      debugPrint('Error getting user collection count: $e');
      return Stream.value(-1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 15,
            title: const Text(
              "Registered Users",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(80.0),
              child: Column(
                children: <Widget>[
                  TabBar(
                    tabs: <Widget>[
                      Tab(
                        child: StreamBuilder<int>(
                          stream: totalCompaniesCount,
                          builder: (context, snapshot) {
                            return Text(
                              "Employers(${snapshot.data ?? 0})",
                            );
                          },
                        ),
                      ),
                      Tab(
                        child: StreamBuilder<int>(
                          stream: totalWomanCount,
                          builder: (context, snapshot) {
                            return Text(
                              "Job Seeker(${snapshot.data ?? 0})",
                            );
                          },
                        ),
                      ),
                    ],
                  ),
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
                ],
              ),
            ),

            */
/*TabBar(
              tabs: <Widget>[
                Tab(
                  child: StreamBuilder<int>(
                    stream: totalCompaniesCount,
                    builder: (context, snapshot) {
                      return Text(
                        "Employers(${snapshot.data ?? 0})",
                      );
                    },
                  ),
                ),
                Tab(
                  child: StreamBuilder<int>(
                    stream: totalWomanCount,
                    builder: (context, snapshot) {
                      return Text(
                        "Job Seeker(${snapshot.data ?? 0})",
                      );
                    },
                  ),
                ),
              ],
            ),*//*

          ),
        ),
        body: BackgroundTheme(
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    RegisteredCompanies(searchQuery: searchQuery,),
                    RegisteredWomens(searchQuery: searchQuery,),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laptopfyp/admin_side_screens/registered_companies.dart';
import 'package:laptopfyp/admin_side_screens/registered_womens.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';

class RegisteredUsers extends StatefulWidget {
  const RegisteredUsers({super.key});

  @override
  State<RegisteredUsers> createState() => _RegisteredUsersState();
}

class _RegisteredUsersState extends State<RegisteredUsers> {
  String searchQuery = "";

  Stream<int>? totalCompaniesCount;
  Stream<int>? totalWomanCount;

  @override
  void initState() {
    super.initState();
    totalCompaniesCount = getCompanyCollectionCount();
    totalWomanCount = getWomanCollectionCount();
  }

  Stream<int> getCompanyCollectionCount() {
    try {
      var collectionRef = FirebaseFirestore.instance
          .collection('company_verification_requests')
          .where("company_status", isEqualTo: "approved")
          .snapshots()
          .map((snapshot) => snapshot.size);
      return collectionRef;
    } catch (e) {
      debugPrint('Error getting company collection count: $e');
      return Stream.value(-1);
    }
  }

  Stream<int> getWomanCollectionCount() {
    try {
      var collectionRef = FirebaseFirestore.instance
          .collection('users')
          .where("user_type", isEqualTo: "Job Seeker")
          .snapshots()
          .map((snapshot) => snapshot.size);
      return collectionRef;
    } catch (e) {
      debugPrint('Error getting woman collection count: $e');
      return Stream.value(-1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180.0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 15,
            title: const Text(
              "Registered Users",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(80.0),
              child: Column(
                children: <Widget>[
                  TabBar(
                    tabs: <Widget>[
                      Tab(
                        child: StreamBuilder<int>(
                          stream: totalCompaniesCount,
                          builder: (context, snapshot) {
                            return Text(
                              "Employers(${snapshot.data ?? 0})",
                            );
                          },
                        ),
                      ),
                      Tab(
                        child: StreamBuilder<int>(
                          stream: totalWomanCount,
                          builder: (context, snapshot) {
                            return Text(
                              "Job Seeker(${snapshot.data ?? 0})",
                            );
                          },
                        ),
                      ),
                    ],
                  ),
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
                ],
              ),
            ),
          ),
        ),
        body: BackgroundTheme(
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    RegisteredCompanies(searchQuery: searchQuery),
                    RegisteredWomens(searchQuery: searchQuery),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
