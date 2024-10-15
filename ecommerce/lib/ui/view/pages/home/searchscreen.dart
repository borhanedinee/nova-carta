import 'package:ecommerce/ui/controllers/home_controller.dart';
import 'package:ecommerce/ui/controllers/search_controller.dart';
import 'package:ecommerce/ui/pallets/colors.dart';
import 'package:ecommerce/ui/view/components/emptystock.dart';
import 'package:ecommerce/ui/view/components/clothe_item.dart';
import 'package:ecommerce/ui/view/components/home/searchbar.dart';
import 'package:ecommerce/ui/view/shimmers/home_shimmers/discoveritems_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FocusNode _focusNode = FocusNode();
  
  TextEditingController editingController = TextEditingController();

  SearchScreenController searchScreenController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Auto focus the search field when the screen is displayed
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });

    searchScreenController.fetchRecentlySearchedWords(1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<HomeController>(
          builder: (controller) => GetBuilder<SearchScreenController>(
            builder: (searchController) => SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Icons.navigate_before),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.17,
                        ),
                        const Text(
                          'Search an item',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    HomeSearch(
                      controller: editingController,
                      readOnly: false,
                      focussedNode: _focusNode,
                      onSubmit: (p0) {
                        if (p0 != '') {
                          print('doneee');
                          searchController.recentSearches.add(p0);
                          searchController.addRecentSearchKey(p0 , 1);
                        }
                      },
                      onChanged: (p0) {
                        if (p0 != '') {
                          
                          searchController.fetchSeachedProducts(p0);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    searchController.recentSearches.isEmpty?
                    Container():
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Recently searched',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Wrap(
                          children: List.generate(
                            searchController.recentSearches.length,
                            (index) {
                              String searchKey = searchController.recentSearches.reversed.toList()[index];
                              return GestureDetector(
                                onTap: () {
                                  editingController.text = searchKey;
                                  searchController.fetchSeachedProducts(searchKey);
                                },
                                child: FittedBox(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  margin: const EdgeInsets.only(right: 10 , top: 10),
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.primaryColor.withOpacity(.3),
                                  ),
                                  child: Center(
                                    child: Text(
                                      searchKey,
                                      style: const TextStyle(fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                                            ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        'Popular',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    searchController.isFetchingLoading
                        ? DiscoverItemsShimmer(needPading: false,)
                        : searchController.searchedProducts.isNotEmpty &&
                                editingController.text != ''
                            ? GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1 / 1.6,
                                  mainAxisSpacing: 5,
                                  crossAxisCount: 2,
                                ),
                                itemCount:
                                    searchController.searchedProducts.length,
                                itemBuilder: (context, index) {
                                  final product =
                                      searchController.searchedProducts[index];
                                  return ClotheItem(
                                    product: product,
                                  );
                                },
                              )
                            : (searchController.searchedProducts.isEmpty &&
                                    editingController.text != '')
                                ? const EmptyStock()
                                : GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1 / 1.6,
                                      mainAxisSpacing: 5,
                                      crossAxisCount: 2,
                                    ),
                                    itemCount: controller.newClothesList
                                        .take(10)
                                        .length,
                                    itemBuilder: (context, index) {
                                      final product =
                                          controller.newClothesList[index];
                                      return ClotheItem(
                                        product: product,
                                      );
                                    },
                                  ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
