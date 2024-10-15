import 'package:ecommerce/constants.dart';
import 'package:ecommerce/ui/view/pages/auth/login.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  bool isLoading = false;

  signup(username, password, email, token) async {
    try {
      isLoading = true;
      update();
      var req = await http.post(Uri.parse('$BASE_URL/api/user/add'), body: {
        'username': username,
        'password': password,
        'email': email,
        'token': token,
      });
      if (req.statusCode == 200) {
        isLoading = false;
        update();
        Get.showSnackbar(
          GetSnackBar(
            message:
                'Signed in successfully, login to your account to continue',
          ),
        );
        Get.off(Login());
      } else {
        throw Error();
      }
    } catch (e) {
      isLoading = false;
      update();
      Get.showSnackbar(
        GetSnackBar(
          message: 'Something went wrong , please try again.',
        ),
      );
    }
  }
}
