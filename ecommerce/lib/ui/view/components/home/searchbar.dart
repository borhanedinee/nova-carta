import 'package:ecommerce/ui/view/pages/home/searchscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeSearch extends StatelessWidget {
  final bool readOnly;

  final Function()? onTap;

  final Function(String)? onSubmit;

  final FocusNode? focussedNode;

  final Function(String)? onChanged;

  final TextEditingController? controller;

  const HomeSearch({
    super.key,
    required this.readOnly,
    this.onTap,
    this.onSubmit,
    this.focussedNode,
    this.onChanged, this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextFormField(
          controller: controller,
          onChanged: onChanged,
          focusNode: focussedNode,
          readOnly: readOnly,
          onTap: onTap,
          onFieldSubmitted: onSubmit,
          decoration: InputDecoration(
              fillColor: Colors.grey.shade200,
              filled: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              prefixIcon: const Icon(Icons.search, size: 20),
              hintText: 'Search items',
              border: InputBorder.none),
        ),
      ),
    );
  }
}
