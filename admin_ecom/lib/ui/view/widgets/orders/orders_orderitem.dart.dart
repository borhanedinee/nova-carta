import 'package:admin_ecom/constants.dart';
import 'package:admin_ecom/main.dart';
import 'package:admin_ecom/data/model/order/orderModel.dart';
import 'package:admin_ecom/ui/pallets/colors.dart';
import 'package:admin_ecom/ui/view/screens/orderdetailsscreen.dart';
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
    return GestureDetector(
      onTap: () => Get.to(OrderDetailsScreen(
        order: order,
        totalPrice: totalPrice.toInt(),
      )),
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
                  '$PRODUCT_ASSET_BASE_URL/product-1720715979690-659490960fileephoto_12_2024-07-05_15-09-39.jpg',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              height: 160 - 16,
              width: (size.width - 20) * 0.40,
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
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          'Phone: 0${order.phone}',
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
              width: (size.width - 20) * 0.23,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    order.orderedAt.toString(),
                    style: const TextStyle(
                        fontWeight: FontWeight.w900, fontSize: 16),
                  ),
                  Container(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          backgroundColor: const MaterialStatePropertyAll(
                              AppColors.pramiryColor)),
                      onPressed: () {},
                      child: const Text(
                        'Accept',
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  )
                ],
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
