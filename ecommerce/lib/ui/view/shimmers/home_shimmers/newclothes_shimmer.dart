import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NewClotheShimmer extends StatelessWidget {
  const NewClotheShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: [
            ...List.generate(
              5,
              (index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 310,
                      width: 180,
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
