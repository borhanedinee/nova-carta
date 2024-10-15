import 'package:admin_ecom/ui/controller/ordersController.dart';
import 'package:admin_ecom/data/model/order/orderModel.dart';
import 'package:admin_ecom/ui/view/shimmers/recent_orders_shimmer.dart';
import 'package:admin_ecom/ui/view/widgets/dash/recentorder.dart';
import 'package:admin_ecom/ui/view/widgets/noOrdersWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendingOrders extends StatelessWidget {
  final List<OrderModel> pendingOrders;
  const PendingOrders({super.key, required this.pendingOrders});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(
      builder: (controller) => Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          controller.isLoading
              ? OrderShimmer()
              : controller.pendingOrders.isEmpty
                  ? const NoOrdersWidget(
                      status: 'Pending',
                    )
                  : Column(
                      children: List.generate(pendingOrders.length, (index) {
                        OrderModel order = pendingOrders[index];
                        return RecentOrder(
                          order: order,
                        );
                      }),
                    )
        ],
      ),
    );
  }
}
