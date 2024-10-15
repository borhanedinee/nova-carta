// ignore_for_file: avoid_unnecessary_containers

import 'package:ecommerce/ui/view/pages/onboardingauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

class Language extends StatelessWidget {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/pics/logo2.png',
                      height: 300,
                    ))
                .animate()
                .slideY(
                    begin: -3,
                    end: 0,
                    curve: Curves.easeIn,
                    duration: Duration(milliseconds: 300)),
            Container(
              child: Column(
                children: [
                  Hero(
                    tag: 'here',
                    child: SizedBox(
                      width: 240,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.off(Auth());
                        },
                        style: ButtonStyle(
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 7)),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          backgroundColor: const MaterialStatePropertyAll(
                            Color.fromARGB(255, 59, 33, 105),
                          ),
                        ),
                        child: const Text(
                          'English',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Hero(
                    tag: 'here2',
                    child: SizedBox(
                      width: 240,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 7)),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          backgroundColor: const MaterialStatePropertyAll(
                            Color.fromARGB(255, 59, 33, 105),
                          ),
                        ),
                        child: const Text(
                          'Francais',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ).animate().slideY(
                  begin: 3,
                  end: 0,
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 300)),
            )
          ],
        ),
      ),
    );
  }
}
