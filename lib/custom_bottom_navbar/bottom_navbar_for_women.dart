import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:laptopfyp/company_side_screens/create_services.dart';
import 'package:laptopfyp/women_side_screens/Categories.dart';
import 'package:laptopfyp/women_side_screens/MyhallsSerivesUSer.dart';
import 'package:laptopfyp/women_side_screens/all_services.dart';
import 'package:laptopfyp/women_side_screens/home_screen_for_women.dart';
import 'package:laptopfyp/women_side_screens/my_forms.dart';
import 'package:laptopfyp/women_side_screens/profile_screen.dart';

class CustomBottomNavBarForWomen extends StatefulWidget {
  const CustomBottomNavBarForWomen({super.key});

  @override
  _CustomBottomNavBarForWomenState createState() => _CustomBottomNavBarForWomenState();
}

class _CustomBottomNavBarForWomenState extends State<CustomBottomNavBarForWomen> {
  int _page = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  final List<Widget> page = [
    Categories(),
    const AllServices(),
    // const ProfileSettings(),
    const MyHallsServicesUSer(),

    const ProfileScreen(),
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
            Icon(Icons.home, size: 30,color: Color(0xFF405230),),
            Icon(Icons.segment_rounded, size: 30,color: Color(0xFF405230),),
            Icon(Icons.notifications, size: 30,color: Color(0xFF405230),),
            Icon(Icons.person, size: 30,color: Color(0xFF405230),),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: const Color(0xFF405230),

          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: page[_page],
      ),
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
