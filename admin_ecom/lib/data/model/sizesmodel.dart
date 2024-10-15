class SizesModel {
  final int id;
  final String label;

  SizesModel({required this.id, required this.label});

  factory SizesModel.fromJson(Map<String, dynamic> json) {
    return SizesModel(
      id: json['id'] as int,
      label: json['size'] as String,
    );
  }
}
