import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laptopfyp/admin_side_screens/admin_home_page.dart'; // Import your AdminHomePage
import 'package:laptopfyp/admin_side_screens/registered_users.dart'; // Import your RegisteredUsers
import 'package:laptopfyp/helper_classes/signout_dialog_box.dart';
import 'package:responsive_config/responsive_config.dart';

class DashboardAdmin extends StatelessWidget {
  const DashboardAdmin({super.key});

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
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        backgroundColor: (const Color(0xFF405230)),
        extendBodyBehindAppBar: true,
        body: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(100)),
            Text(
              'Work Her Way',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
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
                                  Icons.logout,
                                  size: 60,
                                  color: (Color(0xFF405230)),
                                ),
                                SizedBox(height: 10),
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
