import 'package:ecommerce/main.dart';
import 'package:ecommerce/ui/view/components/profile/orderstatusitem.dart';
import 'package:ecommerce/ui/view/components/profile/settingsItem.dart';
import 'package:ecommerce/ui/view/pages/home/ordersscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //APP BAR
                Container(
                  width: size.width,
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(
                            () => const OrdersScreen(),
                          );
                        },
                        icon: const Icon(Ionicons.bag_check),
                      ),
                      SizedBox(
                        width: size.width * .2,
                      ),
                      const Text(
                        'Profile',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                //PROFILE INFO
                SizedBox(
                  width: size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.asset('assets/pics/man.png')),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                       Text(
                        user!.username,
                        style: TextStyle(
                            fontWeight: FontWeight.w900, fontSize: 18),
                      )
                    ],
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                //MY ORDERS
                // const Padding(
                //   padding: EdgeInsets.only(left: 15, top: 10, bottom: 20),
                //   child: Text(
                //     'My orders',
                //     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                //   ),
                // ),
                // SizedBox(
                //   height: 100,
                //   width: MediaQuery.of(context).size.width,
                //   child: const Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       OrderStatus(
                //           asset: 'assets/pics/delivered.png',
                //           status: 'Delivered'),
                //       OrderStatus(
                //           asset: 'assets/pics/inprogress.png',
                //           status: 'In Progress'),
                //       OrderStatus(
                //           asset: 'assets/pics/pending.png', status: 'Pending')
                //     ],
                //   ),
                // ),

                const SizedBox(
                  height: 30,
                ),

                //SOME SETTINGS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SettingsItem(
                        setting: 'Edit Profile',
                        icon: Icons.person_2_rounded,
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SettingsItem(
                        setting: 'Shipping Adress',
                        icon: Icons.location_on_rounded,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                //LOG OUT BUTTON
                const SizedBox(
                  height: 50,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 15)),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                        onPressed: () {},
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w900),
                        )),
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
