import 'package:ecommerce/core/services/format_dates.dart';
import 'package:ecommerce/dataa/models/orderModel.dart';
import 'package:ecommerce/dataa/models/orderedProductsModel.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/ui/controllers/orders_controller.dart';
import 'package:ecommerce/ui/pallets/colors.dart';
import 'package:ecommerce/ui/view/components/order_details/productitem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
        body: GetBuilder<OrdersController>(
          builder: (controller) => SizedBox(
            height: size!.height,
            width: size!.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.navigate_before),
                        ),
                        const SizedBox(width: 30),
                        const Text(
                          'Order details',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                  const SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      width: size!.width,
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
                            // value: formattedDateTime(order.orderedAt),
                            value: formattedDateTime_YYYYMMDD_HHMM(order.orderedAt),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      width: (size!.width - 40),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          backgroundColor:
                              const MaterialStatePropertyAll(Colors.red),
                        ),
                        onPressed: () async{
                          bool navigateback;
                          controller.changeOrderId(order.orderInfoId);
                          navigateback = await controller.deleteOrder(true);
                         
                          if(navigateback){
                             print(' awlediii $navigateback');
                            Navigator.of(context).pop();
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
                            : const Text(
                                'Delete',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
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
          width: (size!.width - 30) * 0.5,
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
