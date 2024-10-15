import 'dart:convert';

import 'package:ecommerce/constants.dart';
import 'package:ecommerce/dataa/models/productmodel.dart';
import 'package:ecommerce/ui/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FavoritesController extends GetxController {
  // fetch products to favourites
  bool isFetchingProductsToFavouriteLoading = false;
  List<ProducModel> productsToFavouriteList = [];
  fetchProductsToFavourites(userid, isForcedToFetch) async {
    try {
      if (productsToFavouriteList.isEmpty || isForcedToFetch) {
        
        isFetchingProductsToFavouriteLoading = true;
        update();
        await Future.delayed(Duration(seconds: 2));
        var req = await http.get(Uri.parse(
            '$BASE_URL/api/product/getproductsfromfavourites/$userid'));
        if (req.statusCode != 200) {
          isFetchingProductsToFavouriteLoading = false;
          update();
          throw Error();
        }
        var jsonResponse = json.decode(req.body);
        productsToFavouriteList.clear();

        for (var json in jsonResponse) {
          productsToFavouriteList.add(ProducModel.fromJson(json));
        }
        isFetchingProductsToFavouriteLoading = false;
        update();
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong fetching products from favourites',
      ));
      return [];
    }
  }

   // add product to favourites
  addProductToFavourites(productid, userid) async {
    try {
      var req = await http.put(Uri.parse(
          '$BASE_URL/api/product/addproducttofavourite/$productid/$userid'));
      if (req.statusCode != 200) {
        throw Error();
      }
      Get.showSnackbar(const GetSnackBar(
        message: 'Product added to favourites',
      ));
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong adding product to favourites',
      ));
    }
  }

  // delete product from favourites
  deleteProductFromFavourites(productid, userid) async {
    try {
      var req = await http.put(Uri.parse(
          '$BASE_URL/api/product/deleteproductfromfavourite/$productid/$userid'));
      if (req.statusCode != 200) {
        throw Error();
      }
      productsToFavouriteList.removeWhere((element) => element.id == productid);
      Get.showSnackbar(const GetSnackBar(
        message: 'Product deleted from favourites',
      ));
      update();
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong deleting product from favourites',
      ));
    }
  }

  // clear cart
  clearFavorites() {
    productsToFavouriteList.clear();
    update();
  }

  // delete all items from cart
  bool isDeletingAllFavoriteItemsLoading = false;
  deleteAllFavouritesItems(userid) async {
    try {
      isDeletingAllFavoriteItemsLoading = true;
      update();
      await Future.delayed(Duration(seconds: 2));
      var req = await http
          .delete(Uri.parse('$BASE_URL/api/favourites/deleteallitems/$userid'));
      if (req.statusCode == 200) {
        isDeletingAllFavoriteItemsLoading = false;
        clearFavorites();
        update();
        Get.showSnackbar(GetSnackBar(message: 'Delleted Successfully'));
      } else {
        isDeletingAllFavoriteItemsLoading = false;
        update();
        throw Error();
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: 'Something went wrong deleting cart items' + '$e',
      ));
    }
  }
}
