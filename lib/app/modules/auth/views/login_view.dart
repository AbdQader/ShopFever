import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:country_code_picker/country_code_picker.dart';
import '../controllers/auth_controller.dart';
import '../../../utils/components.dart';

class LoginView extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                key: controller.loginFormKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText(
                      text: 'مرحباً بك!',
                      size: 40.0,
                      weight: FontWeight.bold,
                    ),
                    buildText(
                      text: 'قم بإدخال رقم هاتفك وانضم الينا',
                      size: 20.0,
                    ),
                    const SizedBox(height: 30.0),
                    Container(
                      width: double.infinity,
                      height: 60.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: CountryCodePicker(
                        padding: EdgeInsets.all(10.0),
                        initialSelection: 'PS',
                        alignLeft: true,
                        onChanged: (code) {
                          controller.countryCode = code.dialCode!;
                        },
                        //onInit: (code) => print("on init ${code!.name} ${code.dialCode} ${code.name}"),
                        searchDecoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          hintText: 'Search of your country',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide.none
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    buildFormField(
                      controller: controller.phoneNumberController,
                      type: TextInputType.number,
                      validate: (value) {
                        if (value.toString().trim().isEmpty)
                          return 'يرجى إدخال رقم الهاتف';
                        if (value.toString().length < 4)
                          return 'رقم الهاتف قصير جداً';
                        return null;
                      },
                      hint: 'رقم الهاتف',
                    ),
                    const SizedBox(height: 20.0),
                    Obx(() => controller.isLoading
                      ? showProgressIndicator()
                      : buildMaterialButton(
                          onPressed: () => controller.submitLogin(),
                          text: 'إرسال',
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
