
import 'package:admin_ecom/ui/pallets/colors.dart';
import 'package:flutter/material.dart';

class ProductType extends StatelessWidget {
  final Function()? onTap;
  
  final String type;
  
  final Color? backgroundColor;

  const ProductType({
    super.key, this.onTap, required this.type, this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent ,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.pramiryColor.withOpacity(0.4) , width: 0.3),
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10)
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24 , vertical: 8),
          child:  Text(type),
        ),
      ),
    );
  }
}
