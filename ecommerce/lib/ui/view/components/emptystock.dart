import 'package:ecommerce/main.dart';
import 'package:flutter/material.dart';

class EmptyStock extends StatelessWidget {
  const EmptyStock({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size!.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50,),
            Image.asset(
              'assets/pics/emptystock.png',
              height: 180,
            ),
            const SizedBox(height: 15,),

            const Text(
              'No corresponding products\n in stock',
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
