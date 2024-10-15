
import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  final String header;

  const CustomHeader({
    super.key, required this.header,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
       padding: const EdgeInsets.only(left: 25, top: 20),
       child: Text(
         header,
         style: const TextStyle(fontWeight: FontWeight.bold , color: Colors.black),
       ),
     );
  }
}
