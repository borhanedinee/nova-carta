class OrderedProductModel {
  int quantity;
  String productName;
  String productDescription;
  double productPrice;
  double productDiscount;
  String productAsset;
  String productColor;
  String productSize;
  String productCategory;
  String productType;

  OrderedProductModel({
    required this.quantity,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productDiscount,
    required this.productAsset,
    required this.productColor,
    required this.productSize,
    required this.productCategory,
    required this.productType,
  });

  factory OrderedProductModel.fromJson(Map<String, dynamic> json) {
    return OrderedProductModel(
      quantity: json['quantity'],
      productName: json['productName'],
      productDescription: json['productDescription'],
      productPrice: json['productPrice'].toDouble(),
      productDiscount: json['productDiscount'].toDouble(),
      productAsset: json['productAsset'],
      productColor: json['productColor'],
      productSize: json['productSize'],
      productCategory: json['productCategory'],
      productType: json['productType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quantity': quantity,
      'productName': productName,
      'productDescription': productDescription,
      'productPrice': productPrice,
      'productDiscount': productDiscount,
      'productAsset': productAsset,
      'productColor': productColor,
      'productSize': productSize,
      'productCategory': productCategory,
      'productType': productType,
    };
  }
}
