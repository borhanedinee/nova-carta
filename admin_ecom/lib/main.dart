import 'package:admin_ecom/data/remote/socket_service.dart';
import 'package:admin_ecom/firebase_options.dart';
import 'package:admin_ecom/ui/controller/addProductController.dart';
import 'package:admin_ecom/ui/controller/couponController.dart';
import 'package:admin_ecom/ui/controller/editProductController.dart';
import 'package:admin_ecom/ui/controller/homeController.dart';
import 'package:admin_ecom/ui/controller/signupController.dart';
import 'package:admin_ecom/ui/controller/ordersController.dart';
import 'package:admin_ecom/ui/controller/productController..dart';
import 'package:admin_ecom/ui/controller/stockController.dart';
import 'package:admin_ecom/ui/pallets/colors.dart';
import 'package:admin_ecom/ui/view/screens/addproductscreen.dart';
import 'package:admin_ecom/ui/view/screens/loginscreen.dart';
import 'package:admin_ecom/ui/view/screens/stockscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

String? token;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.notification.request();
  await setupLocalNotifications();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  token = await FirebaseMessaging.instance.getToken();

  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMsg) {
    
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    Get.showSnackbar(GetSnackBar(message: 'Recieved notification'));
    print(message.notification?.body);
    // Show a dialog or display a local notification here
  });
  print("FCM Token: $token");

  runApp(const MyApp());
}

Future<void> setupLocalNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  await FlutterLocalNotificationsPlugin().initialize(initializationSettings);
}

late SocketService socket;

late Size size;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.pramiryColor),
        useMaterial3: true,
      ),
      initialBinding: BindingsBuilder(() {
        socket = SocketService();
        socket.connect();

        Get.lazyPut(() => AddProductController(), fenix: true);
        Get.lazyPut(() => StockController(), fenix: true);
        Get.lazyPut(() => HomeController(), fenix: true);
        Get.put(
          OrdersController(),
        );
        Get.lazyPut(() => CouponController(), fenix: true);
        Get.lazyPut(() => ProductController(), fenix: true);
        Get.lazyPut(() => EditProductController(), fenix: true);
        Get.lazyPut(() => SignupController(), fenix: true);
      }),
      home: const Login(),
    );
  }
}
