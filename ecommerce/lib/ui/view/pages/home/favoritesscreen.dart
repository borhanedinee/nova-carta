import 'package:ecommerce/core/services/dialogs/favourites_dialogs.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/ui/controllers/favourites_controller.dart';
import 'package:ecommerce/ui/controllers/home_controller.dart';
import 'package:ecommerce/ui/view/components/emptystock.dart';
import 'package:ecommerce/ui/view/components/clothe_item.dart';
import 'package:ecommerce/ui/view/components/favourites/empty_favourite.dart';
import 'package:ecommerce/ui/view/shimmers/home_shimmers/discoveritems_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  FavoritesController favoritesController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favoritesController.fetchProductsToFavourites(user!.id, true);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          body: GetBuilder<FavoritesController>(
        builder: (controller) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: size.width,
                child: const Text(
                  'Favorites',
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.fetchProductsToFavourites(user!.id, true);
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        controller.isFetchingProductsToFavouriteLoading
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 22 , left: 8 , bottom: 22),
                                    child: Text('Products you like'),
                                  ),
                                  DiscoverItemsShimmer(
                                    needPading: false,
                                  ),
                                ],
                              )
                            : controller.productsToFavouriteList.isEmpty
                                ? const Center(child: EmptyFavourite())
                                : Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text('Products you like'),
                                            controller
                                                    .isDeletingAllFavoriteItemsLoading
                                                ? Container(
                                                    margin: const EdgeInsets.all(15),
                                                    height: 15,
                                                    width: 15,
                                                    child: const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                  )
                                                : IconButton(
                                                    onPressed: () {
                                                      showDeletingAllFavoritesItemsDialog(
                                                          context, controller);
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete_outlined),
                                                  )
                                          ],
                                        ),
                                      ),
                                      GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                                childAspectRatio: 1 / 1.6,
                                                crossAxisCount: 2,
                                                mainAxisSpacing: 10,
                                                crossAxisSpacing: 10),
                                        itemCount: controller
                                            .productsToFavouriteList.length,
                                        itemBuilder: (context, index) {
                                          final product = controller
                                              .productsToFavouriteList[index];
                                          return ClotheItem(
                                            product: product,
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
