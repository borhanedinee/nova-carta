
import 'package:ecommerce/ui/pallets/colors.dart';
import 'package:ecommerce/ui/view/pages/onboardingauth.dart';
import 'package:ecommerce/ui/view/pages/onboardinglanguage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 230, bottom: 140),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: 'logo',
              child: Image.asset('assets/pics/logo2.png')).animate().slideY( duration: Duration(milliseconds: 300),begin: -3 , end: 0 , curve: Curves.easeIn),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Get.off( Auth());
                },
                style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 40, vertical: 7)),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    backgroundColor:
                        const MaterialStatePropertyAll(AppColors.primaryColor)),
                child: const Text(
                  'Get Started',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w300
                  ),
                ),
              ),
            ).animate().slideY(begin: 3 , end: 0 , duration: Duration(milliseconds: 300) , curve: Curves.easeIn),
          ],
        ),
      ),
    );
  }
}
