import 'package:flutter/material.dart';

extension Sizes on SizedBox {
  SizedBox w (double wid){
    return SizedBox(
      width: wid,
    );
  }
  SizedBox h (double hei){
    return SizedBox(
      height: hei,
    );
  }
}