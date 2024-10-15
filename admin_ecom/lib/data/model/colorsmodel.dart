class ColorsModel {
  final int id;
  final String color;

  ColorsModel({required this.id, required this.color});

  factory ColorsModel.fromJson(Map<String, dynamic> json) {
    return ColorsModel(
      id: json['id'] as int,
      color: json['color'] as String,
    );
  }
}
