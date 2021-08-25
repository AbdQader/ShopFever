import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/utils/components.dart';
import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: buildText(
            text: 'إضافة سلعة',
            size: 20.0,
            color: Colors.black,
            weight: FontWeight.bold
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
        ),
        body: GetBuilder<AddProductController>(
          builder: (controller) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText(
                      text: 'صور السلعة',
                      size: 24.0,
                      weight: FontWeight.bold
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: 10,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () => controller.pickImage(),
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              color: Get.theme.accentColor,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: controller.images.length > index
                              ? Image.file(
                                  controller.images[index],
                                  fit: BoxFit.cover,
                                )
                              : const Icon(
                                  Icons.add,
                                  size: 30.0,
                                  color: Colors.white
                                )
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20.0),
                    buildText(
                      text: 'اسم السلعة',
                      size: 24.0,
                      weight: FontWeight.bold
                    ),
                    buildFormField(
                      controller: controller.nameController,
                      type: TextInputType.text,
                      validate: (value) => controller.validateValue(value),
                      hint: 'ادخل اسم السلعة',
                      lines: 1
                    ),
                    const SizedBox(height: 20.0),
                    buildText(
                      text: 'تفاصيل السلعة',
                      size: 24.0,
                      weight: FontWeight.bold
                    ),
                    buildFormField(
                      controller: controller.descriptionController,
                      type: TextInputType.text,
                      validate: (value) => controller.validateValue(value),
                      hint: 'ادخل تفاصيل السلعة',
                    ),
                    const SizedBox(height: 20.0),
                    buildText(
                      text: 'سعر السلعة',
                      size: 24.0,
                      weight: FontWeight.bold
                    ),
                    buildFormField(
                      controller: controller.priceController,
                      type: TextInputType.number,
                      validate: (value) => controller.validateValue(value),
                      hint: 'ادخل سعر السلعة',
                      lines: 1,
                    ),
                    const SizedBox(height: 20.0),
                    buildText(
                      text: 'نوع العملة',
                      size: 24.0,
                      weight: FontWeight.bold
                    ),
                    buildDropdownButton(
                      hint: 'اختار العملة',
                      validate: (value) => controller.validateValue(value),
                      onChanged: (value) => controller.currency = value,
                      items: controller.currencyList,
                    ),
                    const SizedBox(height: 20.0),
                    buildText(
                      text: 'حالة السلعة',
                      size: 24.0,
                      weight: FontWeight.bold
                    ),
                    buildDropdownButton(
                      hint: 'اختار حالة السلعة',
                      validate: (value) => controller.validateValue(value),
                      onChanged: (value) => controller.status = value,
                      items: controller.statusList,
                    ),
                    const SizedBox(height: 20.0),
                    buildText(
                      text: 'فئة السلعة',
                      size: 24.0,
                      weight: FontWeight.bold
                    ),
                    buildDropdownButton(
                      hint: 'اختار فئة السلعة',
                      validate: (value) => controller.validateValue(value),
                      onChanged: (value) => controller.category = value,
                      items: controller.categoryList,
                    ),
                    const SizedBox(height: 30.0),
                    buildMaterialButton(
                      onPressed: () => controller.submit(),
                      text: 'إضافة السلعة'
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}