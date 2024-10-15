import 'package:ecommerce/dataa/datasource/category_api.dart';
import 'package:ecommerce/dataa/models/product_type.dart';
import 'package:ecommerce/dataa/models/productmodel.dart';

class CategoryRepository {
  // fetching products by category and type
  List<ProducModel> products = [];
  fetchProducts(category, type) async {
    try {
      List result =
          await CategoryAPI.fetchProductsBasedOnCategory(category, type);
      if (result.isNotEmpty) {
        for (var element in result) {
          
          products.add(ProducModel.fromJson(element));
        }

        print(products.toString() + 'frrr');
        return products;
      }
      return [];
    } catch (e) {
      
      print(e);
      rethrow;
    }
  }
}
