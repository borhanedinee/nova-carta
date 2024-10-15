class CouponModel {
  int id;
  String couponLabel;
  int percentage;
  int period;
  DateTime createdAt;

  CouponModel({
    required this.id,
    required this.couponLabel,
    required this.percentage,
    required this.period,
    required this.createdAt,
  });

  // Method to convert JSON to Coupon object
  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'],
      couponLabel: json['couponlabel'],
      percentage: json['pourcentage'],
      period: json['period'],
      createdAt: DateTime.parse(json['createdat']),
    );
  }

  // Method to convert Coupon object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'couponlabel': couponLabel,
      'pourcentage': percentage,
      'period': period,
      'createdat': createdAt.toIso8601String(),
    };
  }
}
