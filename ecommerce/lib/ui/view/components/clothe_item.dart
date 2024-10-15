import 'package:ecommerce/constants.dart';
import 'package:ecommerce/dataa/models/productmodel.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/ui/controllers/favourites_controller.dart';
import 'package:ecommerce/ui/controllers/home_controller.dart';
import 'package:ecommerce/ui/view/pages/home/itemscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ClotheItem extends StatefulWidget {
  final ProducModel product;

  const ClotheItem({
    super.key,
    required this.product,
  });

  @override
  State<ClotheItem> createState() => _ClotheItemState();
}

class _ClotheItemState extends State<ClotheItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ItemScreen(product: widget.product)),
      child: GetBuilder<FavoritesController>(
        builder: (controller) => FittedBox(
          child: Container(
            height: 310,
            width: 180,
            margin: const EdgeInsets.only(left: 1, right: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 310 * 0.57,
                  width: 200,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: Image.network(
                      '$ASSET_URL/${widget.product.asset}',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 8, left: 8, right: 8),
                  height: 310 * 0.43,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                      Text(
                        widget.product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                            color: Colors.grey),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.product.price.toInt()} DA',
                            style: const TextStyle(
                              fontWeight: FontWeight.w300,
                              fontSize: 20,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                if (homeController.favouriteProductsIds
                                    .contains(widget.product.id)) {
                                  controller.deleteProductFromFavourites(
                                      widget.product.id, user!.id);
                                  homeController.favouriteProductsIds
                                      .remove(widget.product.id);
                                } else {
                                  controller.addProductToFavourites(
                                      widget.product.id, user!.id);
                                  homeController.favouriteProductsIds
                                      .add(widget.product.id);
                                }
                                controller.update();
                              },
                              icon: homeController.favouriteProductsIds
                                      .contains(widget.product.id)
                                  ? Icon(
                                      Ionicons.heart_sharp,
                                      color: Colors.red,
                                    )
                                  : Icon(Ionicons.heart_outline))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
