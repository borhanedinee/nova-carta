import 'dart:convert';

import 'package:admin_ecom/constants.dart';
import 'package:admin_ecom/ui/controller/homeController.dart';
import 'package:admin_ecom/data/model/order/orderModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OrdersController extends GetxController {
  List<OrderModel> allOrders = [];
  List<OrderModel> pendingOrders = [];
  List<OrderModel> inProgressOrders = [];
  List<OrderModel> completedOrders = [];

  HomeController homeController = Get.find();

  // loaders
  bool isLoading = false;

  bool isStatusLabelLoading = false;

  fetchAllOrders() async {
    try {
      isLoading = true;
      update();
      await Future.delayed(Duration(seconds: 2));

      allOrders.clear();
      pendingOrders.clear();
      completedOrders.clear();
      inProgressOrders.clear();
      var req =
          await http.get(Uri.parse('$BASE_URL/api/orders/fetchallorders'));
      if (req.statusCode != 200) {
        isLoading = false;
        update();
        throw Exception();
      }
      var json = jsonDecode(req.body);
      for (var order in json) {
        allOrders.add(OrderModel.fromJson(order));
      }
      for (var order in allOrders) {
        if (order.status == 'completed') {
          completedOrders.add(order);
        } else if (order.status == 'pending') {
          pendingOrders.add(order);
        } else if (order.status.toLowerCase() == 'inprogress') {
          inProgressOrders.add(order);
        }
      }
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
      update();
    }
  }

  // selected order id to help ui loading
  int selectedOrderId = 1111111111111;

  changeSelectedOrderId(orderid) {
    selectedOrderId = orderid;
    update();
  }

  //update order status
  updateOrderStatus(updateToStatus, needToGetBack) async {
    try {
      isStatusLabelLoading = true;
      update();
      await Future.delayed(const Duration(seconds: 3));

      var body = {
        'orderid': selectedOrderId,
        'updateto': updateToStatus,
      };
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

      homeController.recentOrders
          .removeWhere((order) => order.orderInfoId == selectedOrderId);

      if (updateToStatus == 'inProgress') {
        pendingOrders
            .removeWhere((order) => order.orderInfoId == selectedOrderId);
      }
      if (updateToStatus == 'completed') {
        inProgressOrders
            .removeWhere((order) => order.orderInfoId == selectedOrderId);
      }
      if (updateToStatus == 'deleted') {
        completedOrders
            .removeWhere((order) => order.orderInfoId == selectedOrderId);
      }
      if (needToGetBack) {
        Get.back();
      }
      switch (updateToStatus) {
        case 'inProgress':
          Get.showSnackbar(const GetSnackBar(
            message: 'Order accepted successfully',
          ));
          break;
        case 'completed':
          Get.showSnackbar(const GetSnackBar(
            message: 'Order completed successfully',
          ));
          break;
        case 'deleted':
          Get.showSnackbar(const GetSnackBar(
            message: 'Order deleted successfully',
          ));
          break;
        default:
      }
      isStatusLabelLoading = false;
      selectedOrderId = -1;

      update();
    } catch (e) {
      selectedOrderId = -1;

      isStatusLabelLoading = false;
      update();
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong, please try again',
      ));
    }
  }
}
