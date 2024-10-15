

import 'package:admin_ecom/main.dart';
import 'package:admin_ecom/utils/extensions.dart';
import 'package:flutter/material.dart';

class EmptyStockWidget extends StatelessWidget {
  final String categorie;

  const EmptyStockWidget({
    super.key, required this.categorie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.7,
        child: Column(
          
          children: [
            SizedBox().h(60),
            Image.asset('assets/emptystockicon.png' , height: 180,),
            Text('OOPS... \nNo products for $categorie.' , textAlign: TextAlign.center, style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold , fontSize: 16),)
          ],
        )
      );
  }
}
