import 'package:ecommerce/constants.dart';
import 'package:ecommerce/dataa/models/productmodel.dart';
import 'package:ecommerce/ui/controllers/home_controller.dart';
import 'package:ecommerce/ui/view/components/clothe_item.dart';
import 'package:ecommerce/ui/view/pages/home/itemscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewClothes extends StatelessWidget {
  NewClothes({
    super.key,
  });

  final HomeController controller = Get.find();

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
              controller.newClothesList.take(7).length,
              (index) {
                final product = controller.newClothesList[index];
                return ClotheItem(

                  product: product);
              },
            )
          ],
        ),
      ),
    );
  }
}
