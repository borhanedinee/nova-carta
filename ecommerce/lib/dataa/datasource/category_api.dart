import 'dart:convert';

import 'package:ecommerce/constants.dart';
import 'package:http/http.dart' as http;

class CategoryAPI {
  static fetchProductsBasedOnCategory(category, type) async {
    try {
      var req =
          await http.get(Uri.parse('$BASE_URL/api/product/$category/$type'));
      if (req.statusCode != 200) {
        throw Error();
      }
      var jsonResponse = json.decode(req.body);
      print(jsonResponse);
      return jsonResponse;
    } catch (e) {
      throw e;
    }
  }
}
