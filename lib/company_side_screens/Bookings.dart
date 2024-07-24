import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laptopfyp/company_side_screens/create_services.dart';
import 'package:laptopfyp/company_side_screens/job_post.dart';
import 'package:laptopfyp/company_side_screens/women_forms.dart';

class Bookings extends StatelessWidget {
  const Bookings({super.key});


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
            width: 300,
            child: InkWell(
                onTap: () {
                  Get.to(
                     WomenForms(bookingType: "hall",),
                  );
                },
                child: Container(

                  decoration: BoxDecoration(color: (const Color(0xFF405230)),borderRadius: BorderRadius.circular(20)),

                  child: const Center(
                    child: Text(
                      "Hall Bookings",
                      style: TextStyle(fontSize: 20,color: Colors.white),
                    ),
                  ),
                )),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 100,
            width: 300,
            child: InkWell(
                onTap: () {
                  Get.to(
                    WomenForms(bookingType: "Services",),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(color: (const Color(0xFF405230)),borderRadius: BorderRadius.circular(20)),

                  child: Center(
                    child: const Text(
                      "Services Bookings",
                      style: TextStyle(fontSize: 20,color:Colors.white),
                    ),
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
