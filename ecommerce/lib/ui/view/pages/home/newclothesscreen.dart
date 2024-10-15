import 'package:ecommerce/dataa/models/productmodel.dart';
import 'package:ecommerce/ui/controllers/home_controller.dart';
import 'package:ecommerce/ui/view/components/clothe_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewClothesScreen extends StatelessWidget {
  NewClothesScreen({super.key, required this.newClothes});

  final List<ProducModel> newClothes ; 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.navigate_before),
                    ),
                    const SizedBox(width: 30),
                    const Text(
                      'NewClothes',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
          
              // ITEMS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 1 / 1.6,
                      crossAxisCount: 2,
                      mainAxisSpacing: 5),
                  itemCount: newClothes.length,
                  itemBuilder: (context, index) {
                    final product = newClothes[index];
                    return ClotheItem(
                      product: product,
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
