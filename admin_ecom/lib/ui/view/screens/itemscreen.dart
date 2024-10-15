import 'package:admin_ecom/constants.dart';
import 'package:admin_ecom/data/model/productmodel.dart';
import 'package:admin_ecom/main.dart';
import 'package:admin_ecom/ui/controller/productController..dart';
import 'package:admin_ecom/ui/pallets/colors.dart';
import 'package:admin_ecom/ui/view/screens/editproductscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemScreen extends StatelessWidget {
  const ItemScreen({super.key, required this.product});
  final ProducModel product;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          label: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w300
                  ),
                ),
                SizedBox(width: 15),
                Icon(
                  Icons.mode_edit_outlined,
                  color: Colors.white,
                  size: 14,
                )
              ],
            ),
          ),
          onPressed: () {
            Get.to(()=>EditProductScreen(product: product,));
          },
          backgroundColor: AppColors.pramiryColor,
        ),
        body: GetBuilder<ProductController>(
          builder: (controller) => CustomScrollView(
            slivers: [
              SliverAppBar(
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
                    '$PRODUCT_ASSET_BASE_URL/${product.asset}',
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
                                  onTap: () {},
                                  child: FittedBox(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                            color: AppColors.pramiryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        size,
                                        style: TextStyle(
                                            color: AppColors.pramiryColor),
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
                                  onTap: () {},
                                  child: FittedBox(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 8),
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          border: Border.all(
                                            color: AppColors.pramiryColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        color,
                                        style: TextStyle(
                                            color: AppColors.pramiryColor),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
