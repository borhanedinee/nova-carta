import 'package:ecommerce/dataa/models/categorie_model.dart';
import 'package:ecommerce/ui/controllers/category_controller.dart';
import 'package:ecommerce/ui/pallets/colors.dart';
import 'package:ecommerce/ui/view/components/emptystock.dart';
import 'package:ecommerce/ui/view/components/clothe_item.dart';
import 'package:ecommerce/ui/view/shimmers/home_shimmers/discoveritems_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen(this.category, {super.key});

  final CategoryModel category;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryController categoryController = Get.find();

  @override
  initState() {
    super.initState();
    categoryController.selectedType = 'feetwear';
    categoryController.fetchProductTypes();
    // we assigned the teype id statically
    categoryController.fetchProducts(widget.category.id, categoryController.typeToSearch);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: GetBuilder<CategoryController>(
        builder: (controller) => SizedBox(
          width: MediaQuery.of(context).size.width,
          child: RefreshIndicator(
            onRefresh: () async{
              await controller.fetchProducts(widget.category.id, controller.typeToSearch);
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 10),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.navigate_before,
                            size: 30,
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: Center(
                            child: Text(
                              widget.category.label,
                              style: const TextStyle(
                                fontSize: 17,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //Product types
                  controller.isFetchingTypesLoading
                      ? SizedBox(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(6, (index) {
                                return FittedBox(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    height: 30,
                                    width: 120,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color:
                                            AppColors.primaryColor.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(10)),
                                  ),
                                );
                              }),
                            ),
                          ),
                        )
                      : SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                List.generate(controller.types.length, (index) {
                              var type = controller.types[index];
                              return GestureDetector(
                                onTap: () {
                                  controller.updateSelectedType(type.type);
                                  controller.fetchProducts(
                                      widget.category.id, type.id);
                                },
                                child: FittedBox(
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: controller.selectedType ==
                                                type.type
                                            ? AppColors.primaryColor.withOpacity(.5)
                                            : AppColors.primaryColor
                                                .withOpacity(.1),
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Text(
                                      type.type,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: controller.isFetchingProductsLoading
                        ? DiscoverItemsShimmer(needPading: false,)
                        : controller.products.isEmpty
                            ? EmptyStock()
                            : Expanded(
                                child: GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    childAspectRatio: 1 / 1.6,
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5
                                  ),
                                  itemCount: controller.products.length,
                                  itemBuilder: (context, index) {
                                    final product = controller.products[index];
                                    return ClotheItem(
                                      product: product,
                                    );
                                  },
                                ),
                              ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
