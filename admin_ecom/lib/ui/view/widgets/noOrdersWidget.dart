
import 'package:admin_ecom/main.dart';
import 'package:admin_ecom/utils/extensions.dart';
import 'package:flutter/material.dart';

class NoOrdersWidget extends StatelessWidget {
  final String? status;

  const NoOrdersWidget({
    super.key, this.status,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: status == null ? size.height * .53 : size.height - 192,
        width: size.width,
        child: Column(
          children: [
            const SizedBox().h(60),
            Image.asset('assets/noorders.png' , height: 250,),
            Text( status != null? 'OPSSS... \nNo $status orders for the moment.' : 'OPSSS... \nNo orders for the moment.' , textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold) ,)
          ],
        ),
      );
  }
}
