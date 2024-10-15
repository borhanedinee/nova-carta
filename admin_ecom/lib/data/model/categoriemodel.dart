class CategorieModel {
  final int id;
  final String categorylabel;

  CategorieModel({required this.id, required this.categorylabel});

  factory CategorieModel.fromJson(Map<String, dynamic> json) {
    return CategorieModel(
      id: json['id'] as int,
      categorylabel: json['categorylabel'] as String,
    );
  }
}
