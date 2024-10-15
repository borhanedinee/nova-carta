import 'package:admin_ecom/main.dart';
import 'package:admin_ecom/ui/controller/signupController.dart';
import 'package:admin_ecom/ui/view/screens/loginscreen.dart';
import 'package:admin_ecom/ui/view/widgets/custom_form.dart';
import 'package:admin_ecom/ui/view/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  SignupController signupController = Get.find();

  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // welcoming
                Padding(
                  padding: EdgeInsets.only(left: 15, top: size.height * 0.2),
                  child: const Text(
                    'Hello New Admin',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 30, top: 10),
                  child: Text(
                    'Manage your stock efficiently , please fill your information bellow to get access to your stock.',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                //FORM
                CustomForm(
                  controller: usernameController,
                  hint: 'Enter username',
                  headline: 'Username',
                  isPassword: false,
                  icon: Icons.person_2,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomForm(
                  controller: passwordController,
                  hint: '* * * * * * * * * *',
                  headline: 'Password',
                  isPassword: true,
                  icon: Icons.lock_open,
                ),
                const SizedBox(
                  height: 20,
                ),

                //SIGN IN BUTTON
                GetBuilder<SignupController>(
                  builder: (controller) => CustomButton(
                    buttonText:
                        controller.isLoading ? 'loading ...' : 'Sign up',
                    onPressed: () async {
                      if (usernameController.text == '' ||
                          passwordController.text == '') {
                        Get.showSnackbar(
                          const GetSnackBar(
                            message: 'Pleae fill password and username',
                          ),
                        );
                      } else {
                        signupController.signup(
                          usernameController.text,
                          passwordController.text,
                          token,
                        );
                        // socket.changeStatus();
                        // print('before');
                        // await http.post(Uri.parse('$BASE_URL/borhan'));
                        // print('after');
                        // return Get.to(const RootScreen());
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextButton(
                    child: const Text('Log in ?'),
                    onPressed: () {
                      Get.off(const Login());
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
