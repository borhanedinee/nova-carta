import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:customizable_counter/customizable_counter.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/dataa/models/productmodel.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/ui/controllers/favourites_controller.dart';
import 'package:ecommerce/ui/controllers/home_controller.dart';
import 'package:ecommerce/ui/controllers/product_controller.dart';
import 'package:ecommerce/ui/pallets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ItemScreen extends StatelessWidget {
  ItemScreen({super.key, required this.product});
  final ProducModel product;

  final HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<ProductController>(
          builder: (controller) => Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverAppBar(
                    actions: [
                      GetBuilder<FavoritesController>(
                        builder: (controller) =>  IconButton(
                          onPressed: () {
                            if (homeController.favouriteProductsIds
                                .contains(product.id)) {
                              controller.deleteProductFromFavourites(
                                  product.id, user!.id);
                              homeController.favouriteProductsIds
                                  .remove(product.id);
                            } else {
                              controller.addProductToFavourites(
                                  product.id, user!.id);
                              homeController.favouriteProductsIds
                                  .add(product.id);
                            }
                            controller.update();
                          },
                          icon: homeController.favouriteProductsIds
                                  .contains(product.id)
                              ? const Icon(
                                  Icons.favorite_rounded,
                                  color: Colors.red,
                                )
                              : const Icon(
                                  Ionicons.heart_outline,
                                ),
                        ),
                      )
                    ],
                    leading: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.navigate_before_rounded,
                      ),
                    ),
                    title: const Text(
                      'Product Details',
                      style: TextStyle(fontSize: 16),
                    ),
                    expandedHeight: 400,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Image.network(
                        '$ASSET_URL/${product.asset}',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  product.name,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  '${product.price.toInt()} DA',
                                  style: const TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w200,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Text('Description'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                product.description,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Text('Sizes'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Wrap(
                                spacing: 15,
                                runSpacing: 8,
                                children: List.generate(
                                  product.sizes!.length,
                                  (index) {
                                    String size = product.sizes![index];
                                    return GestureDetector(
                                      onTap: () {
                                        if (controller.selectedSize != size) {
                                          controller.selectedSize = size;
                                          controller.update();
                                        } else {
                                          controller.selectedSize = '';
                                          controller.update();
                                        }
                                      },
                                      child: FittedBox(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 8),
                                          decoration: BoxDecoration(
                                              color: controller.selectedSize ==
                                                      size
                                                  ? AppColors
                                                      .primaryColor.shade300
                                                  : Colors.transparent,
                                              border: Border.all(
                                                color: AppColors
                                                    .primaryColor.shade300,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            size,
                                            style: TextStyle(
                                              color: controller.selectedSize !=
                                                      size
                                                  ? AppColors
                                                      .primaryColor.shade300
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 30),
                              child: Text('Colors'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Wrap(
                                spacing: 15,
                                runSpacing: 8,
                                children: List.generate(
                                  product.colors!.length,
                                  (index) {
                                    String color = product.colors![index];
                                    return GestureDetector(
                                      onTap: () {
                                        if (controller.selectedColor != color) {
                                          controller.selectedColor = color;
                                          controller.update();
                                        } else {
                                          controller.selectedColor = '';
                                          controller.update();
                                        }
                                      },
                                      child: FittedBox(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15, vertical: 8),
                                          decoration: BoxDecoration(
                                              color: controller.selectedColor ==
                                                      color
                                                  ? AppColors
                                                      .primaryColor.shade300
                                                  : Colors.transparent,
                                              border: Border.all(
                                                color: AppColors
                                                    .primaryColor.shade300,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            color,
                                            style: TextStyle(
                                              color: controller.selectedColor !=
                                                      color
                                                  ? AppColors
                                                      .primaryColor.shade300
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 200,
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: FittedBox(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: size!.width,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor.shade50,
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomizableCounter(
                          //TODO: handle max count item.quantityInStock
                          //done
                          maxCount: double.parse(product.stock.toString()),
                          borderWidth: .7,
                          minCount: 1,
                          textSize: 18,
                          borderRadius: 10,
                          showButtonText: false,
                          count: controller.productQuantity.toDouble(),
                          decrementIcon: const Icon(
                            Ionicons.remove_outline,
                            size: 16,
                          ),
                          incrementIcon: const Icon(
                            Ionicons.add,
                            size: 16,
                          ),
                          onIncrement: (c) {
                            controller.productQuantity = c.toInt();
                          },
                          onDecrement: (c) {
                            controller.productQuantity = c.toInt();
                          },
                        ),
                        Container(
                          width: size!.width * .5,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.addItmeToCart(
                                  product.id,
                                  user!.id,
                                  controller.productQuantity,
                                  controller.selectedSize,
                                  controller.selectedColor);
                            },
                            style: const ButtonStyle(
                              elevation: MaterialStatePropertyAll(0),
                              backgroundColor: MaterialStatePropertyAll(
                                AppColors.primaryColor,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 10),
                                controller.isLoading
                                    ? const SizedBox(
                                        height: 10,
                                        width: 10,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        'Add to Cart',
                                        style: TextStyle(color: Colors.white),
                                      )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
