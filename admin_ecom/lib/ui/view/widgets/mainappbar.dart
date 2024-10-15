
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget {
  final String title;

  const MainAppBar({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: Text(title , style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18
        ),),
      ),
    );
  }
}