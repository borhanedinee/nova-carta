import 'package:ecommerce/dataa/models/categorie_model.dart';
import 'package:ecommerce/ui/controllers/home_controller.dart';
import 'package:ecommerce/ui/view/pages/home/categoryscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrollCategories extends StatelessWidget {
  const ScrollCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            controller.categoriesList.length,
            (index) {
              CategoryModel cat = controller.categoriesList[index];
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print(cat.id);
                      Get.to(() => CategoryScreen(cat));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 80,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(50)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            cat.icon,
                            fit: BoxFit.contain,
                          )),
                    ),
                  ),
                  Text(
                    cat.label,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  )
                ],
              );
            },
          )),
    );
  }
}
