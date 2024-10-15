import 'package:admin_ecom/ui/controller/stockController.dart';
import 'package:admin_ecom/utils/extensions.dart';
import 'package:admin_ecom/ui/view/widgets/mainappbar.dart';
import 'package:admin_ecom/ui/view/widgets/stock/kidstab.dart';
import 'package:admin_ecom/ui/view/widgets/stock/mentab.dart';
import 'package:admin_ecom/ui/view/widgets/stock/womentab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  StockController stockController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    stockController.fetchMenProducts(false);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<StockController>(
          builder: (controller) => Column(
            children: [
              const MainAppBar(
                title: 'Stock',
              ),
              SizedBox().h(10),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 10, top: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: TextFormField(
                    controller: controller.searchFieldController,
                    onChanged: (value) {
                      if (tabController.index == 0) {
                        if (value == '') {
                          controller.fetchMenProducts(true);
                          return;
                        }
                        controller.fetchSearchedProducts('men', value);
                      }
                      if (tabController.index == 1) {
                        if (value == '') {
                          controller.fetchWomenenProducts(true);
                          return;
                        }
                        controller.fetchSearchedProducts('women', value);
                      }
                      if (tabController.index == 2) {
                        if (value == '') {
                          controller.fetchKidsProducts(true);
                          return;
                        }
                        controller.fetchSearchedProducts('kids', value);
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      fillColor: Colors.grey.shade200,
                      hintText: 'Search for a product',
                      hintStyle: const TextStyle(color: Colors.grey),
                      filled: true,
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      if (tabController.index == 0) {
                        return await controller.fetchMenProducts(true);
                      } else if (tabController.index == 1) {
                        return await controller.fetchWomenenProducts(true);
                      } else if (tabController.index == 2) {
                        return await controller.fetchWomenenProducts(true);
                      }
                    },
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              TabBar(
                                onTap: (value) {
                                  
                                  if (value == 0 &&
                                      controller.searchFieldController.text ==
                                          '') {
                                    controller.fetchMenProducts(false);
                                  }
                                  if (value == 1 &&
                                      controller.searchFieldController.text ==
                                          '') {
                                    controller.fetchWomenenProducts(false);
                                  }
                                  if (value == 2 &&
                                      controller.searchFieldController.text ==
                                          '') {
                                    controller.fetchKidsProducts(false);
                                  }

                                  controller.update();
                                },
                                controller: tabController,
                                tabs: const [
                                  Tab(
                                    text: 'Men',
                                  ),
                                  Tab(
                                    text: 'Women',
                                  ),
                                  Tab(
                                    text: 'Kids',
                                  ),
                                ],
                              ),
                            ],
                          ),
                          switch (tabController.index) {
                            0 => const MenTab(),
                            1 => const WomenTab(),
                            2 => const KidsTab(),
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
