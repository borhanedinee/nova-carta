import 'package:admin_ecom/ui/controller/couponController.dart';
import 'package:admin_ecom/main.dart';
import 'package:admin_ecom/data/model/couponmodel.dart';
import 'package:admin_ecom/ui/view/widgets/coupon/recentcoupon.dart';
import 'package:admin_ecom/ui/view/widgets/custom_form.dart';
import 'package:admin_ecom/ui/view/widgets/customappbar.dart';
import 'package:admin_ecom/ui/view/widgets/custombutton.dart';
import 'package:admin_ecom/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponScreen extends StatefulWidget {
  const CouponScreen({super.key});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController couponLabelController;
  late TextEditingController couponPourcentageController;
  late TextEditingController couponPeriodController;
  CouponController couponController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    couponLabelController = TextEditingController();
    couponPourcentageController = TextEditingController();
    couponPeriodController = TextEditingController();
    couponController.fetchCoupns();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: GetBuilder<CouponController>(
            builder: (controller) => Column(
              children: [
                const CustomAppBar(title: 'Coupons'),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 25, top: 30),
                            child: Text(
                              'Recent Coupons',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          //RECENT COUPONS
                          controller.isFetchingCouponLoading
                              ? const SizedBox(
                                  height: 220,
                                  child: Center(child: CircularProgressIndicator()),
                                )
                              : controller.coupons.isEmpty
                                  ? SizedBox(
                                      width: size.width,
                                      height: 220,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const SizedBox().h(30),
                                          Image.asset(
                                            'assets/nocoupon.png',
                                            height: 100,
                                          ),
                                          const SizedBox().h(15),
                                          const Text(
                                            'OPSS... No recent coupons found',
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      ))
                                  : Column(
                                      children: List.generate(
                                        controller.coupons.length,
                                        (index) {
                                          CouponModel coupon =
                                              controller.coupons[index];
                                          return RecentCoupon(
                                            coupon: coupon,
                                          );
                                        },
                                      ),
                                    ),
                          const SizedBox(
                            height: 20,
                          ),
                          //ADD COUPON
                          const Padding(
                            padding: EdgeInsets.only(left: 25, bottom: 15),
                            child: Text(
                              'Add coupon',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          CustomForm(
                            validator: (p0) {
                              if (p0 == '') {
                                return 'Must not be empty';
                              }
                              return null;
                            },
                            controller: couponLabelController,
                            hint: 'Enter coupon',
                            headline: 'Coupon',
                            isPassword: false,
                            icon: Icons.discount_outlined,
                          ),
                          CustomForm(
                            validator: (p0) {
                              if (p0! == '') {
                                return 'Must not be empty';
                              }
                              if (!p0.isNum) {
                                return 'Must be a pourcentage ( between 1 and 100 )';
                              }
                              return null;
                            },
                            controller: couponPourcentageController,
                            hint: 'Enter coupon\'s pourcentage',
                            headline: 'Pourcentage',
                            isPassword: false,
                            icon: Icons.confirmation_number_outlined,
                          ),
                          CustomForm(
                            validator: (p0) {
                              if (p0! == '') {
                                return 'Must not be empty';
                              }
                              if (!p0.isNum) {
                                return 'Must be a number';
                              }
                              return null;
                            },
                            controller: couponPeriodController,
                            hint: 'Enter coupon\'s period ( hours )',
                            headline: 'Period',
                            isPassword: false,
                            icon: Icons.alarm,
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          //ADD BUTTON
                          CustomButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                await controller.addCoupon({
                                  'label': couponLabelController.text,
                                  'pourcentage':
                                      couponPourcentageController.text,
                                  'period': couponPeriodController.text,
                                });
                                couponLabelController.text = '';
                                couponPeriodController.text = '';
                                couponPourcentageController.text = '';
                              }
                            },
                            child: controller.isAddButtonLoading
                                ? const SizedBox(
                                    height: 10,
                                    width: 10,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'Add coupon',
                                    style: TextStyle(color: Colors.white),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
