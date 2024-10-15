import 'dart:convert';

import 'package:ecommerce/constants.dart';
import 'package:ecommerce/ui/controllers/cart_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
class CheckoutController extends GetxController {
  final CartController cartController = Get.find();
  // send order
  bool isSendingOrderLoading = false;
  sendOrder(userid, fullname , phone, location , deliverymethod , paymentmethod , discount)async{
    try {
      isSendingOrderLoading = true;
      update();
      await Future.delayed(Duration(seconds: 2)); // simulate network delay
      final body = jsonEncode(
        {
          'userid': userid,
          'fullname': fullname,
          'phone': phone,
          'location': location,
          'deliverymethod': deliverymethod,
          'paymentmethod': paymentmethod,
          'discount': discount
        }
      );
      final headers = {'Content-Type': 'application/json'};
      var req = await http.post(
        Uri.parse('$BASE_URL/api/checkout'),
        body: body,
        headers: headers,
      );
      if (req.statusCode != 200) {
        isSendingOrderLoading = false;
        update();
        throw Error();
      }
      isSendingOrderLoading = false;
      cartController.clearCart();
      update();
      Get.back();
      Get.showSnackbar(const GetSnackBar(
        message: 'Order sent successfully, see your order in the order list',
      ));
    } catch (e) {
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Error sending order, please try again',
        ),
      );
    }
  }
}