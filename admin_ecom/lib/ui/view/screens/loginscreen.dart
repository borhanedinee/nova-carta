import 'package:admin_ecom/main.dart';
import 'package:admin_ecom/ui/pallets/colors.dart';
import 'package:admin_ecom/ui/view/screens/rootscreen.dart';
import 'package:admin_ecom/ui/view/screens/signupscreen.dart';
import 'package:admin_ecom/ui/view/widgets/custom_form.dart';
import 'package:admin_ecom/ui/view/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class Login extends StatelessWidget {
  const Login({super.key});

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
                    'Hello Admin',
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
                const CustomForm(
                  hint: 'Enter username',
                  headline: 'Username',
                  isPassword: false,
                  icon: Icons.person_2,
                ),
                const SizedBox(
                  height: 10,
                ),
                const CustomForm(
                  hint: '* * * * * * * * * *',
                  headline: 'Password',
                  isPassword: true,
                  icon: Icons.lock_open,
                ),

                const Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: AppColors.pramiryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                //SIGN IN BUTTON
                CustomButton(
                  buttonText: 'Login',
                  onPressed: () {
                    // this is for sending push notif
                    // await http.post(Uri.parse('$BASE_URL/borhan'));

                    // TODO. here u must implement login controller
                    Get.to(const RootScreen());
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextButton(
                    child: const Text('Sign Up ?'),
                    onPressed: () {
                      Get.off( SignUpScreen());
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
