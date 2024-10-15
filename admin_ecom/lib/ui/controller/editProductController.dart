import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:admin_ecom/constants.dart';
import 'package:admin_ecom/data/model/categoriemodel.dart';
import 'package:admin_ecom/data/model/colorsmodel.dart';
import 'package:admin_ecom/data/model/producttypemodel.dart';
import 'package:admin_ecom/data/model/sizesmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class EditProductController extends GetxController {
  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print('closed');
  }

  bool everythingIsValid = true;

  int selectedCategorieID = 0;
  int selectedTypeID = 0;
  List<int> selectedColorsIDs = [];
  List<int> selectedSizesIDs = [];
  String productName = '';
  String productDescription = '';
  double productPrice = 0;
  int productStock = 0;

  //loader
  bool isLoading = false;

  // validation of non Text fields
  bool isPictureValid = true;
  bool isCategorieValid = true;
  bool isTypeValid = true;
  bool isColorsValid = true;

  // for types ui

  // cuurent type ( feetwear , tops...)
  String currentType = 'feetwear';
  updateCurrentType(type) {
    if (currentType != type) {
      selectedSizesIDs.clear();
      currentType = type;
      update();
    }
  }

  //image
  File? file;
  // pick image from gallery
  pickImageFromGalley() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      file = File(image.path);
      Get.back();
      update();
    }
  }

  // pick image from camera
  pickImageFromCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      file = File(image.path);
      Get.back();
      update();
    }
  }

  //add product
  editProduct(file, productid, jsonProduct, colors, sizes) async {
    try {
      print(1);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$BASE_URL/api/product/update/$productid'),
      );
      print(2);

      var myFile = await http.MultipartFile.fromPath('product', file!.path);
      print(3);

      request.files.add(myFile);

      // request.fields.addAll({
      //   'product': jsonEncode(jsonProduct),
      //   'colors':  jsonEncode(colors),
      //   'sizes':  jsonEncode(sizes),
      // });
      print(' ak hna          hh');
      final response = await request.send();
      print(response.statusCode);
      // if (response.statusCode != 200) {
      //   isLoading = false;
      //   update();
      //   throw Error();
      // } else {
      //   isLoading = false;
      //   Get.back();
      //   file.deleteSync();
      //   selectedColorsIDs.clear();
      //   selectedSizesIDs.clear();
      //   Get.showSnackbar(GetSnackBar(
      //     message: 'Added Successfully',
      //     animationDuration: Duration(milliseconds: 800),
      //   ));
      //   update();
      // }
    } catch (e) {
      print(e);
      Get.showSnackbar(
          GetSnackBar(message: 'Something wend wrong please try again'));
    }
  }

  List<SizesModel> sizes = [];
  List<SizesModel> shoesSizes = [];
  List<SizesModel> clotheSizes = [];
  List<ColorsModel> colors = [];
  List<CategorieModel> categories = [];
  List<ProductTypeModel> producttypes = [];
  List<DropdownMenuItem<String>>? dopDownItems = [];
  // fetch sizes
  fetchSizes() async {
    try {
      var response = await http.get(Uri.parse('$BASE_URL/api/sizes/'));
      if (response.statusCode != 200) {
        throw new Error();
      } else {
        var json = jsonDecode(response.body);
        var data = json['data'];
        print(data);
        for (var size in data) {
          sizes.add(SizesModel.fromJson(size));
        }
        for (var size in sizes) {
          if (size.label.isNum) {
            shoesSizes.add(size);
          } else {
            clotheSizes.add(size);
          }
        }
        update();
      }
    } catch (e) {
      print(e);
    }
  }

  //fetch colors
  fetchColors() async {
    try {
      var response = await http.get(Uri.parse('$BASE_URL/api/colors/'));
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw new Error();
      } else {
        var json = jsonDecode(response.body);
        var data = json['data'];
        print(data);
        for (var color in data) {
          colors.add(ColorsModel.fromJson(color));
        }
      }
    } catch (e) {
      print('error ccc');
    }
  }

  //fetch categories
  fetchCategories() async {
    try {
      var response = await http.get(Uri.parse('$BASE_URL/api/categorie/'));
      print(response.statusCode);
      if (response.statusCode != 200) {
        throw new Error();
      } else {
        var json = jsonDecode(response.body);
        var data = json['data'];
        print(data);
        for (var categorie in data) {
          categories.add(CategorieModel.fromJson(categorie));
        }
        for (var categorie in categories) {
          dopDownItems!.add(
            DropdownMenuItem(
              child: Text(categorie.categorylabel),
              value: categorie.categorylabel,
              onTap: () {
                selectedCategorieID = categorie.id;
                print(selectedCategorieID);
              },
            ),
          );
        }
        update();
      }
    } catch (e) {
      print('error ccc');
    }
  }

  //fetch colors
  fetchProductTypes() async {
    try {
      var response = await http.get(Uri.parse('$BASE_URL/api/producttype/'));

      if (response.statusCode != 200) {
        throw Error();
      } else {
        var json = jsonDecode(response.body);

        for (var producttype in json) {
          producttypes.add(ProductTypeModel.fromJson(producttype));
        }
        selectedTypeID = producttypes.first.id;
        update();
      }
    } catch (e) {
      print(e);
    }
  }
}
