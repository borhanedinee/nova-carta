import 'package:ecommerce/dataa/models/coupon_model.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/ui/controllers/cart_controller.dart';
import 'package:ecommerce/ui/pallets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponItem extends StatelessWidget {
  const CouponItem({
    super.key,
    required this.coupon,
  });

  final CouponModel coupon;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      builder: (controller) => MaterialButton(
        onPressed: () {
          if (controller.seletedCoupon != coupon.couponLabel) {
            controller.selectedCouponPourcentage = coupon.percentage;
            controller.seletedCoupon = coupon.couponLabel;
            controller.update();
          } else {
            controller.selectedCouponPourcentage = coupon.percentage;

            controller.seletedCoupon = '';
            controller.update();
          }
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          height: 50,
          width: size!.width,
          decoration: BoxDecoration(
            color: controller.seletedCoupon == coupon.couponLabel
              ? AppColors.primaryColor.withOpacity(.3)
              : null,
              borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                coupon.couponLabel,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
              ),
              Text(
                '${coupon.percentage} %',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
