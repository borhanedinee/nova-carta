import 'package:ecommerce/main.dart';
import 'package:ecommerce/ui/controllers/cart_controller.dart';
import 'package:ecommerce/ui/controllers/checkout_controller.dart';
import 'package:ecommerce/ui/pallets/colors.dart';
import 'package:ecommerce/ui/view/components/card/coupon_item.dart';
import 'package:ecommerce/ui/view/components/emptystock.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<dynamic> showDeletingAllCartItemsDialog(
    BuildContext context, CartController controller) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.only(top: 100, left: 30, right: 20),
      alignment: Alignment.topRight,
      child: FittedBox(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'You really want to delete all the items in the cart ?',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: FittedBox(
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey),
                          child: const Center(child: Text('No')),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    InkWell(
                      onTap: () {
                        // delete
                        controller.deleteAllCartItems(user!.id);
                        Get.back();
                      },
                      child: FittedBox(
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red),
                          child: const Center(child: Text('Yes')),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Future<dynamic> showDeletingSingleItemDialog(
    BuildContext context, CartController controller, cartItemID, userID) {
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.only(top: 130, left: 30, right: 40),
      alignment: Alignment.topRight,
      child: FittedBox(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'You really want to delete the item from your cart ?',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: FittedBox(
                        child: Container(
                          width: 100,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.grey),
                          child: const Center(child: Text('No')),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    GetBuilder<CartController>(
                      builder: (controller) => InkWell(
                        onTap: () {
                          controller.deleteSingleCartItem(cartItemID, userID);
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red),
                          child: Center(
                            child: controller.isDeletingSingleCartItemLoading
                                ? const SizedBox(
                                    height: 5,
                                    width: 5,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text('Yes'),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Future<dynamic> showCoupons(
    BuildContext context, Size size, CartController controller) {
  return showModalBottomSheet(
    isDismissible: false,
    context: context,
    builder: (context) => GetBuilder<CartController>(
      builder: (controller) => FittedBox(
        child: SizedBox(
          width: size.width,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8, bottom: 30),
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, bottom: 10, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Select coupon',
                        style: TextStyle(color: Colors.grey),
                      ),
                      IconButton(
                        onPressed: () {
                          controller.turnOffCoupons();
                          Get.back();
                        },
                        icon: const Icon(Icons.close),
                      )
                    ],
                  ),
                ),
              ),
              controller.isFetchingCouponsLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : controller.coupons.isEmpty
                      ? const Text('No available coupons for the moment.')
                      : Column(
                          children:
                              List.generate(controller.coupons.length, (index) {
                            final coupon = controller.coupons[index];
                            return CouponItem(
                              coupon: coupon,
                            );
                          }),
                        ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                onPressed: () {
                  if (controller.seletedCoupon != '') {
                    controller.applyCoupon();
                  }
                },
                child: GetBuilder<CartController>(
                  builder: (controller) => FittedBox(
                    child: Container(
                      width: size.width,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: controller.seletedCoupon == ''
                              ? Colors.grey.shade400
                              : AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: controller.isApplyingCouponLoading
                            ? const SizedBox(
                                height: 10,
                                width: 10,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Activate',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              if (controller.seletedCoupon != '')
                MaterialButton(
                  onPressed: () {
                    // TODO turn off all coupons
                    controller.turnOffCoupons();
                    Get.back();
                  },
                  child: FittedBox(
                    child: Container(
                      width: size.width,
                      height: 40,
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text(
                          'Turn off coupons',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Future<dynamic> checkoutBottomSheet(
  BuildContext context,
  TextEditingController fullNameController,
  TextEditingController phoneController,
  TextEditingController locationController,
) {
  return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (context) {
        return GetBuilder<CheckoutController>(
          builder: (checkoutController) => GetBuilder<CartController>(
            builder: (cartController) => Container(
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: const BoxDecoration(
                  // color: ,
                  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.shade700),
                    ),
                  ),
                  const Padding(
                      padding: EdgeInsets.only(left: 30, top: 20),
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      )),
                  const Padding(
                    padding: EdgeInsets.only(left: 30, top: 5, right: 20),
                    child: Text(
                      'Verify your information bellow. And choose the payment method you want.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 5),
                          child: Text(
                            'Username',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: TextFormField(
                            controller: fullNameController,
                            decoration: InputDecoration(
                                hintText: 'Full name',
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                contentPadding: const EdgeInsets.only(left: 10),
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 5),
                          child: Text(
                            'Phone number',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: TextFormField(
                            controller: phoneController,
                            decoration: InputDecoration(
                                hintText: 'Phone number',
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                contentPadding: const EdgeInsets.only(left: 10),
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 5),
                          child: Text(
                            'Shipping address',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: TextFormField(
                            controller: locationController,
                            decoration: InputDecoration(
                                hintText: 'Shipping adress',
                                fillColor: Colors.grey.shade200,
                                filled: true,
                                contentPadding: const EdgeInsets.only(left: 10),
                                border: InputBorder.none),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 5),
                          child: Text(
                            'Payment method',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            color: Colors.grey.shade200,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButton<String>(
                              isExpanded: true,
                              value: cartController.selectedPaymentMethod,
                              icon: const Icon(
                                Icons.arrow_drop_down_sharp,
                                size: 30,
                              ),
                              underline:
                                  const SizedBox(), // Remove the underline
                              onChanged: (String? newValue) {
                                cartController.selectedPaymentMethod =
                                    newValue!;
                                cartController.update();
                              },
                              items: cartController.paymentMethods
                                  .map((String method) {
                                return DropdownMenuItem<String>(
                                  value: method,
                                  child: Text(method),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 10, bottom: 5),
                          child: Text(
                            'Delivery method',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 13),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.grey.shade200,
                            child: DropdownButton<String>(
                              isExpanded: true,

                              value: cartController.selectedDeliveryMethod,
                              icon: const Icon(
                                Icons.arrow_drop_down_sharp,
                                size: 30,
                              ),
                              underline:
                                  const SizedBox(), // Remove the underline
                              onChanged: (String? newValue) {
                                print(cartController.selectedDeliveryMethod);

                                cartController.selectedDeliveryMethod =
                                    newValue!;
                                print(cartController.selectedDeliveryMethod);
                                cartController.update();
                              },
                              items: cartController.deliveryMethods
                                  .map((String method) {
                                return DropdownMenuItem<String>(
                                  value: method,
                                  child: Text(method),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: const MaterialStatePropertyAll(
                              AppColors.primaryColor),
                          padding: const MaterialStatePropertyAll(
                              EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 7)),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        onPressed: () {
                          // TODO: send order
                          if (fullNameController.text == '' ||
                              phoneController.text == '' ||
                              locationController.text == '' ||
                              cartController.selectedPaymentMethod == '' ||
                              cartController.selectedDeliveryMethod == '') {
                            Get.showSnackbar(const GetSnackBar(
                              message:
                                  'Please make you sure you have filled all the required informations',
                            ));
                          } else {
                            checkoutController.sendOrder(
                              user!.id,
                              fullNameController.text,
                              phoneController.text,
                              locationController.text,
                              cartController.selectedDeliveryMethod,
                              cartController.selectedPaymentMethod,
                              cartController.selectedCouponPourcentage,
                            );
                          }
                        },
                        child: checkoutController.isSendingOrderLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'Send order',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300),
                              )),
                  )
                ],
              ),
            ),
          ),
        );
      },
      enableDrag: true);
}
