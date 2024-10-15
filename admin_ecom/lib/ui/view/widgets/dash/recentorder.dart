import 'package:admin_ecom/constants.dart';
import 'package:admin_ecom/main.dart';
import 'package:admin_ecom/data/model/order/orderModel.dart';
import 'package:admin_ecom/services/formatDateTimes.dart';
import 'package:admin_ecom/ui/controller/ordersController.dart';
import 'package:admin_ecom/ui/view/screens/orderdetailsscreen.dart';
import 'package:admin_ecom/ui/view/widgets/buttonBasedOnStatus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentOrder extends StatelessWidget {
  final OrderModel order;

  double totalPrice = 0;

  RecentOrder({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    calculateTotalPrice();
    return GestureDetector(
      onTap: () {
        Get.to(
          OrderDetailsScreen(
            order: order,
            totalPrice: (totalPrice.toInt() * (1 - order.discount / 100)).toInt(),
          ),
        );
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
              width: (size.width - 22) * 0.25,
              color: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  //TODO: handel asset
                  '$PRODUCT_ASSET_BASE_URL/${order.products.last.productAsset}',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 5),
              height: 160 - 16,
              width: (size.width - 20) * 0.40,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.orderOwner,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delivery: ${order.location}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          'Phone: 0${order.phone}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          'Total Products: ${order.products.length}',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: (160 - 16) * 0.2,
                    child: Text(
                      order.discount.toInt() != 0
                          ? '${(totalPrice.toInt() * (1 - order.discount / 100)).toInt()} DA'
                          : '${totalPrice.toInt()} DA',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: 150,
                padding: const EdgeInsets.only(top: 10, bottom: 10, right: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formattedDateTime(order.orderedAt),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 14),
                    ),
                    UpdateOrderStatusButton(order: order)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  calculateTotalPrice() {
    for (var product in order.products) {
      totalPrice += product.productPrice * product.quantity;
    }
  }
}
