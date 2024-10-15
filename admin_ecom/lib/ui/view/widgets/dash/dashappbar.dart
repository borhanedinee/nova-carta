
import 'package:admin_ecom/main.dart';
import 'package:admin_ecom/ui/pallets/colors.dart';
import 'package:flutter/material.dart';

class DahboardAppBar extends StatelessWidget {
  const DahboardAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5 , right: 5 , top: 15),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_active_outlined , color: AppColors.pramiryColor,),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: size.width * .7,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  fillColor: Colors.grey.shade200,
                  hintText: 'Search order',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  border: InputBorder.none,
                  prefixIcon: const Icon(Icons.search_rounded),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10,),
          SizedBox(
            width: size.width * 0.1,
            child: CircleAvatar(
              radius: 30,
              backgroundColor: AppColors.pramiryColor.withOpacity(0.7),
              child: const Text('B'),
            ),
          ),
        ],
      ),
    );
  }
}
