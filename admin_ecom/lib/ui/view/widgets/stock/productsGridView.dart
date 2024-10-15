
import 'package:admin_ecom/data/model/productmodel.dart';
import 'package:admin_ecom/ui/view/widgets/stock/stockproductitem.dart';
import 'package:flutter/material.dart';

class ProductsGridView extends StatelessWidget {
  const ProductsGridView({
    super.key,
    required this.products,
  });

  final List products;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  crossAxisCount: 2,
                  mainAxisExtent: 320),
              itemBuilder: (context, index) {
                ProducModel product = products[index];
                return StockProductItem(product: product);
              },
            ),
          )
        ],
      ),
    );
  }
}