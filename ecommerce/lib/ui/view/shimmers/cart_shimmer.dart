import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CartShimmer extends StatelessWidget {
  const CartShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.all(6),
          child: const Text('Products you added to the cart'),
        ),
        const SizedBox(height: 16),
        Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade300,
          child: SizedBox(
            width: size!.width,
            child: Column(
              children: [
                shimmering(110),
                SizedBox(
                  height: 15,
                ),
                shimmering(70),
                SizedBox(
                  height: 15,
                ),
                shimmering(130),
                SizedBox(
                  height: 15,
                ),
                shimmering(90),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Container shimmering(double height) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
    );
  }
}
