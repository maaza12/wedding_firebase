import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:laptopfyp/admin_side_screens/approved_request.dart';
import 'package:laptopfyp/admin_side_screens/pending_request.dart';
import 'package:laptopfyp/admin_side_screens/rejected_request.dart';
import 'package:laptopfyp/helper_classes/background_theme.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 15,
          title: const Text(
            "All Requests",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          /*actions: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: InkWell(
                  onTap: () => showSignOutConfirmationDialog(context),

                  child: Icon(Icons.login_outlined)),
            )
          ],*/


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
                  children: [PendingRequest(), ApprovedRequest(), const RejectedRequest()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

