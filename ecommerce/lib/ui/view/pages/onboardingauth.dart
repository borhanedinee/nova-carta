import 'package:ecommerce/ui/pallets/colors.dart';
import 'package:ecommerce/ui/view/pages/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

import 'auth/signup.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 80),
        child: Column(
          children: [
            Hero(
              tag: 'logo',
              child: Image.asset(
                'assets/pics/logo2.png',
                fit: BoxFit.cover,
              ),
            ).animate().slideY(
                begin: -3,
                end: 0,
                curve: Curves.easeIn,
                duration: Duration(milliseconds: 700)),
            const SizedBox(
              height: 10,
            ),
            Image.asset('assets/pics/pc.png' , height: 180,),
            const Text(
              'Welcome to Nova CARTA',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Discover a world of endless \n possibilities in shopping right \nat your fingertips',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
            ),
            const SizedBox(
              height: 50,
            ),
            Hero(
              tag: 'login',
              child: SizedBox(
                width: 240,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(Login());
                  },
                  style: ButtonStyle(
                      elevation: MaterialStatePropertyAll(2),
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 30, vertical: 7)),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      backgroundColor: const MaterialStatePropertyAll(
                        AppColors.primaryColor,
                      )),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
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
                  onPressed: () {
                    Get.to(Signup());
                  },
                  style: ButtonStyle(
                      elevation: MaterialStatePropertyAll(2),
                      padding: const MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 30, vertical: 7)),
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      backgroundColor: const MaterialStatePropertyAll(
                        AppColors.primaryColor,
                      )),
                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
