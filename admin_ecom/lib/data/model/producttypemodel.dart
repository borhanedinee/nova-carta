class ProductTypeModel {
  final int id;
  final String type;

  ProductTypeModel({required this.id, required this.type});

  factory ProductTypeModel.fromJson(Map<String, dynamic> json) {
    return ProductTypeModel(
      id: json['id'] as int,
      type: json['type'] as String,
    );
  }
}
