import 'package:ecommerce/core/services/dialogs/cart_dialogs.dart';
import 'package:ecommerce/main.dart';
import 'package:ecommerce/ui/controllers/cart_controller.dart';
import 'package:ecommerce/ui/controllers/checkout_controller.dart';
import 'package:ecommerce/ui/view/components/card/cartitem.dart';
import 'package:ecommerce/ui/view/components/card/empty_cart.dart';
import 'package:ecommerce/ui/view/components/card/orderdetails.dart';
import 'package:ecommerce/ui/pallets/colors.dart';
import 'package:ecommerce/ui/view/shimmers/cart_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartState();
}

class _CartState extends State<CartScreen> {
  CheckoutController checkoutController = Get.find();

  CartController cartController = Get.find();

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullNameController.dispose();
    phoneController.dispose();
    locationController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fullNameController.text = user!.username;
    phoneController.text = user!.avatar;
    locationController.text = user!.email;
    cartController.fetchDeliveryMethods();
    cartController.fetchPaymentMethods();
    cartController.fetchCartProducts(user!.id, true);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<CartController>(
          builder: (controller) => Container(
            width: size.width,
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: size.width,
                  child: const Text(
                    'Cart',
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await cartController.fetchCartProducts(user!.id, true);
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          //ITEMS ADDED TO CART

                          controller.isFetchingCartProductsLoading
                              ? const CartShimmer()
                              : controller.cartProducts.isEmpty
                                  ? const EmptyCart()
                                  : Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                  'Products you added to the cart'),
                                              IconButton(
                                                onPressed: () {
                                                  showDeletingAllCartItemsDialog(
                                                      context, controller);
                                                },
                                                icon: controller
                                                        .isDeletingAllCartItemsLoading
                                                    ? const SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child:
                                                            CircularProgressIndicator(),
                                                      )
                                                    : const Icon(
                                                        Icons.delete_outlined,
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        ...List.generate(
                                          controller.cartProducts.length,
                                          (index) {
                                            final product =
                                                controller.cartProducts[index];
                                            return CartItemView(
                                              product: product,
                                            );
                                          },
                                        ),
                                      ],
                                    ),

                          const SizedBox(
                            height: 10,
                          ),

                          controller.cartProducts.isEmpty
                              ? const SizedBox()
                              : Column(
                                  children: [
                                    //ORDER DETAILS
                                    const OrderDetails(),

                                    const SizedBox(
                                      height: 15,
                                    ),

                                    //PROMO CODE
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.grey.shade200),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: size.width - 50,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.discount_outlined,
                                                      color: Colors.black54,
                                                      size: 20,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      controller.seletedCoupon ==
                                                              ''
                                                          ? 'Coupon'
                                                          : controller
                                                              .seletedCoupon,
                                                      style: const TextStyle(
                                                          color: Colors.black54,
                                                          fontSize: 14),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    showCoupons(context, size,
                                                        controller);
                                                    controller.fetchCoupons();
                                                  },
                                                  icon: const Icon(
                                                    Icons.arrow_drop_down_sharp,
                                                    size: 35,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(
                                      height: 15,
                                    ),

                                    //CHECKOIT BUTTON
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          if (controller
                                              .cartProducts.isNotEmpty) {
                                            checkoutBottomSheet(
                                              context,
                                              fullNameController,
                                              phoneController,
                                              locationController,
                                            );
                                          }
                                        },
                                        style: const ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                            AppColors.primaryColor,
                                          ),
                                          shape: MaterialStatePropertyAll(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                          ),
                                          padding: MaterialStatePropertyAll(
                                            EdgeInsets.symmetric(
                                              vertical: 15,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'Checkout',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                          const SizedBox(
                            height: 30,
                          ),
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
