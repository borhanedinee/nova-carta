import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 30,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/pics/emptycart.png',
                height: 150,
              ),
              SizedBox(
                width: 30,
              )
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          const Text(
            'Your cart is empty. \nAdd products to your cart \nand order now. ',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.black26,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
