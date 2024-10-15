import 'dart:convert';

import 'package:admin_ecom/constants.dart';
import 'package:admin_ecom/data/model/couponmodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CouponController extends GetxController {
  // fetch coupons
  List<CouponModel> coupons = [];
  bool isFetchingCouponLoading = false;
  fetchCoupns() async {
    try {
      coupons.clear();
      isFetchingCouponLoading = true;
      update();
      var req = await http.get(Uri.parse('$BASE_URL/api/coupon'));
      if (req.statusCode != 200) {
        isFetchingCouponLoading = false;
        update();
        throw Error();
      }
      var response = json.decode(req.body);
      for (var coupon in response) {
        coupons.add(CouponModel.fromJson(coupon));
      }
      isFetchingCouponLoading = false;
      update();
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong fetching coupons.',
      ));
    }
  }

  // add coupon
  bool isAddButtonLoading = false;
  addCoupon(map) async {
    try {
      isAddButtonLoading = true;
      update();
      await Future.delayed(Duration(seconds: 2));
      var body = json.encode(map);
      var header = {'Content-Type': 'application/json'};
      var req = await http.post(Uri.parse('$BASE_URL/api/coupon/add'),
          body: body, headers: header);
      if (req.statusCode != 200) {
        isAddButtonLoading = false;
        update();
        throw Error();
      }
      isAddButtonLoading = false;
      update();
      Map jsonn = jsonDecode(req.body);
      if (jsonn.containsKey('message')) {
        fetchCoupns();
        Get.showSnackbar(const GetSnackBar(
          message: 'Coupon added successfully.',
        ));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong adding coupon.',
      ));
    }
  }

  // delete coupon
  bool isDeleteButtonLoading = false;
  deleteCoupon(couponid) async {
    try {
      isDeleteButtonLoading = true;
      update();
      await Future.delayed(Duration(seconds: 2));
      var req = await http.delete(Uri.parse('$BASE_URL/api/coupon/$couponid'));
      if (req.statusCode != 200) {
        isDeleteButtonLoading = false;
        update();
        throw Error();
      }
      coupons.removeWhere((element) => element.id == couponid);
      Get.showSnackbar(const GetSnackBar(
        message: 'Coupon deleted successfully',
      ));
      isDeleteButtonLoading = false;
      update();
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong deleting coupon.',
      ));
    }
  }
}
