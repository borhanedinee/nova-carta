import 'package:admin_ecom/ui/controller/addProductController.dart';
import 'package:admin_ecom/main.dart';
import 'package:admin_ecom/data/model/colorsmodel.dart';
import 'package:admin_ecom/data/model/producttypemodel.dart';
import 'package:admin_ecom/data/model/sizesmodel.dart';
import 'package:admin_ecom/ui/pallets/colors.dart';
import 'package:admin_ecom/utils/extensions.dart';
import 'package:admin_ecom/services/showPickImageOptions.dart';
import 'package:admin_ecom/ui/view/widgets/addproduct/producttype.dart';
import 'package:admin_ecom/ui/view/widgets/custom_form.dart';
import 'package:admin_ecom/ui/view/widgets/customappbar.dart';
import 'package:admin_ecom/ui/view/widgets/custombutton.dart';
import 'package:admin_ecom/ui/view/widgets/customheader.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  late TextEditingController nameController;
  late TextEditingController descController;
  late TextEditingController stockController;
  late TextEditingController priceController;
  late TextEditingController discountController;

  final formKey = GlobalKey<FormState>();

  
  AddProductController controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    descController = TextEditingController();
    stockController = TextEditingController();
    priceController = TextEditingController();
    discountController = TextEditingController();
    controller.fetchCategories();
    controller.fetchColors();
    controller.fetchSizes();
    controller.fetchProductTypes();

    discountController.text = '0';
  }

  
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    descController.dispose();
    stockController.dispose();
    priceController.dispose();
    discountController.dispose();
    formKey.currentState?.dispose();
    controller.file = null;
    controller.selectedColorsIDs.clear();
    controller.selectedSizesIDs.clear();
  }

  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<AddProductController>(
          builder: (controller) => Column(
            children: [
              CustomAppBar(
                title: 'Add Product',
              ),
              Expanded(
                child: SizedBox(
                  height: size.height,
                  width: size.width,
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const CustomHeader(
                                header: 'Product image',
                              ),
                              const SizedBox().w(10),
                              if (!controller.isPictureValid)
                                const Text(
                                  'Product picture must be set',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 10),
                                )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Builder(builder: (context) {
                            return InkWell(
                              onTap: () {
                                // pick an image
                                showPickImageOptions(context, controller);
                              },
                              child: Container(
                                height: 200,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 15,
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                width: size.width,
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    borderRadius: BorderRadius.circular(20)),
                                child: controller.file == null
                                    ? Icon(
                                        Icons.image,
                                        size: 180,
                                        color: Colors.grey.shade400,
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: FileImage(controller.file!,
                                                  scale: 0.2),
                                              scale: 0.4),
                                        ),
                                      ),
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomForm(
                            validator: (p0) {
                              if (p0!.isEmpty || p0.length < 4) {
                                return 'Product name must be at least 4 characters';
                              }
                              return null;
                            },
                            keyboardtype: TextInputType.text,
                            controller: nameController,
                            hint: 'Enter product name',
                            headline: 'Name',
                            isPassword: false,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomForm(
                            keyboardtype: TextInputType.text,
                            validator: (p0) {
                              if (p0!.isEmpty || p0.length < 10) {
                                return 'Product description must be at least 10 characters';
                              }
                              return null;
                            },
                            controller: descController,
                            maxLines: 5,
                            hint: 'Enter product description',
                            headline: 'Description',
                            isPassword: false,
                          ),
                  
                          // CATEGORIE
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const CustomHeader(
                                header: 'Category',
                              ),
                              const SizedBox().w(10),
                              if (!controller.isCategorieValid)
                                const Text(
                                  'Product picture must be set',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 10),
                                )
                            ],
                          ),
                  
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            width: size.width,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: DropdownButton(
                              value: selectedCategory,
                              borderRadius: BorderRadius.circular(10),
                              isExpanded: true,
                              hint: const Text('Select category'),
                              items: controller.dopDownItems,
                              onChanged: (value) {
                                setState(() {
                                  selectedCategory = value;
                                });
                              },
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const CustomHeader(
                                header: 'Type',
                              ),
                              const SizedBox().w(10),
                              if (!controller.isTypeValid)
                                const Text(
                                  'Product type and sizes must be seleceted',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 10),
                                )
                            ],
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 8),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: List.generate(
                                      controller.producttypes.length, (index) {
                                    ProductTypeModel producttype =
                                        controller.producttypes[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: ProductType(
                                        type: producttype.type,
                                        backgroundColor:
                                            controller.currentType ==
                                                    producttype.type
                                                ? AppColors.pramiryColor
                                                    .withOpacity(0.3)
                                                : Colors.white,
                                        onTap: () {
                                          controller.selectedTypeID =
                                              producttype.id;
                                          controller.updateCurrentType(
                                              producttype.type);
                                          // change product type seleceted id in add product controller
                                        },
                                      ),
                                    );
                                  })),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                  
                          //PRODUCT TYPE
                          controller.currentType == 'feetwear'
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 13),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      ...List.generate(
                                        controller.shoesSizes.length + 1,
                                        (index) {
                                          SizesModel? productSize = index <
                                                  controller.shoesSizes.length
                                              ? controller.shoesSizes[index]
                                              : null;
                  
                                          return FittedBox(
                                            child: GestureDetector(
                                              onTap: () {
                                                if (index <
                                                    controller
                                                        .shoesSizes.length) {
                                                  if (controller
                                                      .selectedSizesIDs
                                                      .contains(
                                                          productSize!.id)) {
                                                    controller.selectedSizesIDs
                                                        .remove(productSize.id);
                                                    controller.update();
                                                  } else {
                                                    controller.selectedSizesIDs
                                                        .add(productSize.id);
                                                    controller.update();
                                                  }
                                                }
                                              },
                                              child: AnimatedContainer(
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                margin: const EdgeInsets.only(
                                                    bottom: 3, left: 7),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: index <
                                                          controller
                                                              .shoesSizes.length
                                                      ? controller
                                                              .selectedSizesIDs
                                                              .contains(
                                                                  productSize!
                                                                      .id)
                                                          ? AppColors
                                                              .pramiryColor
                                                          : Colors.white
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: AppColors
                                                          .pramiryColor),
                                                ),
                                                child: Text(
                                                  index ==
                                                          controller
                                                              .shoesSizes.length
                                                      ? '+'
                                                      : productSize!.label,
                                                  style: TextStyle(
                                                      color: index <
                                                              controller
                                                                  .shoesSizes
                                                                  .length
                                                          ? controller
                                                                  .selectedSizesIDs
                                                                  .contains(
                                                                      productSize!
                                                                          .id)
                                                              ? Colors.white
                                                              : AppColors
                                                                  .pramiryColor
                                                          : AppColors
                                                              .pramiryColor),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 13),
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      ...List.generate(
                                        controller.clotheSizes.length + 1,
                                        (index) {
                                          SizesModel? productSize = index <
                                                  controller.clotheSizes.length
                                              ? controller.clotheSizes[index]
                                              : null;
                                          return FittedBox(
                                            child: GestureDetector(
                                              onTap: () {
                                                if (index <
                                                    controller
                                                        .clotheSizes.length) {
                                                  if (controller
                                                      .selectedSizesIDs
                                                      .contains(
                                                          productSize!.id)) {
                                                    controller.selectedSizesIDs
                                                        .remove(productSize.id);
                                                    controller.update();
                                                  } else {
                                                    controller.selectedSizesIDs
                                                        .add(productSize.id);
                                                    controller.update();
                                                  }
                                                }
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 3, left: 7),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: index <
                                                          controller.clotheSizes
                                                              .length
                                                      ? controller
                                                              .selectedSizesIDs
                                                              .contains(
                                                                  productSize!
                                                                      .id)
                                                          ? AppColors
                                                              .pramiryColor
                                                          : Colors.white
                                                      : Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      color: AppColors
                                                          .pramiryColor),
                                                ),
                                                child: Text(
                                                  index ==
                                                          controller.clotheSizes
                                                              .length
                                                      ? '+'
                                                      : productSize!.label,
                                                  style: TextStyle(
                                                      color: index <
                                                              controller
                                                                  .clotheSizes
                                                                  .length
                                                          ? controller
                                                                  .selectedSizesIDs
                                                                  .contains(
                                                                      productSize!
                                                                          .id)
                                                              ? Colors.white
                                                              : AppColors
                                                                  .pramiryColor
                                                          : AppColors
                                                              .pramiryColor),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )
                                    ],
                                  ),
                                ),
                  
                          // colors
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const CustomHeader(
                                header: 'Colors',
                              ),
                              const SizedBox().w(10),
                              if (!controller.isColorsValid)
                                const Text(
                                  'Product colors must be seleceted',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 10),
                                )
                            ],
                          ),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                children: List.generate(
                                  controller.colors.length + 1,
                                  (index) {
                                    ColorsModel? color =
                                        index < controller.colors.length
                                            ? controller.colors[index]
                                            : null;
                  
                                    return FittedBox(
                                      child: GestureDetector(
                                        onTap: () {
                                          if (index <
                                              controller.colors.length) {
                                            if (controller.selectedColorsIDs
                                                .contains(color!.id)) {
                                              controller.selectedColorsIDs
                                                  .remove(color.id);
                                              controller.update();
                                            } else {
                                              controller.selectedColorsIDs
                                                  .add(color.id);
                                              controller.update();
                                            }
                                          }
                                        },
                                        child: AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          margin: const EdgeInsets.only(
                                              bottom: 3, left: 7),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                          decoration: BoxDecoration(
                                            color: index <
                                                    controller.colors.length
                                                ? controller.selectedColorsIDs
                                                        .contains(color!.id)
                                                    ? AppColors.pramiryColor
                                                    : Colors.white
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: AppColors.pramiryColor),
                                          ),
                                          child: Text(
                                              index == controller.colors.length
                                                  ? '+'
                                                  : color!.color,
                                              style: TextStyle(
                                                color: index <
                                                        controller.colors.length
                                                    ? controller
                                                            .selectedColorsIDs
                                                            .contains(color!.id)
                                                        ? Colors.white
                                                        : AppColors.pramiryColor
                                                    : AppColors.pramiryColor,
                                              )),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                  
                          CustomForm(
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Product stock cannot be empty';
                              }
                              if (!p0.isNum) {
                                return 'Product stock must be a number';
                              }
                              return null;
                            },
                            keyboardtype: TextInputType.number,
                            controller: stockController,
                            hint: 'Enter product quantity stock',
                            headline: 'Stock',
                            isPassword: false,
                          ),
                  
                          const SizedBox(
                            height: 20,
                          ),
                  
                          CustomForm(
                            keyboardtype: TextInputType.number,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'Product price cannot be empty';
                              }
                              if (!p0.isNum) {
                                return 'Product price must be a number';
                              }
                              return null;
                            },
                            controller: priceController,
                            hint: 'Enter product price',
                            headline: 'Price',
                            isPassword: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomForm(
                            keyboardtype: TextInputType.number,
                            validator: (p0) {
                              if (p0!.isEmpty) {
                                return 'if product does not have discount , set its value to 0';
                              }
                              if (!p0.isNum) {
                                return 'Product discount must be a number';
                              }
                              return null;
                            },
                            controller: discountController,
                            hint: 'Enter product discount',
                            headline: 'Discount',
                            isPassword: false,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                  
                          CustomButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  // non TextFields validation
                                  // image
                                  controller.file == null
                                      ? controller.isPictureValid = false
                                      : controller.isPictureValid = true;
                                  // categorie
                                  controller.selectedCategorieID == 0
                                      ? controller.isCategorieValid = false
                                      : controller.isCategorieValid = true;
                                  // type
                                  controller.selectedTypeID == 0 ||
                                          controller.selectedSizesIDs.isEmpty
                                      ? controller.isTypeValid = false
                                      : controller.isTypeValid = true;
                                  //colors
                                  controller.selectedColorsIDs.isEmpty
                                      ? controller.isColorsValid = false
                                      : controller.isColorsValid = true;
                  
                                  controller.update();
                  
                                  // checking if everything is valid to call add product method
                                  if (controller.isPictureValid &&
                                      controller.isCategorieValid &&
                                      controller.isTypeValid &&
                                      controller.isColorsValid) {
                                    await controller
                                        .addProduct(controller.file, {
                                      'name': nameController.text,
                                      'desc': descController.text,
                                      'categorie': controller
                                          .selectedCategorieID
                                          .toString(),
                                      'type':
                                          controller.selectedTypeID.toString(),
                                      'sizes': controller.selectedSizesIDs
                                          .toString(),
                                      'colors': controller.selectedColorsIDs
                                          .toString(),
                                      'stock': stockController.text,
                                      'price': priceController.text,
                                      'discount': discountController.text,
                                    });
                                  }
                                }
                              },
                              child: controller.isLoading
                                  ? const CircularProgressIndicator()
                                  : const Text(
                                      'Add',
                                      style: TextStyle(color: Colors.white),
                                    )),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
