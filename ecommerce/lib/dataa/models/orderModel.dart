import 'dart:convert';

import 'package:ecommerce/dataa/models/orderedProductsModel.dart';

class OrderModel {
  int orderInfoId;
  int phone;
  String location;
  String deliveryMethod;
  String paymentMethod;
  double discount;
  DateTime orderedAt;
  String status;
  String orderOwner;
  String avatar;
  List<OrderedProductModel> products;

  OrderModel({
    required this.orderInfoId,
    required this.phone,
    required this.location,
    required this.deliveryMethod,
    required this.paymentMethod,
    required this.discount,
    required this.orderedAt,
    required this.status,
    required this.orderOwner,
    required this.avatar,
    required this.products,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderInfoId: json['orderinfoid'],
      phone: json['phone'],
      location: json['location'],
      deliveryMethod: json['deliverymethod'],
      paymentMethod: json['paymentmethod'],
      discount: json['discount'].toDouble(),
      orderedAt: DateTime.parse(json['orderedAt']),
      status: json['status'],
      orderOwner: json['orderOwner'],
      avatar: json['avatar'],
      products: (json['products'] as List)
          .map((productJson) => OrderedProductModel.fromJson(productJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderinfoid': orderInfoId,
      'phone': phone,
      'location': location,
      'deliverymethod': deliveryMethod,
      'paymentmethod': paymentMethod,
      'discount': discount,
      'orderedAt': orderedAt.toIso8601String(),
      'status': status,
      'orderOwner': orderOwner,
      'avatar': avatar,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
