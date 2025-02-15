import 'package:admin_ecom/ui/controller/ordersController.dart';
import 'package:admin_ecom/data/model/order/orderModel.dart';
import 'package:admin_ecom/ui/view/shimmers/recent_orders_shimmer.dart';
import 'package:admin_ecom/ui/view/widgets/dash/recentorder.dart';
import 'package:admin_ecom/ui/view/widgets/noOrdersWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CompletedOrders extends StatelessWidget {
  final List<OrderModel> completedOrders;
  const CompletedOrders({super.key, required this.completedOrders});

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
              : controller.completedOrders.isEmpty
                  ? const NoOrdersWidget(
                      status: 'Completed',
                    )
                  : Column(
                      children: List.generate(completedOrders.length, (index) {
                        OrderModel order = completedOrders[index];
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
