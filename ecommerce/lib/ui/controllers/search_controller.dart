import 'dart:convert';

import 'package:ecommerce/constants.dart';
import 'package:ecommerce/dataa/models/productmodel.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class SearchScreenController extends GetxController {
  // fetch recently searched words
  List<String> recentSearches = [];
  fetchRecentlySearchedWords(userid) async {
    try {
      if (recentSearches.isEmpty) {
        var req =
            await http.get(Uri.parse('$BASE_URL/api/recentlysearched/$userid'));
        if (req.statusCode == 200) {
          final jsonn = json.decode(req.body);
          for (var searchKey in jsonn) {
            recentSearches.add(searchKey['searchkey']);
          }
          update();
        } else {
          throw Exception('Failed to fetch recently searched words');
        }
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Failed to fetch recently searched words',
      ));
    }
  }

  // add search key
  addRecentSearchKey(String key, user) async {
    try {
      print('object');
      final body = jsonEncode({
        'searchkey': key,
        'userid': user,
      });
      final headers = {'content-type': 'application/json'};
      var req = await http.post(
        Uri.parse('$BASE_URL/api/recentlysearched/addsearchkey'),
        body: body,
        headers: headers,
      );
      if (req.statusCode == 200) {
        Get.showSnackbar(const GetSnackBar(
          message: 'Search key added successfully',
        ));
      } else {
        throw Exception('Failed to add search key');
      }
    } catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: 'Failed to add search key' + e.toString(),
      ));
    }
  }

  // fetch searchedProducts
  List<ProducModel> searchedProducts = [];
  bool isFetchingLoading = false;
  fetchSeachedProducts(value) async {
    try {
      searchedProducts.clear();
      isFetchingLoading = true;
      update();
      await Future.delayed(const Duration(seconds: 2));
      print(value);
      var req = await http
          .get(Uri.parse('$BASE_URL/api/product/search/fetchsearch/$value'));
      print(req.statusCode);
      if (req.statusCode == 200) {
        isFetchingLoading = false;
        final json = jsonDecode(req.body);
        for (var product in json) {
          searchedProducts.add(ProducModel.fromJson(product));
        }
        update();
      } else {
        isFetchingLoading = false;
        update();
        throw Exception('Failed to fetch searched products');
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Failed to fetch searched products',
      ));
      isFetchingLoading = false;
      update();
    }
  }
}
