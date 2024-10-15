import 'package:admin_ecom/ui/controller/ordersController.dart';
import 'package:admin_ecom/utils/extensions.dart';
import 'package:admin_ecom/ui/view/widgets/mainappbar.dart';
import 'package:admin_ecom/ui/view/widgets/orders/completedorders.dart';
import 'package:admin_ecom/ui/view/widgets/orders/inprogressorders.dart';
import 'package:admin_ecom/ui/view/widgets/orders/pendingorders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  OrdersController ordersController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    ordersController.fetchAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: Column(
            children: [
              const MainAppBar(
                title: 'Orders',
              ),
              SizedBox().h(10),
              GetBuilder<OrdersController>(
                builder: (controller) => Expanded(
                  child: RefreshIndicator(
                    
                    onRefresh: () async {
                      await controller.fetchAllOrders();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            child: Column(
                              children: [
                                TabBar(
                                  onTap: (value) {
                                    ordersController.fetchAllOrders();
                                    print('  cccc' +
                                        ordersController.inProgressOrders.length
                                            .toString());
                                    setState(() {});
                                  },
                                  controller: tabController,
                                  tabs: const [
                                    Tab(
                                      child: Row(children: [
                                        Icon(
                                          Icons.timelapse_sharp,
                                          size: 22,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Pending',
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ]),
                                    ),
                                    Tab(
                                      child: Row(children: [
                                        Icon(
                                          Icons.repeat_rounded,
                                          size: 22,
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          'In Progress',
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ]),
                                    ),
                                    Tab(
                                      child: Row(children: [
                                        Icon(
                                          Icons.done,
                                          size: 22,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          'Completed',
                                          style: TextStyle(fontSize: 12),
                                        )
                                      ]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          switch (tabController.index) {
                            0 => PendingOrders(
                                pendingOrders: ordersController.pendingOrders),
                            1 => InProgressOrders(
                                inProgressOrders:
                                    ordersController.inProgressOrders),
                            2 => CompletedOrders(
                                completedOrders:
                                    ordersController.completedOrders),
                            int() => Container(),
                          }
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
