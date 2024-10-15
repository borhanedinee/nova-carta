class CouponModel {
  final int id;
  final String couponLabel;
  final int pourcentage;
  final int period;
  final DateTime createdAt;

  CouponModel({
    required this.id,
    required this.couponLabel,
    required this.pourcentage,
    required this.period,
    required this.createdAt,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'],
      couponLabel: json['couponlabel'],
      pourcentage: json['pourcentage'],
      period: json['period'],
      createdAt: DateTime.parse(json['createdat']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'couponlabel': couponLabel,
      'pourcentage': pourcentage,
      'period': period,
      'createdat': createdAt.toIso8601String(),
    };
  }
}
