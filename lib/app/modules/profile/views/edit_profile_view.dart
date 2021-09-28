import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_fever/app/modules/profile/controllers/profile_controller.dart';
import 'package:shop_fever/app/utils/components.dart';

class EditProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'تعديل الملف الشخصي',
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: controller.editProfileFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30.0),
                    GetBuilder<ProfileController>(
                      id: 'PickImage',
                      builder: (controller) => Center(
                        child: Stack(
                          children: [
                            controller.pickedImage != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage: FileImage(controller.pickedImage!),
                                )
                              : CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(controller.currentUser.photo)
                                ),
                            Positioned(
                              bottom: 5.0,
                              right: 1.0,
                              child: InkWell(
                                onTap: () => buildImagePickerBottomSheet(
                                  onCameraPressed: () {
                                    controller.pickImage(ImageSource.camera);
                                    Get.back();
                                  },
                                  onGalleryPressed: () {
                                    controller.pickImage(ImageSource.gallery);
                                    Get.back();
                                  },
                                ),
                                child: CircleAvatar(
                                  radius: 16.0,
                                  backgroundColor: Get.theme.colorScheme.secondary,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 18.0
                                  ),
                                ),
                              ),
                            ),
                          ]
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
                      hint: 'الاسم الجديد كامل',
                      lines: 1,
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 60.0,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: CountryCodePicker(
                              padding: const EdgeInsets.all(10.0),
                              initialSelection: 'PS',
                              showFlag: false,
                              alignLeft: true,
                              onChanged: (code) {
                                controller.countryCode = code.dialCode!;
                              },
                              searchDecoration: InputDecoration(
                                fillColor: Colors.grey[200],
                                filled: true,
                                hintText: 'ابحث عن دولتك',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide.none
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          flex: 4,
                          child: buildFormField(
                            controller: controller.phoneNumberController,
                            type: TextInputType.name,
                            validate: (value) {
                              if (value.toString().trim().isEmpty)
                                return 'يرجى إدخال رقم الهاتف';
                              if (value.toString().length < 4)
                                return 'رقم الهاتف قصير جداً';
                              return null;
                            },
                            hint: 'رقم الهاتف الجديد',
                            lines: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    controller.isLoading
                      ? showProgressIndicator()
                      : buildMaterialButton(
                          onPressed: () {
                            controller.submit();
                          },
                          text: 'حفظ التغييرات',
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