import 'dart:convert';

import 'package:ecommerce/constants.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class ProductController extends GetxController {
  // handling ui
  String selectedSize = '';
  String selectedColor = '';
  int productQuantity = 1;

  // ADD ITEM TO CART
  bool isLoading = false;
  addItmeToCart(productid, userid, quantity, size, color) async {
    try {
      if (quantity > 0 && color != '' && size != '') {
        isLoading = true;
        update();
        await Future.delayed(Duration(seconds: 2));
        final body = json.encode({
          'userid': userid,
          'productid': productid,
          'quantity': quantity,
          'size': size,
          'color': color,
        });
        final headers = {'content-type': 'application/json'};
        var req = await http.post(
          Uri.parse('$BASE_URL/api/product/addproducttocart'),
          body: body,
          headers: headers,
        );
        if (req.statusCode == 200) {
          isLoading = false;
          update();
          Get.showSnackbar(const GetSnackBar(
            message: 'Product added successfully',
          ));
        } else {
          isLoading = false;
          update();
          throw Error();
        }
      } else {
        Get.showSnackbar(const GetSnackBar(
          message: 'Please select color and size',
        ));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong adding the product to the cart',
      ));
    }
  }
}
