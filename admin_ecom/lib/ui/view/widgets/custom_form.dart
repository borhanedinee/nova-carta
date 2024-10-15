import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  final String hint;

  final String headline;

  final IconData? icon;

  final bool isPassword;

  final int? maxLines;

  final TextEditingController? controller;

  final String? Function(String?)? validator;

  final TextInputType? keyboardtype;

  const CustomForm(
      {super.key,
      required this.hint,
      required this.headline,
      this.icon,
      this.maxLines,
      required this.isPassword,
      this.controller,
      this.validator,
      this.keyboardtype});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25),
          child: Text(
            headline,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: TextFormField(
              
              validator: validator,
              controller: controller,
              maxLines: maxLines,
              keyboardType: keyboardtype,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 7 ,horizontal: 7),
                hintText: hint,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                ),
                prefixIcon: icon != null
                    ? Icon(
                        icon,
                        color: Colors.grey,
                      )
                    : null,
                fillColor: Colors.grey.shade200,
                filled: true,
                border: InputBorder.none,
                suffixIcon: isPassword
                    ? Icon(
                        Icons.visibility_rounded,
                        color: Colors.grey,
                      )
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
