
import 'package:ecommerce/ui/pallets/colors.dart';
import 'package:ecommerce/ui/view/pages/home/searchscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeStack extends StatelessWidget {
  const HomeStack({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Image.asset(
            'assets/pics/khzana.png',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: double.infinity,
          decoration:  BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primaryColor.withOpacity(.8), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        const Positioned(
          left: 40,
          bottom: 70,
          child: Text(
            'Discover, click, and \nshop your way to \nhappiness!',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 24,
                letterSpacing: 1,
                wordSpacing: 2),
          ),
        ),
        Positioned(
          right: 30,
          bottom: 30,
          child: ElevatedButton(
            style: ButtonStyle(
                shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            )),
            onPressed: () {
              Get.to(const SearchScreen());
            },
            child: const Text(
              'SHOP NOW',
              style: TextStyle(
                  color: Color.fromARGB(255, 2, 87, 157),
                  fontWeight: FontWeight.w800),
            ),
          ),
        )
      ],
    );
  }
}
