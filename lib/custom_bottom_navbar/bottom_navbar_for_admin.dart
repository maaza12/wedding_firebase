/*
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laptopfyp/admin_side_screens/admin_home_page.dart';
import 'package:laptopfyp/admin_side_screens/registered_users.dart';

class CustomBottomNavBarForAdmin extends StatefulWidget {
  const CustomBottomNavBarForAdmin({super.key});

  @override
  _CustomBottomNavBarForAdminState createState() => _CustomBottomNavBarForAdminState();
}

class _CustomBottomNavBarForAdminState extends State<CustomBottomNavBarForAdmin> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List page = [
    const AdminHomePage(),
    const RegisteredUsers(),
    // const ProfileSettings(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 45,
            items: const <Widget>[
              Icon(Icons.home, size: 30),
              Icon(
                Icons.ads_click_rounded,
                size: 30,
              ),
              // Icon(Icons.notifications, size: 30),
            ],
            color: Colors.white,
            buttonBackgroundColor: Colors.white,
            backgroundColor: Colors.black,
            animationCurve: Curves.easeInOut,
            animationDuration: const Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
            letIndexChange: (index) => true,
          ),
          body: page[_page]),
    );
  }
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
*/
