import 'dart:convert';

import 'package:ecommerce/constants.dart';
import 'package:http/http.dart' as http;

class HomeApi {
  // fetch products
  static fetchNewClothes() async {
    try {
      var req =
          await http.get(Uri.parse('$BASE_URL/api/product/fetchnewclothes'));
      if (req.statusCode != 200) {
        throw Error();
      }
      List jsonResponse = jsonDecode(req.body);
      return jsonResponse;
    } catch (e) {
      rethrow;
    }
  }

  // // fetch categories
  // fetchCategories() async {
  //   try {
  //     var req = await http.get(Uri.parse('$BASE_URL/api/categories'));

  //     if (req.statusCode != 200) {
  //       throw Error();
  //     }
  //     List jsonResponse = jsonDecode(req.body);
  //     return jsonResponse;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }
}
