class ProductTypeModel {
  int id;
  String type;

  ProductTypeModel({
    required this.id,
    required this.type,
  });

  // Method to convert JSON to ProductTypeModel object
  factory ProductTypeModel.fromJson(Map<String, dynamic> json) {
    return ProductTypeModel(
      id: json['id'],
      type: json['type'],
    );
  }

  // Method to convert ProductTypeModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
    };
  }
}
