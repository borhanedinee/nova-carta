import 'package:admin_ecom/constants.dart';
import 'package:admin_ecom/main.dart';
import 'package:admin_ecom/data/model/order/orderedProductsModel.dart';
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final OrderedProductModel product;
  const ProductItem({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Container(
            height: 110,
            width: (size.width - 30) * 0.25,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
            )),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Image.network(
                '${PRODUCT_ASSET_BASE_URL}/${product.productAsset}',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            width: (size.width - 30) * 0.55,
            height: 110,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.productName,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    
                  ),
                ),
                Text(
                  product.productDescription,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey , fontWeight: FontWeight.w300),
                ),
                const Spacer(),
                Text(
                  '${product.productPrice} DA',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.bottomRight,
            width: (size.width - 30) * 0.2,
            height: 80,
            child: Text('x ${product.quantity}'),
          )
        ],
      ),
    );
  }
}
