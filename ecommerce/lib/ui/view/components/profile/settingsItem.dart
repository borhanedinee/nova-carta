import 'package:flutter/material.dart';

class SettingsItem extends StatelessWidget {
  final Function()? onTap;

  final IconData? icon;

  final String setting;

  const SettingsItem({super.key, this.onTap, this.icon, required this.setting});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.black54,
                  size: 24,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  setting,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                      fontSize: 16),
                ),
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.black54,
            )
          ],
        ),
      ),
    );
  }
}
