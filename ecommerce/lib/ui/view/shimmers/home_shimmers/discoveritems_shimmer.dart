
import 'package:ecommerce/ui/controllers/home_controller.dart';
import 'package:ecommerce/ui/view/components/clothe_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class DiscoverItemsShimmer extends StatelessWidget {
  DiscoverItemsShimmer({
    super.key, required this.needPading,
  });

  final HomeController controller = Get.find();


  final bool needPading ;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: needPading? const EdgeInsets.symmetric(
          horizontal: 5, vertical: 5 )  : EdgeInsets.all(0) ,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1 / 1.6,
                crossAxisCount: 2,
                mainAxisSpacing: 5),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
                  baseColor: Colors.grey.shade200,
                  highlightColor: Colors.grey.shade300,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Container(
                      decoration: BoxDecoration(
                      color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 310,
                      width: 180,
                    ),
                  ),
                );
        },
      ),
    );
  }
}
