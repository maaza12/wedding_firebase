import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laptopfyp/company_side_screens/create_services.dart';
import 'package:laptopfyp/company_side_screens/job_post.dart';
import 'package:laptopfyp/company_side_screens/my_ads.dart';
import 'package:laptopfyp/company_side_screens/women_forms.dart';
import 'package:laptopfyp/women_side_screens/home_screen_for_women.dart';
import 'package:laptopfyp/women_side_screens/my_forms.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Weeding Planner Dulexe",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: InkWell(
                    onTap: () {
                      Get.to(HomeScreenForWomen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: (const Color(0xFF405230)),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          "Nikkah",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: InkWell(
                    onTap: () {
                      Get.to(HomeScreenForWomen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: (const Color(0xFF405230)),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          "Engagement",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: InkWell(
                    onTap: () {
                      Get.to(HomeScreenForWomen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          //image: DecorationImage(image: AssetImage("assets/socialpost.png")),
                          color: (const Color(0xFF405230)),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          "Bridle Shower",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: InkWell(
                    onTap: () {
                      Get.to(HomeScreenForWomen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: (const Color(0xFF405230)),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          "Mayon",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: InkWell(
                    onTap: () {
                      Get.to(HomeScreenForWomen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: (const Color(0xFF405230)),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          "Barat",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: 300,
                child: InkWell(
                    onTap: () {
                      Get.to(HomeScreenForWomen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: (const Color(0xFF405230)),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          "Mahandi",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
