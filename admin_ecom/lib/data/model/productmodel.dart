class ProducModel{
  int id;
  String name;
  String description;
  int stock;
  int price;
  DateTime createdAt;
  DateTime updatedAt;
  int type;
  int discount;
  String asset;
  int categorie;
  List<String>? sizes;
  List<String>? colors;

  ProducModel({
    required this.id,
    required this.name,
    required this.description,
    required this.stock,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.discount,
    required this.asset,
    required this.categorie,
    this.sizes,
    this.colors,
  });

  factory ProducModel.fromJson(Map<String, dynamic> json) {
    return ProducModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      stock: json['stock'],
      price: json['price'].toInt(),
      createdAt: DateTime.parse(json['createdat']),
      updatedAt: DateTime.parse(json['updatedat']),
      type: json['type'],
      discount: json['discount'],
      asset: json['asset'],
      categorie: json['categorie'],
      sizes: json.containsKey('sizes')?  (json['sizes'] as String).split(', ') : null,
      colors: json.containsKey('sizes')? (json['colors'] as String).split(', ') : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'stock': stock,
      'price': price,
      'createdat': createdAt.toIso8601String(),
      'updatedat': updatedAt.toIso8601String(),
      'type': type,
      'discount': discount,
      'asset': asset,
      'categorie': categorie,
      'sizes': sizes == null? [] : sizes!.join(', ') ,
      'colors': colors == null ? [] : colors!.join(', '),
    };
  }
}
