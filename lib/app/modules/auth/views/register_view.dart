import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_fever/app/utils/components.dart';
import '../controllers/auth_controller.dart';

class RegisterView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            right: 20.0,
            top: 30.0
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: controller.registerFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText(
                      text: 'لننهي إعداد حسابك!',
                      size: 40.0,
                      weight: FontWeight.bold,
                    ),
                    buildText(
                      text: 'قم بتعيين صورة واسم لحسابك',
                      size: 20.0,
                    ),
                    const SizedBox(height: 30.0),
                    GetBuilder<AuthController>(
                      id: 'PickImage',
                      builder: (controller) => Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: controller.getPickedImage != null
                            ? FileImage(controller.getPickedImage!)
                            : null,
                          child: InkWell(
                            onTap: () {
                              buildImagePickerBottomSheet(
                                onCameraPressed: () {
                                  controller.pickImage(ImageSource.camera);
                                  Get.back();
                                },
                                onGalleryPressed: () {
                                  controller.pickImage(ImageSource.gallery);
                                  Get.back();
                                },
                              );
                            },
                            child: controller.getPickedImage == null
                              ? Icon(
                                  Icons.add_a_photo,
                                  size: 50,
                                  color: Get.theme.accentColor,
                                )
                              : null,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    buildFormField(
                      controller: controller.usernameController,
                      type: TextInputType.name,
                      validate: (value) {
                        if (value.toString().trim().isEmpty)
                          return 'يرجى إدخال الاسم';
                        if (value.toString().length < 4)
                          return 'الاسم قصير جداً';
                        return null;
                      },
                      hint: 'الاسم الكامل',
                    ),
                    const SizedBox(height: 20.0),
                    Obx(() => controller.isLoading
                      ? showProgressIndicator()
                      : buildMaterialButton(
                          onPressed: () {
                            controller.submitRegister();
                          },
                          text: 'متابعة',
                        ),
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
