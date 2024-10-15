import 'package:admin_ecom/ui/controller/stockController.dart';
import 'package:admin_ecom/ui/view/shimmers/stock_items_shimmer.dart';
import 'package:admin_ecom/ui/view/widgets/noResultForSearchedProducts.dart';
import 'package:admin_ecom/ui/view/widgets/stock/emptystock.dart';
import 'package:admin_ecom/ui/view/widgets/stock/productsGridView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KidsTab extends StatelessWidget {
  const KidsTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StockController>(
      builder: (controller) => controller.isLoading
          ? StockItemsShimmer()
          : controller.searchedProducts.isEmpty &&
                  controller.searchFieldController.text == ''
              ? ProductsGridView(products: controller.kidsProducts)
              : controller.searchedProducts.isNotEmpty
                  ? ProductsGridView(products: controller.searchedProducts)
                  : controller.searchedProducts.isEmpty &&
                          controller.searchFieldController.text != ''
                      ? NoResult()
                      : const EmptyStockWidget(categorie: 'kids'),
    );
  }
}
