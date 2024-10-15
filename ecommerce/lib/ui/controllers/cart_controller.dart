import 'dart:convert';

import 'package:ecommerce/constants.dart';
import 'package:ecommerce/dataa/models/cart_product_model.dart';
import 'package:ecommerce/dataa/models/coupon_model.dart';
import 'package:ecommerce/dataa/models/productmodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  int totalItemsToCard = 0;
  int totalPrice = 0;

  // fetch payment methods
  List<String> paymentMethods = [];
  fetchPaymentMethods() async {
    try {
      paymentMethods.clear();
      var req = await http
          .get(Uri.parse('$BASE_URL/api/payment/fetchpaymentmethods'));
      if (req.statusCode == 200) {
        final data = jsonDecode(req.body);
        for (var method in data) {
          paymentMethods.add(method['paymentmethod']);
        }
        selectedPaymentMethod = paymentMethods.first;
        update();
      } else {
        throw Error();
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: 'Something went wrong fetching payment methods' + '$e',
      ));
    }
  }

  // fetch payment methods
  List<String> deliveryMethods = [];
  fetchDeliveryMethods() async {
    try {
      deliveryMethods.clear();
      var req = await http
          .get(Uri.parse('$BASE_URL/api/delivery/fetchdeliverymethods'));
      print(req.body);
      if (req.statusCode == 200) {
        final data = jsonDecode(req.body);
        for (var method in data) {
          deliveryMethods.add(method['deliverymethod']);
        }
        selectedDeliveryMethod = deliveryMethods.first;
        update();
      } else {
        throw Error();
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: 'Something went wrong fetching delivery methods' + '$e',
      ));
    }
  }

  // fetch cart roducts
  List<CartProductModel> cartProducts = [];
  bool isFetchingCartProductsLoading = false;
  fetchCartProducts(userid, isForcedToFetch) async {
    try {
      if (cartProducts.isEmpty || isForcedToFetch) {
        cartProducts.clear();
        totalPrice = 0;
        totalItemsToCard = 0;
        isFetchingCartProductsLoading = true;
        update();
        await Future.delayed(const Duration(seconds: 2));
        var req = await http
            .get(Uri.parse('$BASE_URL/api/cart/fetchcartproducts/$userid'));
        if (req.statusCode == 200) {
          final data = jsonDecode(req.body);
          for (var product in data) {
            cartProducts.add(CartProductModel.fromJson(product));
          }
          for (var product in cartProducts) {
            totalItemsToCard += product.quantity;
            totalPrice += product.price.toInt() * product.quantity.toInt();
          }
          isFetchingCartProductsLoading = false;
          update();
        } else {
          isFetchingCartProductsLoading = false;
          update();
          throw Error();
        }
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: 'Something went wrong fetching cart products' + '$e',
      ));
    }
  }

  updateTotalCartItems() {
    totalItemsToCard = 0;
    for (var product in cartProducts) {
      totalItemsToCard += product.quantity;
    }
  }

  // fetch coupons
  String seletedCoupon = '';
  List<CouponModel> coupons = [];
  bool isFetchingCouponsLoading = false;
  fetchCoupons() async {
    try {
      if (coupons.isEmpty) {
        isFetchingCouponsLoading = true;
        update();
        await Future.delayed(const Duration(seconds: 2));
        var req = await http.get(Uri.parse('$BASE_URL/api/coupon'));
        if (req.statusCode != 200) {
          isFetchingCouponsLoading = false;
          update();
          throw Error();
        }
        final data = jsonDecode(req.body);
        print(data);
        for (var coupon in data) {
          coupons.add(CouponModel.fromJson(coupon));
        }
        print(coupons.first);
        isFetchingCouponsLoading = false;
        update();
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong fetching coupons',
      ));
    }
  }

  // delete all items from cart
  bool isDeletingAllCartItemsLoading = false;
  deleteAllCartItems(userid) async {
    try {
      isDeletingAllCartItemsLoading = true;
      update();
      await Future.delayed(const Duration(seconds: 2));
      var req = await http
          .delete(Uri.parse('$BASE_URL/api/cart/deleteallitems/$userid'));
      if (req.statusCode == 200) {
        isDeletingAllCartItemsLoading = false;
        clearCart();
        update();
        Get.showSnackbar(const GetSnackBar(message: 'Delleted Successfully'));
      } else {
        isDeletingAllCartItemsLoading = false;
        update();
        throw Error();
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: 'Something went wrong deleting cart items' + '$e',
      ));
    }
  }

  String selectedPaymentMethod = '';
  String selectedDeliveryMethod = '';

  // clear cart
  clearCart() {
    cartProducts.clear();
    update();
  }

  // ui

  int numOfItems = 0;
  updateNumOfItems() {
    numOfItems = cartProducts.length;
    update();
  }

  final String deliveryTo = '';

  incrementProductQuantity(selectedOrderId) async {
    try {
      var req = await http.delete(
        Uri.parse(
          '$BASE_URL/api/order/productquantity/increment/$selectedOrderId',
        ),
      );
      if (req.statusCode == 200) {
        Get.showSnackbar(const GetSnackBar(message: 'Quantity increased'));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong incrementing quantity',
      ));
    }
  }

  decrementProductQuantity(selectedOrderId) async {
    try {
      var req = await http.delete(
        Uri.parse(
          '$BASE_URL/api/order/productquantity/decrement/$selectedOrderId',
        ),
      );
      if (req.statusCode == 200) {
        Get.showSnackbar(const GetSnackBar(message: 'Quantity decremented'));
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong decrementing quantity',
      ));
    }
  }

  // selected coupon
  int selectedCouponPourcentage = 0;

  bool isCouponApplied = false;
  int newTotalPrice = 0;
  bool isApplyingCouponLoading = false;
  applyCoupon() async {
    if (selectedCouponPourcentage == 0) {
      return;
    }
    isApplyingCouponLoading = true;
    update();
    await Future.delayed(const Duration(seconds: 3));
    isCouponApplied = true;
    newTotalPrice = totalPrice - totalPrice * selectedCouponPourcentage ~/ 100;
    isApplyingCouponLoading = false;
    update();
    Get.back();
    Get.showSnackbar(
      const GetSnackBar(message: 'Coupon applied successfully'),
    );
  }

  turnOffCoupons() {
    isCouponApplied = false;
    seletedCoupon = '';
    selectedCouponPourcentage = 0;
    print(seletedCoupon);
    update();
  }

  // after changing quantity of items
  updateTotalPrice() {
    totalPrice = 0;
    for (var product in cartProducts) {
      totalPrice += product.quantity * product.price.toInt();
    }
    if (isCouponApplied) {
      newTotalPrice =
          totalPrice - totalPrice * selectedCouponPourcentage ~/ 100;
    }
  }

  int selectedSingleItemToBeDeleted = 0;
  bool isDeletingSingleCartItemLoading = false;
  deleteSingleCartItem(cartItemID, userID) async {
    try {
      isDeletingSingleCartItemLoading = true;
      update();
      await Future.delayed(Duration(seconds: 4));
      var req = await http.delete(
        Uri.parse('$BASE_URL/api/cart/deletesingleitem/$userID/$cartItemID'),
      );
      if (req.statusCode == 200) {
        cartProducts.removeWhere((element) => element.product == cartItemID);
        Get.back();

        isDeletingSingleCartItemLoading = false;

        update();
      } else {
        Get.back();

        throw Error();
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          message: 'Something went wrong, please try again',
        ),
      );
    }
  }
}
