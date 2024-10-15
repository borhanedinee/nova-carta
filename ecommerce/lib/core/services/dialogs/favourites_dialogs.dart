
import 'package:ecommerce/main.dart';
import 'package:ecommerce/ui/controllers/favourites_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> showDeletingAllFavoritesItemsDialog(
    BuildContext context, FavoritesController controller) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.only(top: 100, left: 30, right: 20),
      alignment: Alignment.topRight,
      child: FittedBox(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'You really want to delete all the items in the cart ?',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: FittedBox(
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey),
                          child: const Center(child: Text('No')),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    InkWell(
                      onTap: () {
                        // delete
                        controller.deleteAllFavouritesItems(user!.id);
                        Get.back();
                      },
                      child: FittedBox(
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red),
                          child: const Center(child: Text('Yes')),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
