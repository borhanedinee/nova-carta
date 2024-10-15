
import 'package:admin_ecom/main.dart';
import 'package:admin_ecom/ui/pallets/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function() onPressed;
  
  final String? buttonText;
  
  final Widget? child;

  const CustomButton({
    super.key, required this.onPressed, this.buttonText, this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      margin: const EdgeInsets.symmetric(horizontal: 15 , vertical: 7),
      child: ElevatedButton(
        onPressed: onPressed,
        style: const ButtonStyle(
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            backgroundColor: MaterialStatePropertyAll(
                AppColors.pramiryColor)),
        child:  child ?? Text(
          buttonText!,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
