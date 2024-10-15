import 'package:customizable_counter/customizable_counter.dart';
import 'package:ecommerce/constants.dart';
import 'package:ecommerce/core/services/dialogs/cart_dialogs.dart';
import 'package:ecommerce/dataa/models/cart_product_model.dart';
import 'package:ecommerce/dataa/models/productmodel.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/ui/controllers/cart_controller.dart';
import 'package:ecommerce/ui/pallets/colors.dart';
import 'package:ecommerce/ui/view/pages/home/itemscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class CartItemView extends StatefulWidget {
  final CartProductModel product;

  const CartItemView({
    super.key,
    required this.product,
  });

  @override
  State<CartItemView> createState() => _CartItemViewState();
}

class _CartItemViewState extends State<CartItemView>
    with SingleTickerProviderStateMixin {
  double count = 1;
  CartController cartController = Get.find();

  late AnimationController dragController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dragController = AnimationController.unbounded(
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = size!.width;
    return GetBuilder<CartController>(
      builder: (controller) => Padding(
        padding: const EdgeInsets.only(
          bottom: 10,
        ),
        child: SizedBox(
          height: 110,
          width: width - 20,
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: dragController,
                builder: (context, child) => dragController.value >= 0
                    ? Positioned(
                        width: dragController.value + 10,
                        left: 0,
                        bottom: 0,
                        top: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                            color: Colors.red,
                          ),
                          child: IconButton(
                            onPressed: () {
                              showDeletingSingleItemDialog(
                                context,
                                controller,
                                widget.product.product,
                                user!.id,
                              );

                              dragController.value = 0;
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      )
                    : Positioned(
                        width: (dragController.value * -1) + 10,
                        right: 0,
                        bottom: 0,
                        top: 0,
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            color: Colors.red,
                          ),
                          child: dragController.value.abs() > 15
                              ? SizedBox(
                                  child: IconButton(
                                    onPressed: () {
                                      showDeletingSingleItemDialog(
                                        context,
                                        controller,
                                        widget.product.product,
                                        user!.id,
                                      );

                                      dragController.value = 0;
                                    },
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              : null,
                        ),
                      ),
              ),
              AnimatedBuilder(
                animation: dragController,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(dragController.value, 0),
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) {
                        dragController.value += details.primaryDelta!;
                        print(dragController.value);
                      },
                      onHorizontalDragEnd: (details) {
                        if (dragController.value > 0) {
                          if (dragController.value < 80) {
                            dragController.value = 0;
                          } else {
                            dragController.value = 80;
                            controller.selectedSingleItemToBeDeleted =
                                widget.product.id;
                          }
                        } else {
                          if (dragController.value > -80) {
                            dragController.value = 0;
                          } else {
                            dragController.value = -80;
                            controller.selectedSingleItemToBeDeleted =
                                widget.product.id;
                          }
                        }
                      },
                      onTap: () {
                        Get.to(
                          ItemScreen(
                            product: widget.product,
                          ),
                        );
                      },
                      child: Container(
                        width: width - 20,
                        height: 110,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 110,
                              width: (width - 20) * .3,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                ),
                                child: Image.network(
                                  '$ASSET_URL/${widget.product.asset}',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              height: 110,
                              width: (width - 20) * .4,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.product.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    widget.product.description,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${widget.product.price.toInt()} DA',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        color: Colors.black,
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),

                            //Counter
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              height: 110,
                              width: (width - 20) * .3,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: CustomizableCounter(
                                      backgroundColor: AppColors.primaryColor
                                          .withOpacity(.1),
                                      maxCount: double.parse(
                                          widget.product.stock.toString()),
                                      borderWidth: 0.01,
                                      minCount: 1,
                                      textSize: 14,
                                      borderRadius: 10,
                                      showButtonText: false,
                                      count: widget.product.quantity.toDouble(),
                                      decrementIcon: const Icon(
                                        Ionicons.remove_outline,
                                        size: 16,
                                      ),
                                      incrementIcon: const Icon(
                                        Ionicons.add,
                                        size: 16,
                                      ),
                                      onIncrement: (c) {
                                        widget.product.quantity += 1;
                                        cartController.incrementProductQuantity(
                                            widget.product.id);
                                        cartController.updateTotalPrice();
                                        cartController.updateTotalCartItems();

                                        count = c;
                                        cartController.update();
                                      },
                                      onDecrement: (c) {
                                        widget.product.quantity -= 1;
                                        cartController.decrementProductQuantity(
                                            widget.product.id);

                                        cartController.updateTotalPrice();
                                        cartController.updateTotalCartItems();
                                        count = c;
                                        cartController.update();
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${widget.product.size}   |   ',
                                        // '${widget.product.price * count.toInt()} DA',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        widget.product.color,
                                        // '${widget.product.price * count.toInt()} DA',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
