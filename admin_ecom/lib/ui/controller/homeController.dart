import 'dart:convert';

import 'package:admin_ecom/constants.dart';
import 'package:admin_ecom/data/model/couponmodel.dart';
import 'package:admin_ecom/data/model/order/orderModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  List<OrderModel> recentOrders = [];

  // loaders
  bool recentOrdersLoading = false;

  bool isStatusLabelLoading = false;

  

  fetchRecentOrders(forcedToFetch) async {
    try {
      if (forcedToFetch || recentOrders.isEmpty) {
        recentOrdersLoading = true;
        update();
        await Future.delayed(Duration(seconds: 2));
        recentOrders.clear();

        var req =
            await http.get(Uri.parse('$BASE_URL/api/orders/fetchrecentorders'));
        if (req.statusCode != 200) {
          recentOrdersLoading = false;
          update();
          throw Exception();
        }
        var json = jsonDecode(req.body);
        for (var order in json) {
          recentOrders.add(OrderModel.fromJson(order));
        }

        recentOrdersLoading = false;
        update();
      }
    } catch (e) {
      recentOrdersLoading = false;
      update();
    }
  }

  //update order status
  acceptOrder(orderid, needToGetBack) async {
    try {
      isStatusLabelLoading = true;
      update();
      var body = {'orderid': orderid, 'updateto': 'inProgress'};
      var req = await http.post(
        Uri.parse('$BASE_URL/api/orders/update'),
        body: json.encode(body),
        headers: {'Content-Type': 'application/json'},
      );
      if (req.statusCode != 200) {
        isStatusLabelLoading = false;
        update();
        throw Error();
      }

      recentOrders.removeWhere((order) => order.orderInfoId == orderid);

      isStatusLabelLoading = false;
      update();
      if (needToGetBack) {
        Get.back();
      }
      Get.showSnackbar(GetSnackBar(
        message: 'Order accepted successfully',
      ));
    } catch (e) {
      isStatusLabelLoading = false;
      update();
      Get.showSnackbar(GetSnackBar(
        message: 'Something went wrong, please try again',
      ));
    }
  }
}
