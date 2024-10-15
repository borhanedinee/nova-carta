import 'package:ecommerce/constants.dart';
import 'package:ecommerce/core/services/format_dates.dart';
import 'package:ecommerce/dataa/models/orderModel.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/ui/controllers/orders_controller.dart';
import 'package:ecommerce/ui/pallets/colors.dart';
import 'package:ecommerce/ui/view/pages/home/orderdetailsscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class OrdersOrderItem extends StatelessWidget {
  final OrderModel order;

  double totalPrice = 0;

  OrdersOrderItem({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    calculateTotalPrice();
    return GetBuilder<OrdersController>(
      builder: (controller) => GestureDetector(
        onTap: () {
          Get.to(OrderDetailsScreen(
            order: order,
            totalPrice: totalPrice.toInt(),
          ));
        },
        child: Container(
          height: 160,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              //image
              Container(
                margin: const EdgeInsets.all(4),
                height: 160,
                width: (size!.width - 22) * 0.26,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    //TODO: handel asset
                    '$ASSET_URL/${order.products.first.productAsset}',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 5),
                height: 160 - 16,
                width: (size!.width - 20) * 0.40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: (160 - 16) * 0.18,
                      child: Text(
                        order.orderOwner,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: (160 - 16) * 0.55,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Delivery: ${order.location}',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            'Phone: 0${order.phone}',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                          Text(
                            'Total Products: ${order.products.length}',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: (160 - 16) * 0.2,
                      child: Text(
                        '${totalPrice.toInt()} DA',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 150,
                padding: const EdgeInsets.only(top: 10, bottom: 10, right: 2),
                width: (size!.width - 20) * 0.23,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formattedDateTime_YYYYMMDD_HHMM(order.orderedAt),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 14),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        backgroundColor: MaterialStatePropertyAll(
                          generateButtonColor(),
                        ),
                      ),
                      onPressed: () {
                        if (generateButtonChild().toLowerCase() == 'cancel') {
                          // delete the order
                          controller.changeOrderId(order.orderInfoId);
                          controller.deleteOrder(false);
                        } else {
                          if (generateButtonChild().toLowerCase() == 'delivered') {
                          controller.updateOrderStatusTo(order.orderInfoId, 'completed');
                            
                          } else {
                          controller.updateOrderStatusTo(order.orderInfoId, 'deleted');

                          }
                        }
                      },
                      child: order.orderInfoId == controller.selectedOrderId
                          ? const SizedBox(
                              height: 10,
                              width: 10,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              generateButtonChild(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 10),
                            ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String generateButtonChild() {
    // TODO: implement logic for generating button child based on order status
    if (order.status.toLowerCase() == 'pending') {
      return 'Cancel';
    } else if (order.status.toLowerCase() == 'inprogress') {
      return 'Delivered';
    } else if (order.status.toLowerCase() == 'completed') {
      return 'Delete';
    } else {
      return '';
    }
  }

  generateButtonColor() {
    // TODO: implement logic for generating button child based on order status
    if (order.status.toLowerCase() == 'inprogress') {
      return AppColors.primaryColor;
    } else {
      return Colors.red;
    }
  }

  calculateTotalPrice() {
    for (var product in order.products) {
      totalPrice += product.productPrice * product.quantity;
    }
  }
}
