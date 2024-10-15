import 'package:admin_ecom/constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignupController extends GetxController {
  bool isLoading = false;

  signup(username, password, token) async {
    try {
      isLoading = true;
      update();
      var request = await http.post(Uri.parse('$BASE_URL/api/admin/add'),
          body: {'username': username, 'password': password, 'token': token});
      if (request.statusCode == 200) {
        Get.showSnackbar(
          const GetSnackBar(
            message: 'Signed in successfully',
          ),
        );
      } else {
        throw Error();
      }
      isLoading = false;
      update();
    } catch (e) {
      Get.showSnackbar(
          const GetSnackBar(
            message: 'Something went wrong, please try again',
          ),
        );
      isLoading = false;
      update();
    }
  }
}
