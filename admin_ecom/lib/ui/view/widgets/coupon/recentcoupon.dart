import 'package:admin_ecom/ui/controller/couponController.dart';
import 'package:admin_ecom/main.dart';
import 'package:admin_ecom/data/model/couponmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RecentCoupon extends StatelessWidget {
  final CouponModel coupon;

  const RecentCoupon({
    super.key,
    required this.coupon,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponController>(
      builder: (controller) => Container(
        padding: const EdgeInsets.only(left: 15),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
        height: 60,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //INFOS
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      coupon.couponLabel,
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 18),
                    ),
                    const Text(
                      '   --   ',
                      style:
                          TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
                    ),
                    Text(
                      '${coupon.pourcentage} %',
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 18),
                    ),
                  ],
                ),
                Text('Expires on : ${formattedDate(
                  coupon.createdAt.add(
                    Duration(hours: coupon.period),
                  ),
                )}')
              ],
            ),
            //ICONS
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                ),
                IconButton(
                  icon: controller.isDeleteButtonLoading
                      ? const SizedBox(
                          height: 10,
                          width: 10,
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ),
                        )
                      : const Icon(
                          Icons.delete_rounded,
                          color: Colors.red,
                        ),
                  onPressed: () {
                    controller.deleteCoupon(coupon.id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  formattedDate(date) {
    DateFormat format = DateFormat('yyyy-MM-dd HH:mm');
    return format.format(date);
  }
}
