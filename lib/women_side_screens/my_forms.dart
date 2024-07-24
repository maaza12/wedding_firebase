import 'package:flutter/material.dart';
import 'package:laptopfyp/company_side_screens/women_approved_forms.dart';
import 'package:laptopfyp/company_side_screens/women_pending_forms.dart';
import 'package:laptopfyp/company_side_screens/women_rejected_forms.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:laptopfyp/helper_classes/signout_dialog_box.dart';
import 'package:laptopfyp/women_side_screens/MyRejectedForms.dart';
import 'package:laptopfyp/women_side_screens/my_approved_forms.dart';
import 'package:laptopfyp/women_side_screens/my_pending_forms.dart';

class MyForms extends StatelessWidget {
  String? type;

  MyForms({super.key, this.type});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            type == "hall" ? "My Hall Bookings" : "My Services Booking",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                text: "Pending",
              ),
              Tab(
                text: "Approved",
              ),
              Tab(
                text: "Rejected",
              ),
            ],
          ),
        ),
        body: BackgroundTheme(
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    MyPendingForms(
                      type: type!,
                    ),
                    MyApprovedForms( type: type!,),
                     MyRejectedForms(
                      type: type!,

                    )
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
