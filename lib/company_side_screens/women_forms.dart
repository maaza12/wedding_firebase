import 'package:flutter/material.dart';
import 'package:laptopfyp/company_side_screens/women_approved_forms.dart';
import 'package:laptopfyp/company_side_screens/women_pending_forms.dart';
import 'package:laptopfyp/company_side_screens/women_rejected_forms.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';
import 'package:laptopfyp/helper_classes/signout_dialog_box.dart';

class WomenForms extends StatelessWidget {
  String? bookingType;

  WomenForms({super.key, this.bookingType});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:(Color(0xFF405230)),
          elevation: 1,
          title: Text(
            bookingType == "hall" ? "Halls Bookings" : "Services Booking",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,

          /*actions: [
            IconButton(
              onPressed: () => showSignOutConfirmationDialog(context),
              icon: const Icon(Icons.logout),
            )
          ],*/
          bottom: const TabBar(
            dividerColor: Colors.white,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
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
                    WomenPendingForms(
                      bookingType: bookingType!,
                    ),
                    WomenApprovedForms(
                      bookingType: bookingType!,
                    ),
                    WomenRejectedForms(
                      bookingType: bookingType!,
                    ),
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
