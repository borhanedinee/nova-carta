import 'dart:convert';

import 'package:ecommerce/constants.dart';
import 'package:ecommerce/dataa/models/user_model.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/ui/view/pages/root.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  bool isLoading = false;

  login(username, password) async {
    try {
      isLoading = true;
      update();
      var req = await http.post(Uri.parse('$BASE_URL/api/user/login'), body: {
        'username': username,
        'password': password,
      });
      if (req.statusCode == 200) {
        isLoading = false;
        update();
        var response = jsonDecode(req.body);
        if (response['fetch'] == 0) {
          Get.showSnackbar(const GetSnackBar(
            message: 'No matching credentials found',
          ));
        } else {
          user = User.fromJson(response['user']);

          Get.showSnackbar( GetSnackBar(
            message: 'Logged in successfully ${user!.username}',
          ));

          Get.off(Root());


        }
      } else {
        throw Error();
      }
    } catch (e) {
      isLoading = false;
      update();
      Get.showSnackbar(
        const GetSnackBar(
          message: 'Failed to login, please try again.',
        ),
      );
    }
  }
}
