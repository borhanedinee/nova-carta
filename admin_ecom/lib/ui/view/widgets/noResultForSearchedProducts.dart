
import 'package:admin_ecom/main.dart';
import 'package:admin_ecom/utils/extensions.dart';
import 'package:flutter/material.dart';

class NoResult extends StatelessWidget {
  

  const NoResult({
    super.key, 
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height - 230,
        width: size.width,
        child: Column(
          children: [
            const SizedBox().h(70),
            Image.asset('assets/noorders.png' , height: 250,),
            Text( 'OPSSS... \nNo matched result on stock.' , textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold) ,)
          ],
        ),
      );
  }
}
