import 'package:admin_ecom/ui/controller/homeController.dart';
import 'package:admin_ecom/ui/controller/ordersController.dart';
import 'package:admin_ecom/main.dart';
import 'package:admin_ecom/data/model/order/orderModel.dart';
import 'package:admin_ecom/ui/pallets/colors.dart';
import 'package:admin_ecom/ui/view/screens/addproductscreen.dart';
import 'package:admin_ecom/ui/view/screens/couponscree.dart';
import 'package:admin_ecom/ui/view/shimmers/recent_orders_shimmer.dart';
import 'package:admin_ecom/ui/view/widgets/dash/dashappbar.dart';
import 'package:admin_ecom/ui/view/widgets/dash/dashbutton.dart';
import 'package:admin_ecom/ui/view/widgets/dash/recentorder.dart';
import 'package:admin_ecom/ui/view/widgets/noOrdersWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final HomeController _homeController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homeController.fetchRecentOrders(false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<OrdersController>(
          builder: (controller) => GetBuilder<HomeController>(
            builder: (controller) => Column(
              children: [
                // APP BAR
                const DahboardAppBar(),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await controller.fetchRecentOrders(true);
                    },
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        width: size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            //Buttons
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  DashButton(
                                    color: AppColors.pramiryColor,
                                    icon: Icons.discount,
                                    onTap: () => Get.to(const CouponScreen()),
                                    text: 'Add coupon',
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  DashButton(
                                    color: Colors.green,
                                    icon: Icons.shopify,
                                    onTap: () =>
                                        Get.to(const AddProductScreen()),
                                    text: 'Add product',
                                  ),
                                ],
                              ),
                            ),

                            //RECENT ORDERS
                            const Padding(
                              padding: EdgeInsets.only(left: 25, top: 30),
                              child: Text(
                                'Recent Orders',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // ignore: prefer_const_constructors
                            controller.recentOrdersLoading
                                ? OrderShimmer()
                                : controller.recentOrders.isEmpty
                                    ? NoOrdersWidget()
                                    : Column(
                                        children: List.generate(
                                          controller.recentOrders.length,
                                          (index) {
                                            OrderModel order =
                                                controller.recentOrders[index];
                                            return RecentOrder(order: order);
                                          },
                                        ),
                                      ),
                            const SizedBox(
                              height: 30,
                            ),
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
      ),
    );
  }
}
