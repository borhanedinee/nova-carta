import 'package:ecommerce/dataa/models/product_type.dart';
import 'package:ecommerce/dataa/models/productmodel.dart';
import 'package:ecommerce/dataa/repositories/category_repo.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  CategoryRepository categoryRepository = CategoryRepository();
  String selectedType = 'feetwear';
  updateSelectedType(categorie){
    selectedType = categorie;
    update();
  }

  // fetch types
  List<ProductTypeModel> types = [];
  bool isFetchingTypesLoading = false;
  fetchProductTypes() async {
    try {
      types.clear();
      isFetchingTypesLoading = true;
      update();
      await Future.delayed(const Duration(seconds: 2));
      List json = [
        {"id": 3, "type": "feetwear"},
        {"id": 4, "type": "bottoms"},
        {"id": 5, "type": "tops"},
        {"id": 6, "type": "accessoires"},
        {"id": 9, "type": "outfits"}
      ];
      for (var element in json) {
        types.add(ProductTypeModel.fromJson(element));
      }
      isFetchingTypesLoading = false;
      update();
    } catch (e) {
      print(e);
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong fetching product type',
      ));
    }
  }

  // fetch products based on selected categorie
  List<ProducModel> products = [];
  bool isFetchingProductsLoading = false;
  int typeToSearch = 3 ;
  fetchProducts(category, type) async {
    try {
      products.clear();
      isFetchingProductsLoading = true;
      update();
      await Future.delayed(const Duration(seconds: 2));
      List result = await categoryRepository.fetchProducts(category, type);
      if (result.isNotEmpty) {
        products = result as List<ProducModel>;
      }

      isFetchingProductsLoading = false;
      update();
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong fetching products',
      ));
    }
  }
}
