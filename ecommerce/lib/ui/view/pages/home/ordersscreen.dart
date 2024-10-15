import 'package:ecommerce/main.dart';
import 'package:ecommerce/ui/controllers/orders_controller.dart';
import 'package:ecommerce/ui/view/components/orders/no_order_widget.dart';
import 'package:ecommerce/ui/view/components/orders/order_item.dart';
import 'package:ecommerce/ui/view/shimmers/search_shimmers/order_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  OrdersController ordersController = Get.find();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    ordersController.fetchOrders(user!.id);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<OrdersController>(
        builder: (controller) => Scaffold(
          body: Column(
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
                      'My Orders',
                      style: TextStyle(fontSize: 18),
                    )
                  ],
                ),
              ),
              TabBar(
                onTap: (value) {
                  if (controller.allOrders.isEmpty) {
                    controller.fetchOrders(user!.id);
                  }
                },
                controller: tabController,
                tabs: const [
                  Tab(text: 'Pending'),
                  Tab(text: 'In Progress'),
                  Tab(text: 'Completed'),
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: const [
                    PendingOrdersTab(),
                    InProgressOrdersTab(),
                    CompletedOrdersTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PendingOrdersTab extends StatelessWidget {
  const PendingOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(
      builder: (controller) => controller.isFetchingOrdersLoading
          ? const OrderShimmer()
          : controller.pendingOrders.isEmpty
              ? const NoOrdersWidget(
                  status: 'Pending',
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        controller.fetchOrders(user!.id);
                      },
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text(
                                'Your orders will be on In Progress as soon as the admin accepts them.'),
                          ),
                          ...List.generate(
                            controller.pendingOrders.length,
                            (index) {
                              final order = controller.pendingOrders[index];
                              return OrdersOrderItem(order: order);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
    );
  }
}

class InProgressOrdersTab extends StatelessWidget {
  const InProgressOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(
      builder: (controller) => controller.isFetchingOrdersLoading
          ? const OrderShimmer()
          : controller.inProgressOrders.isEmpty
              ? const NoOrdersWidget(
                  status: 'In Progress',
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(children: [
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text(
                          'You can click on Delivered if you have received the order.'),
                    ),
                    ...List.generate(controller.inProgressOrders.length,
                        (index) {
                      final order = controller.inProgressOrders[index];
                      return OrdersOrderItem(order: order);
                    }),
                  ]),
                ),
    );
  }
}

class CompletedOrdersTab extends StatelessWidget {
  const CompletedOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(
      builder: (controller) => controller.isFetchingOrdersLoading
          ? const OrderShimmer()
          : controller.completedOrders.isEmpty
              ? const NoOrdersWidget(
                  status: 'completed',
                )
              : Column(
                  children:
                      List.generate(controller.completedOrders.length, (index) {
                    final order = controller.completedOrders[index];
                    return OrdersOrderItem(order: order);
                  }),
                ),
    );
  }
}
