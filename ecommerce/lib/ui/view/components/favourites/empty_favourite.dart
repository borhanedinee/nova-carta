import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';

class EmptyFavourite extends StatelessWidget {
  const EmptyFavourite({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            const SizedBox(height: 100,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/pics/emptycart.png',
                  height: 180,
                ),
                SizedBox(width: 30,)
              ],
            ),
            SizedBox(height: 50,),
            const Text(
              'Your favorites list is empty.',
              textAlign: TextAlign.center,
              style:  TextStyle(
                fontSize: 18,
                color: Colors.black26,
                fontWeight: FontWeight.w300),
            ),
          ],
        ));
  }
}
