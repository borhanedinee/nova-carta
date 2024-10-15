import 'dart:convert';

import 'package:admin_ecom/constants.dart';
import 'package:admin_ecom/data/model/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class StockController extends GetxController {
  List<ProducModel> menProducts = [];
  List<ProducModel> womenProducts = [];
  List<ProducModel> kidsProducts = [];
  List<ProducModel> searchedProducts = [];

  // text field
  TextEditingController searchFieldController = TextEditingController();
  // loaders
  bool isLoading = false;

  //fetch search results
  fetchSearchedProducts(cat, value) async {
    try {
      isLoading = true;
      update();
      searchedProducts.clear();
      var req = await http
          .get(Uri.parse('$BASE_URL/api/product/search/fetchsearch/$value'));
      if (req.statusCode != 200) {
        isLoading = false;
        update();
        throw Error();
      }
      List json = jsonDecode(req.body);
      for (var product in json) {
        if (product['categorylabel'] == cat) {
          searchedProducts.add(ProducModel.fromJson(product));
        }
      }

      isLoading = false;
      update();
      update();
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong searching for products',
      ));
    }
  }

  // fetch men stock
  fetchMenProducts(forcedToFetch) async {
    try {
      if (menProducts.isEmpty ||
          forcedToFetch ||
          searchFieldController.text != '') {
        searchFieldController.text = '';

        searchedProducts.clear();
        isLoading = true;
        update();
        await Future.delayed(Duration(seconds: 2));

        menProducts.clear();
        print('triggered');
        var response =
            await http.get(Uri.parse('$BASE_URL/api/product/fetchmen'));
        if (response.statusCode == 200) {
          List json = jsonDecode(response.body);
          if (json.isNotEmpty) {
            for (var element in json) {
              menProducts.add(ProducModel.fromJson(element));
            }
          }
          isLoading = false;
          update();
          print('doneeee');
        } else {
          isLoading = false;
          throw Error();
        }
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something wend wrong fetching men products',
      ));
    }
  }

  // fetch women stock
  fetchWomenenProducts(forcedToFetch) async {
    try {
      if (forcedToFetch ||
          womenProducts.isEmpty ||
          searchFieldController.text != '') {
        searchFieldController.text = '';

        searchedProducts.clear();
        isLoading = true;
        update();
        print('aaaaaaaaaaaaaaaaaaaaaaaaaaa');
        await Future.delayed(Duration(seconds: 2));

        womenProducts.clear();
        print('women triggered');
        var response =
            await http.get(Uri.parse('$BASE_URL/api/product/fetchwomen'));
        if (response.statusCode == 200) {
          List json = jsonDecode(response.body);
          if (json.isNotEmpty) {
            for (var element in json) {
              womenProducts.add(ProducModel.fromJson(element));
            }
          }

          isLoading = false;
          update();
        } else {
          isLoading = false;

          throw Error();
        }
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something wend wrong fetching men products',
      ));
    }
  }

  // fetch kids stock
  fetchKidsProducts(forcedToFetch) async {
    try {
      if (forcedToFetch ||
          kidsProducts.isEmpty ||
          searchFieldController.text != '') {
        searchFieldController.text = '';

        searchedProducts.clear();

        isLoading = true;
        await Future.delayed(Duration(seconds: 2));

        update();
        kidsProducts.clear();
        var response =
            await http.get(Uri.parse('$BASE_URL/api/product/fetchkids'));
        if (response.statusCode == 200) {
          List json = jsonDecode(response.body);
          if (json.isNotEmpty) {
            for (var element in json) {
              kidsProducts.add(ProducModel.fromJson(element));
            }
            isLoading = false;
            update();
          }

          isLoading = false;
          update();
          print('kids done');
        } else {
          isLoading = false;
          update();
          throw Error();
        }
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something wend wrong fetching men products',
      ));
    }
  }
}
