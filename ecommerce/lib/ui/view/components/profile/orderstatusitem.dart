import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';

class OrderStatus extends StatelessWidget {
  final String asset;

  final String status;

  const OrderStatus({super.key, required this.asset, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade200, borderRadius: BorderRadius.circular(80)),
      height: 100,
      width: size!.width * 0.25,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            child: Image.asset(asset),
          ),
          Text(
            status,
            style: const TextStyle(fontWeight: FontWeight.bold , fontSize: 10),
          )
        ],
      ),
    );
  }
}
