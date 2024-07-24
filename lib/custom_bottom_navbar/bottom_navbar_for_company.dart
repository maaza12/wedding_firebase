import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laptopfyp/company_side_screens/Bookings.dart';
import 'package:laptopfyp/company_side_screens/job_post.dart';
import 'package:laptopfyp/company_side_screens/my_ads.dart';
import 'package:laptopfyp/company_side_screens/myhallsservices.dart';
import 'package:laptopfyp/company_side_screens/post_job_button_class.dart';
import 'package:laptopfyp/company_side_screens/women_forms.dart';
import 'package:laptopfyp/women_side_screens/profile_screen.dart';

class CustomBottomNavBarForCompany extends StatefulWidget {
  const CustomBottomNavBarForCompany({super.key});

  @override
  _CustomBottomNavBarForCompanyState createState() => _CustomBottomNavBarForCompanyState();
}

class _CustomBottomNavBarForCompanyState extends State<CustomBottomNavBarForCompany> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List page = [const PostJobButtonClass(), const MyHallsServices(), const Bookings(), const ProfileScreen()];

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
                CupertinoIcons.arrow_down_left_square_fill,
                size: 30,
              ),
              Icon(Icons.notifications, size: 30),
              Icon(Icons.person, size: 30),
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
