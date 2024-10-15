import 'package:ecommerce/dataa/models/productmodel.dart';

class CartProductModel extends ProducModel {
  int user;
  int product;
  int quantity;
  String color;
  String size;

  CartProductModel({
    required int id,
    required String name,
    required String description,
    required int stock,
    required double price,
    required DateTime createdAt,
    required DateTime updatedAt,
    required int type,
    required int discount,
    required String asset,
    required int categorie,
    required List<String> sizes,
    required List<String> colors,
    required this.user,
    required this.product,
    required this.quantity,
    required this.color,
    required this.size,
  }) : super(
            id: id,
            name: name,
            description: description,
            stock: stock,
            price: price,
            createdAt: createdAt,
            updatedAt: updatedAt,
            type: type,
            discount: discount,
            asset: asset,
            categorie: categorie,
            sizes: sizes,
            colors: colors);

  factory CartProductModel.fromJson(Map<String, dynamic> json) {
    return CartProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      stock: json['stock'],
      price: json['price'].toDouble(),
      createdAt: DateTime.parse(json['createdat']),
      updatedAt: DateTime.parse(json['updatedat']),
      type: json['type'],
      discount: json['discount'],
      asset: json['asset'],
      categorie: json['categorie'],
      sizes: (json['sizes'] as String).split(', '),
      colors: (json['colors'] as String).split(', '),
      user: json['user'],
      product: json['product'],
      quantity: json['quantity'],
      color: json['color'],
      size: json['size'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final data = super.toJson();
    data.addAll({
      'user': user,
      'product': product,
      'quantity': quantity,
      'color': color,
      'size': size,
    });
    return data;
  }
}
