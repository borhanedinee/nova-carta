import 'package:ecommerce/ui/controllers/home_controller.dart';
import 'package:ecommerce/ui/view/components/clothe_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoverItems extends StatelessWidget {
  DiscoverItems({
    super.key,
  });

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1 / 1.6,
          crossAxisCount: 2,
          mainAxisSpacing: 8,
        ),
        itemCount: controller.newClothesList.length,
        itemBuilder: (context, index) {
          final shuffledList = controller.newClothesList;
          shuffledList.shuffle();
          final product = shuffledList[index];
          return ClotheItem(
            product: product,
          );
        },
      ),
    );
  }
}
