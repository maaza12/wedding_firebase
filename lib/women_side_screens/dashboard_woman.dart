/*
import 'package:flutter/material.dart';
import 'package:laptopfyp/admin_side_screens/admin_home_page.dart'; // Import your AdminHomePage
import 'package:laptopfyp/admin_side_screens/registered_users.dart'; // Import your RegisteredUsers
import 'package:laptopfyp/helper_classes/signout_dialog_box.dart';

class DashboardCompany extends StatelessWidget {
  const DashboardCompany({super.key});

  void navigateToAdminHomePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdminHomePage()),
    );
  }

  void navigateToRegisteredUsers(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisteredUsers()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (Color(0xFF405230)),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          const SizedBox(height: 100),
          Text(
            'Work Her Way',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(top: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                color: Colors.white,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 300,
                      height: 120,
                      child: GestureDetector(
                        onTap: () => navigateToAdminHomePage(context),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 5),
                                color: (Color(0xFF405230)),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.assignment,
                                size: 60,
                                color: (Color(0xFF405230)),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                  'All Employer Requests',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 300,
                      height: 120,
                      child: GestureDetector(
                        onTap: () => navigateToRegisteredUsers(context),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 5),
                                color: (Color(0xFF405230)),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                size: 60,
                                color: (Color(0xFF405230)),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Registered Users',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: 300,
                      height: 120,
                      child: GestureDetector(
                        onTap: () => showSignOutConfirmationDialog(context),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 5),
                                color: (Color(0xFF405230)),
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.logout,
                                size: 60,
                                color: (Color(0xFF405230)),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Log out',
                                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laptopfyp/admin_side_screens/admin_home_page.dart'; // Import your AdminHomePage
import 'package:laptopfyp/admin_side_screens/registered_users.dart'; // Import your RegisteredUsers
import 'package:laptopfyp/company_side_screens/job_post.dart';
import 'package:laptopfyp/company_side_screens/my_ads.dart';
import 'package:laptopfyp/company_side_screens/women_forms.dart';
import 'package:laptopfyp/helper_classes/signout_dialog_box.dart';
import 'package:laptopfyp/women_side_screens/home_screen_for_women.dart';
import 'package:laptopfyp/women_side_screens/my_forms.dart';
import 'package:laptopfyp/women_side_screens/my_pending_forms.dart';
import 'package:laptopfyp/women_side_screens/profile_screen.dart';

class DashboardWoman extends StatelessWidget {
  const DashboardWoman({super.key});

  void navigateToHomeScreenForWomen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomeScreenForWomen()),
    );
  }

  void navigateToMyForms(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyForms()),
    );
  }

  void navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        backgroundColor: (const Color(0xFF405230)),
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            const SizedBox(height: 100),
            Text(
              'Job Seeker Dashboard ',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 20),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                      // bottomLeft: Radius.circular(50),
                      //bottomRight: Radius.circular(50)
                    ),
                    color: Colors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: 300,
                            height: 120,
                            child: GestureDetector(
                              onTap: () => navigateToHomeScreenForWomen(context),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 5),
                                      color: (Color(0xFF405230)),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.assignment,
                                      size: 60,
                                      color: (Color(0xFF405230)),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Find Your Dream Job ',
                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: 300,
                            height: 120,
                            child: GestureDetector(
                              onTap: () => navigateToMyForms(context),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 5),
                                      color: (Color(0xFF405230)),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.upload,
                                      size: 60,
                                      color: (Color(0xFF405230)),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'My Forms',
                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SizedBox(
                            width: 300,
                            height: 120,
                            child: GestureDetector(
                              onTap: () => navigateToProfile(context),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 5),
                                      color: (Color(0xFF405230)),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                    ),
                                  ],
                                ),
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 60,
                                      color: (Color(0xFF405230)),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Profile',
                                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: 400,
                height: 70,
                child: GestureDetector(
                  onTap: () => showSignOutConfirmationDialog(context),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          offset: Offset(0, 5),
                          color: (Color(0xFF405230)),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Log out  ',
                              style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.logout,
                              size: 30,
                              color: (Color(0xFF405230)),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to exit the App?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => SystemNavigator.pop(),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
