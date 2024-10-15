import 'package:admin_ecom/ui/controller/addProductController.dart';
import 'package:admin_ecom/main.dart';
import 'package:admin_ecom/ui/controller/editProductController.dart';
import 'package:admin_ecom/ui/pallets/colors.dart';
import 'package:admin_ecom/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showPickImageOptions(context, AddProductController controller) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: size.width,
      height: size.height / 4.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => controller.pickImageFromGalley(),
            child: const Column(
              children: [
                Icon(Icons.image, size: 102, color: Colors.grey),
                Text(
                  'Gallery',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox().w(50),
          InkWell(
            onTap: () => controller.pickImageFromCamera(),
            child: const Column(
              children: [
                Icon(Icons.camera_alt, size: 102, color: Colors.grey),
                Text(
                  'Camera',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

showPickImageOptionsEditScreen(context, EditProductController controller) {
  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      width: size.width,
      height: size.height* .3,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => controller.pickImageFromGalley(),
                child: const Column(
                  children: [
                    Icon(Icons.image, size: 102, color: Colors.grey),
                    Text(
                      'Gallery',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox().w(50),
              InkWell(
                onTap: () => controller.pickImageFromCamera(),
                child: const Column(
                  children: [
                    Icon(Icons.camera_alt, size: 102, color: Colors.grey),
                    Text(
                      'Camera',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
          InkWell(
            onTap: () {
              Get.back();
            },
            child: FittedBox(
              child: Container(
                
                width: size.width,
                margin: const EdgeInsets.only(left: 25 , right: 25 , top: 40),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.pramiryColor,
                ),
                child: const Text(
                  'Cancel',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    ),
  );
}
