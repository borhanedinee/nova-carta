class CategoryModel {
  int id;
  String label;
  String icon;

  CategoryModel({
    required this.label,
    required this.icon,
    required this.id,
  });

  // Method to convert JSON to CategoryModel object
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      label: json['label'],
      icon: json['icon'],
      id: json['id'],
    );
  }

  // Method to convert CategoryModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'icon': icon,
      'id': id,
    };
  }
}
