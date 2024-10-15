import 'package:ecommerce/ui/pallets/colors.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'home/cartscreen.dart';
import 'home/homescreen.dart';
import 'home/favoritesscreen.dart';
import 'home/profilescreen.dart';

class Root extends StatefulWidget {
  Root({super.key});

  @override
  State<Root> createState() => _rootState();
}

class _rootState extends State<Root> {
  int currentpage = 0;

  List<Widget> body = [
    HomeScreen(),
    FavoritesScreen(),
    Builder(builder: (context) {
      return CartScreen();
    }),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[currentpage],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: TextStyle(fontSize: 12),
        unselectedLabelStyle: TextStyle(fontSize: 12),
        showUnselectedLabels: false,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        currentIndex: currentpage,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.primaryColor.withOpacity(.4),
        onTap: (value) {
          setState(() {
            currentpage = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.home_outline,
              size: 18,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.heart_outline,
              size: 20,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.cart_outline,
              size: 20,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Ionicons.person_outline,
              size: 20,
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
