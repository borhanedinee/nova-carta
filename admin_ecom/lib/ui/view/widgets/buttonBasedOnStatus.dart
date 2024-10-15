import 'package:admin_ecom/ui/controller/ordersController.dart';
import 'package:admin_ecom/data/model/order/orderModel.dart';
import 'package:admin_ecom/ui/pallets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateOrderStatusButton extends StatelessWidget {
  UpdateOrderStatusButton({
    super.key,
    required this.order,
  });

  final OrdersController ordersController = Get.find();

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: switch (order.status.toLowerCase()) {
            'pending' => const MaterialStatePropertyAll(AppColors.pramiryColor),
            'inprogress' => MaterialStatePropertyAll(Colors.grey),
            'completed' => const MaterialStatePropertyAll(Colors.red),
            // TODO: Handle this case.
            String() => null,
          }),
      onPressed: switch (order.status.toLowerCase()) {
        'pending' => () {
            // means the button has accept text
            // we update it to in progress
            ordersController.changeSelectedOrderId(order.orderInfoId);
            ordersController.updateOrderStatus('inProgress', false );
          },
        'inprogress' => () {
            // means the button has complete text
            // we update it to completed
            ordersController.changeSelectedOrderId(order.orderInfoId);

            ordersController.updateOrderStatus('completed', false );
          },
        'completed' => () {
            // means the button has delete text
            // we update it to deleted
            ordersController.changeSelectedOrderId(order.orderInfoId);

            ordersController.updateOrderStatus('deleted', false );
          },
        // TODO: Handle this case.
        String() => () {},
      },
      child: order.orderInfoId == ordersController.selectedOrderId
          ? const SizedBox(
              height: 10,
              width: 10,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Text(
              switch (order.status.toLowerCase()) {
                'pending' => 'Accept',
                'inprogress' => 'Complete',
                'completed' => 'Delete',
                // TODO: Handle this case.
                String() => 'null',
              },
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
    );
  }
}
