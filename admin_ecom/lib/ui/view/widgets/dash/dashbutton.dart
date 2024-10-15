
import 'package:admin_ecom/main.dart';
import 'package:flutter/material.dart';

class DashButton extends StatelessWidget {
  final Function() onTap;
  
  final Color color;
  
  final IconData icon;
  
  final String text;

  const DashButton({
    super.key, required this.onTap, required this.color, required this.icon, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
        width: size.width * 0.5 - 30,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(icon , color: Colors.white, ),
          
            Text(text , style: TextStyle(color: Colors.white , fontWeight: FontWeight.bold , fontSize: 12),)
          ],
        ),
      ),
    );
  }
}
