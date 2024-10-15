import 'package:admin_ecom/constants.dart';
import 'package:admin_ecom/main.dart';
import 'package:admin_ecom/data/model/productmodel.dart';
import 'package:admin_ecom/ui/view/screens/itemscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StockProductItem extends StatelessWidget {
  const StockProductItem({
    super.key,
    required this.product,
  });

  final ProducModel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(()=>ItemScreen(product: product));
      },
      child: Container(
        height: 275,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              height: 275 * 0.68,
              width: (size.width - 28) * 0.5,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Image.network(
                  '$PRODUCT_ASSET_BASE_URL/${product.asset}',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                width: (size.width - 28) * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      width: ((size.width - 28) * 0.5) * 0.7,
                      child: Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.grey, fontSize: 12 , fontWeight: FontWeight.w300 ),
                      ),
                    ),
                    Text(
                      '${product.price} DZ',
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
