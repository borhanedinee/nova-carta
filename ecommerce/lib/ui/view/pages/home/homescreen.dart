import 'package:ecommerce/main.dart';
import 'package:ecommerce/ui/controllers/home_controller.dart';
import 'package:ecommerce/ui/pallets/colors.dart';
import 'package:ecommerce/ui/view/components/clothe_item.dart';
import 'package:ecommerce/ui/view/components/home/discoveritems.dart';
import 'package:ecommerce/ui/view/components/home/newclothes.dart';
import 'package:ecommerce/ui/view/components/home/homecategories.dart';
import 'package:ecommerce/ui/view/components/home/searchbar.dart';
import 'package:ecommerce/ui/view/components/home/homestack.dart';
import 'package:ecommerce/ui/view/pages/home/newclothesscreen.dart';
import 'package:ecommerce/ui/view/pages/home/ordersscreen.dart';
import 'package:ecommerce/ui/view/shimmers/home_shimmers/categories_shimmer.dart';
import 'package:ecommerce/ui/view/shimmers/home_shimmers/discoveritems_shimmer.dart';
import 'package:ecommerce/ui/view/shimmers/home_shimmers/newclothes_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import 'searchscreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.find();
  @override
  initState() {
    super.initState();
    homeController.fetchNewClothes();
    homeController.fetchCategories();
    homeController.fetchProductsToFavourites(user!.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<HomeController>(
          builder: (controller) => CustomScrollView(
            slivers: [
              SliverAppBar(
                leading: IconButton(
                  onPressed: () {
                    Get.to(
                      () => const OrdersScreen(),
                    );
                  },
                  icon: const Icon(Ionicons.bag_check),
                ),
                actions: [
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Ionicons.notifications,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          print('notification');
                        },
                      ),
                      const Positioned(
                        top: 10,
                        right: 10,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            '0',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
                backgroundColor: AppColors.primaryColor.withOpacity(.8),
                pinned: true,
                expandedHeight: 280,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                  title: HomeSearch(
                    readOnly: true,
                    onTap: () => Get.to(const SearchScreen()),
                  ),
                  expandedTitleScale: 1,
                  centerTitle: true,
                  background: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/pics/khzana.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          height: 280,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                AppColors.primaryColor.shade800.withOpacity(.8),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),

                        //Shop by category
                        const Padding(
                          padding: EdgeInsets.only(left: 20, bottom: 20),
                          child: Text(
                            'Shop by category',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),

                        //ROW FOR DISPLAYING CATEGORIES
                        controller.isFetchingCategoriesLoading
                            ? CategoriesShamer()
                            : const ScrollCategories(),

                        // NEW CLOTHES
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 20, top: 20, bottom: 20),
                              child: Text(
                                'New Clothes',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  NewClothesScreen(
                                    newClothes: controller.newClothesList,
                                  ),
                                );
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.navigate_next,
                                  size: 16,
                                ),
                              ),
                            )
                          ],
                        ),

                        //New Clothesss
                        homeController.isFetchingNewClothesLoading
                            ? NewClotheShimmer()
                            : NewClothes(),

                        //Discover

                        const Padding(
                          padding: EdgeInsets.only(left: 20, top: 20),
                          child: Text(
                            'Discover',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),

                        homeController.isFetchingNewClothesLoading
                            ? DiscoverItemsShimmer(needPading: true,)
                            : DiscoverItems()
                      ],
                    )
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




//  GetBuilder<HomeController>(
//           builder: (controller) => SingleChildScrollView(
//             child: Column(
//               children: [
//                 //Cover
//                 const HomeStack(),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     //Search
//                     HomeSearch(
//                       readOnly: true,
//                       onTap: () {
//                         Get.to(const SearchScreen());
//                       },
//                     ),
                
//                     
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),