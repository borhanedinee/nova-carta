import 'package:ecommerce/dataa/models/user_model.dart';
import 'package:ecommerce/firebase_options.dart';
import 'package:ecommerce/ui/controllers/cart_controller.dart';
import 'package:ecommerce/ui/controllers/category_controller.dart';
import 'package:ecommerce/ui/controllers/checkout_controller.dart';
import 'package:ecommerce/ui/controllers/favourites_controller.dart';
import 'package:ecommerce/ui/controllers/home_controller.dart';
import 'package:ecommerce/ui/controllers/login_controller.dart';
import 'package:ecommerce/ui/controllers/orders_controller.dart';
import 'package:ecommerce/ui/controllers/product_controller.dart';
import 'package:ecommerce/ui/controllers/search_controller.dart';
import 'package:ecommerce/ui/controllers/signup_controller.dart';
import 'package:ecommerce/ui/pallets/colors.dart';
import 'package:ecommerce/ui/view/pages/root.dart';
import 'package:ecommerce/ui/view/pages/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

User? user;
String? token;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Permission.notification.request();
  FirebaseMessaging.instance
      .getInitialMessage()
      .then((RemoteMessage? remoteMsg) {});

  token = await FirebaseMessaging.instance.getToken();
  print("FCM Token: $token");
  runApp(const MainApp());
}

Size? size;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return GetMaterialApp(
      theme: ThemeData(primarySwatch: AppColors.primaryColor),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(
          () => HomeController(),
        );
        Get.lazyPut(() => CategoryController(), fenix: true);
        Get.lazyPut(() => SearchScreenController(), fenix: true);
        Get.lazyPut(() => ProductController(), fenix: true);
        Get.lazyPut(() => CheckoutController(), fenix: true);
        Get.lazyPut(() => OrdersController(), fenix: true);
        Get.lazyPut(() => FavoritesController(), fenix: true);
        Get.lazyPut(() => SignupController(), fenix: true);
        Get.lazyPut(() => LoginController(), fenix: true);
        Get.lazyPut(
          () => CartController(),
        );
      }),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: OnBoarding(),
      ),
    );
  }
}
