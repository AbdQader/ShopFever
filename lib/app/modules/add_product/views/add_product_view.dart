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
            text: controller.product == null ? 'إضافة سلعة' : 'تعديل السلعة',
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
                      text: 'الصور',
                      size: 24.0,
                      weight: FontWeight.bold
                    ),
                    controller.images.length <= 0 && controller.urlImages.length <= 0
                      ? InkWell(
                          onTap: () => controller.pickImage(),
                          child: Container(
                            width: 60.0,
                            height: 60.0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            decoration: BoxDecoration(
                              color: Get.theme.colorScheme.secondary,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 30.0,
                              color: Colors.white
                            ),
                          ),
                        )
                      : GridView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.all(10),
                        itemCount: controller.product == null
                          ? controller.images.length
                          : controller.urlImages.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () => controller.pickImage(),
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: 100.0,
                                  height: 100.0,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                    color: Get.theme.colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: controller.product == null
                                    ? Image.file(
                                        controller.images[index],
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        controller.urlImages[index],
                                        fit: BoxFit.cover,
                                      )
                                ),
                                Positioned(
                                  top: -7,
                                  left: -7,
                                  child: InkWell(
                                    onTap: () => controller.product == null
                                      ? controller.removeImage(index)
                                      : controller.removeImageUrl(index),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius: BorderRadius.circular(100.0),
                                      ),
                                      child: const Icon(Icons.close, size: 13, color: Colors.white),
                                      padding: const EdgeInsets.all(8.0)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    const SizedBox(height: 20.0),
                    buildText(
                      text: 'الاسم',
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
                      text: 'التفاصيل',
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
                      text: 'السعر',
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
                      text: 'العملة',
                      size: 24.0,
                      weight: FontWeight.bold
                    ),
                    buildDropdownButton(
                      value: controller.currency,
                      hint: 'اختر العملة',
                      validate: (value) => controller.validateValue(value),
                      onChanged: (value) => controller.currency = value,
                      items: controller.currencyList,
                    ),
                    const SizedBox(height: 20.0),
                    buildText(
                      text: 'الحالة',
                      size: 24.0,
                      weight: FontWeight.bold
                    ),
                    buildDropdownButton(
                      value: controller.status,
                      hint: 'اختار حالة السلعة',
                      validate: (value) => controller.validateValue(value),
                      onChanged: (value) => controller.status = value,
                      items: controller.statusList,
                    ),
                    const SizedBox(height: 20.0),
                    buildText(
                      text: 'الفئة',
                      size: 24.0,
                      weight: FontWeight.bold
                    ),
                    buildDropdownButton(
                      value: controller.category,
                      hint: 'اختار فئة السلعة',
                      validate: (value) => controller.validateValue(value),
                      onChanged: (value) => controller.category = value,
                      items: controller.getCategories(),
                    ),
                    const SizedBox(height: 30.0),
                    ElevatedButton(
                      onPressed: () => controller.pickLocation(context),
                      child: Text('أختر الموقع')
                    ),
                    const SizedBox(height: 10.0),
                    Visibility(
                      visible: controller.address != null,
                      child: Text(controller.address ?? "غير معروف"),
                    ),
                    const SizedBox(height: 30.0),
                    buildMaterialButton(
                      onPressed: () => controller.submit(),
                      text: controller.product == null
                        ? 'إضافة السلعة'
                        : 'حفظ التغييرات'
                    ),
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