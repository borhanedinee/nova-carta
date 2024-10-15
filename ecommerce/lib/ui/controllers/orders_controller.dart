import 'dart:convert';

import 'package:ecommerce/constants.dart';
import 'package:ecommerce/dataa/models/orderModel.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class OrdersController extends GetxController {
  // fetch user orders
  List<OrderModel> allOrders = [];
  List<OrderModel> pendingOrders = [];
  List<OrderModel> inProgressOrders = [];
  List<OrderModel> completedOrders = [];
  bool isFetchingOrdersLoading = false;
  fetchOrders(userid) async {
    try {
      isFetchingOrdersLoading = true;
      update();
      await Future.delayed(const Duration(seconds: 2));
      var req = await http
          .get(Uri.parse('$BASE_URL/api/orders/fetchallorders/$userid'));
      if (req.statusCode != 200) {
        throw Error();
      }
      var jsonData = json.decode(req.body);
      for (var order in jsonData) {
        allOrders.add(OrderModel.fromJson(order));
      }
      for (var order in allOrders) {
        print(order.status.toLowerCase());
        switch (order.status.toLowerCase()) {
          case 'pending':
            pendingOrders.add(order);
            break;
          case 'inprogress':
            inProgressOrders.add(order);
            break;
          case 'completed':
            completedOrders.add(order);
            break;
          default:
        }
      }
      isFetchingOrdersLoading = false;
      update();
      const GetSnackBar(
        message: 'Orders successfully fetched',
      );
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: 'Something went wrong fetching orders + $e',
      ));
    }
  }

  // selected order id
  int selectedOrderId = -1;
  changeOrderId(orderid) {
    selectedOrderId = orderid;
    update();
  }

  deleteOrder(navigateback) async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      var req = await http.delete(
        Uri.parse('$BASE_URL/api/order/deleteorder/$selectedOrderId'),
      );
      if (req.statusCode != 200) {
        throw Error();
      }

      pendingOrders
          .removeWhere((order) => order.orderInfoId == selectedOrderId);
      update();

      Get.showSnackbar(const GetSnackBar(
        message: 'Order deleted successfully',
      ));

      selectedOrderId = 0;

      if (navigateback) {
        return true;
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: 'Something went wrong deleting order + $e',
      ));
    }
  }

  bool isChangingStatusLoading = false;

  updateOrderStatusTo(orderID, status) async {
    try {
      selectedOrderId = orderID;
      isChangingStatusLoading = true;
      update();

      await Future.delayed(const Duration(seconds: 4));
      print(selectedOrderId);
      var req = await http.post(
        Uri.parse('$BASE_URL/api/orders/updateclientside'),
        body: {
          'orderid': orderID.toString(),
          'updateto': status,
        },
      );

      print(req.statusCode);

      if (req.statusCode != 200) {
        throw Error();
      }

      switch (status) {
        case 'completed':
          inProgressOrders
              .removeWhere((element) => element.orderInfoId == orderID);
          break;
        case 'deleted':
          completedOrders
              .removeWhere((element) => element.orderInfoId == orderID);
          break;
        default:
      }

      selectedOrderId = 0;
      isChangingStatusLoading = false;
      update();
    } catch (e) {
      print(e.toString());
      selectedOrderId = -1;
      isChangingStatusLoading = false;
      update();
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong, Please try again',
      ));
    }
  }
}
