import 'package:admin_ecom/ui/controller/homeController.dart';
import 'package:admin_ecom/main.dart';
import 'package:admin_ecom/data/model/order/orderModel.dart';
import 'package:admin_ecom/data/model/order/orderedProductsModel.dart';
import 'package:admin_ecom/ui/pallets/colors.dart';
import 'package:admin_ecom/services/formatDateTimes.dart';
import 'package:admin_ecom/ui/view/widgets/customappbar.dart';
import 'package:admin_ecom/ui/view/widgets/customheader.dart';
import 'package:admin_ecom/ui/view/widgets/orderdetails/productitem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsScreen extends StatelessWidget {
  final OrderModel order;
  final int totalPrice;
  const OrderDetailsScreen({
    super.key,
    required this.order,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<HomeController>(
          builder: (controller) => SizedBox(
            height: size.height,
            width: size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(title: 'Order details'),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomHeader(header: 'Ordered products'),
                  const SizedBox(
                    height: 10,
                  ),
                  ...List.generate(
                    order.products.length,
                    (index) {
                      OrderedProductModel product = order.products[index];
                      return ProductItem(
                        product: product,
                      );
                    },
                  ),
                  const CustomHeader(header: 'Details'),
                  FittedBox(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.indigo.withOpacity(0.2)),
                      child: Column(
                        children: [
                          DetailsInfo(
                            attribute: 'TOTAL :',
                            value: '$totalPrice DA',
                          ),
                          const Divider(),
                          DetailsInfo(
                            attribute: 'Phone :',
                            value: '0${order.phone}',
                          ),
                          DetailsInfo(
                            attribute: 'Delivery :',
                            value: order.location,
                          ),
                          DetailsInfo(
                            attribute: 'Delivery method :',
                            value: order.deliveryMethod,
                          ),
                          DetailsInfo(
                            attribute: 'Payment :',
                            value: order.paymentMethod,
                          ),
                          DetailsInfo(
                            attribute: 'Ordered at :',
                            value: formattedDateTime(order.orderedAt),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: (size.width - 40) * 0.48,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              backgroundColor: const MaterialStatePropertyAll(
                                  Colors.redAccent),
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: (size.width - 40) * 0.48,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                backgroundColor: const MaterialStatePropertyAll(
                                    AppColors.pramiryColor)),
                            onPressed: () {
                              controller.acceptOrder(
                                  order.orderInfoId, true);
                            },
                            child: controller.isStatusLabelLoading
                                ? const SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ))
                                : const Text(
                                    'Accept',
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DetailsInfo extends StatelessWidget {
  final String attribute;

  final String value;

  const DetailsInfo({
    super.key,
    required this.attribute,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          attribute,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
        SizedBox(
          width: (size.width - 30) * 0.5,
          child: Text(
            value,
            maxLines: 3,
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
