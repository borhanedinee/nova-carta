import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';

class NoOrdersWidget extends StatelessWidget {
  final String? status;

  const NoOrdersWidget({
    super.key,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: status == null ? size!.height * .53 : size!.height - 230,
      width: size!.width,
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Image.asset(
            'assets/pics/emptystock.png',
            height: 250,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            status != null
                ? 'You have no $status orders \nfor the moment.'
                : 'OPSSS... \nNo orders for the moment.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}
