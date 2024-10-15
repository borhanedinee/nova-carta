import 'package:admin_ecom/ui/pallets/colors.dart';
import 'package:admin_ecom/ui/view/screens/homescreen.dart';
import 'package:admin_ecom/ui/view/screens/ordersscreen.dart';
import 'package:admin_ecom/ui/view/screens/profilescreen.dart';
import 'package:admin_ecom/ui/view/screens/stockscreen.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => __RootScreenState();
}

class __RootScreenState extends State<RootScreen> {
  int currentPage = 0;
  final List<Widget> pages = [
    const DashboardScreen(),
    const StockScreen(),
    const OrdersScreen(),
    const ProfileScreen(),
  ];
  final List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(icon: Icon(Icons.card_travel_rounded), label: 'Stock'),
    const BottomNavigationBarItem(icon: Icon(Icons.ballot_outlined), label: 'Orders'),
    const BottomNavigationBarItem(icon: Icon(Icons.person_2), label: 'Profile'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        unselectedItemColor: Colors.grey,
        selectedItemColor: AppColors.pramiryColor,
        type: BottomNavigationBarType.fixed,
        items: items,
        currentIndex: currentPage,
      ),
    );
  }
}
