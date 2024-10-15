import 'package:ecommerce/dataa/datasource/home_data_api.dart';
import 'package:ecommerce/dataa/models/productmodel.dart';

class HomeRepository {
  fetchNewClothes() async {
    List<ProducModel> products = [];
    try {
      List data = await HomeApi.fetchNewClothes();
      for (var element in data) {
        products.add(ProducModel.fromJson(element));
      }
      return products;
    } catch (e) {
      rethrow;
    }
  }
}