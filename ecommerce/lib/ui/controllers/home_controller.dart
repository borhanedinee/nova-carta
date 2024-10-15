import 'dart:convert';

import 'package:ecommerce/constants.dart';
import 'package:ecommerce/dataa/models/categorie_model.dart';
import 'package:ecommerce/dataa/models/productmodel.dart';
import 'package:ecommerce/dataa/repositories/home_repo.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  HomeRepository homeRepository = HomeRepository();

  // new clothes
  List<ProducModel> newClothesList = [];

  bool isFetchingNewClothesLoading = false;
  fetchNewClothes() async {
    try {
      if (newClothesList.isEmpty) {
        newClothesList.clear();
        isFetchingNewClothesLoading = true;
        update();
        await Future.delayed(const Duration(seconds: 8));
        newClothesList = await homeRepository.fetchNewClothes();
        isFetchingNewClothesLoading = false;
        update();
      }
    } catch (e) {
      isFetchingNewClothesLoading = false;
      update();
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Something went wrong fetching new clothes',
        ),
      );
      ;
    }
  }

  // Categories
  List<CategoryModel> categoriesList = [];
  bool isFetchingCategoriesLoading = false;
  fetchCategories() async {
    // i will make them static
    try {
      if (categoriesList.isEmpty) {
        categoriesList.clear();
        isFetchingCategoriesLoading = true;
        update();
        await Future.delayed(const Duration(seconds: 2));

        List categJson = [
          {
            'label': 'Men',
            'icon': 'assets/pics/man.png',
            'id': 1,
          },
          {
            'label': 'Women',
            'icon': 'assets/pics/girl.png',
            'id': 6,
          },
          {
            'label': 'Kids',
            'icon': 'assets/pics/kid.png',
            'id': 8,
          },
        ];
        for (var element in categJson) {
          categoriesList.add(CategoryModel.fromJson(element));
        }
        isFetchingCategoriesLoading = false;

        update();
      }
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong fetching categories',
      ));
    }
  }

  // here fetch favourite products ids to controll the favourite mark
  List<int> favouriteProductsIds = [];
  fetchProductsToFavourites(userid) async {
    try {
      print('ffffffffffffffff');
      favouriteProductsIds.clear();
      update();
      var req = await http.get(
          Uri.parse('$BASE_URL/api/product/getproductsfromfavourites/$userid'));
      if (req.statusCode != 200) {
        throw Error();
      }
      var jsonResponse = json.decode(req.body);
      for (var json in jsonResponse) {
        favouriteProductsIds.add(json['id']);
      }

      update();
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        message: 'Something went wrong fetching products from favourites',
      ));
      return [];
    }
  }
}
