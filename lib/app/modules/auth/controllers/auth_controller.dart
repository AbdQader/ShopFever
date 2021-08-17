import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:custom_timer/custom_timer.dart';
import '../../../utils/components.dart';
import '/app/routes/app_pages.dart';

class AuthController extends GetxController {

  // For Firebase Auth
  FirebaseAuth _auth = FirebaseAuth.instance;

  // For Verification Id
  String? verificationId;

  // For Initial Country Code
  String countryCode = '+970';
  
  // For TextFields
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final codeController = TextEditingController();

  // For image picker
  File? _pickedImage;
  File? get getPickedImage => _pickedImage;
  final ImagePicker _picker = ImagePicker();

  // For loading state
  Rx<bool> _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  // to submit the login
  void submitLogin() {
    // Close the keyboard
    //if (Get.mediaQuery.viewInsets.bottom > 0)
    Get.focusScope!.unfocus();

    // Check form validation
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();
      _login();
    }
  }

  // to submit the register
  void submitRegister() {
    // Close the keyboard
    Get.focusScope!.unfocus();

    // Check image picked
    if (getPickedImage == null) {
      showSnackbar('الصورة مفقودة' ,'يرجى إختيار صورة أولاً');
      return;
    }

    // Check form validation
    if (registerFormKey.currentState!.validate()) {
      registerFormKey.currentState!.save();
      _register();
    }
  }

  // This function to register new user using phone number
  Future<void> _login() async {
    try {
      _isLoading.value = true;
      await _auth.verifyPhoneNumber(
        //timeout: const Duration(seconds: 60),
        phoneNumber: countryCode + phoneNumberController.text.trim(),
        verificationCompleted: (phoneAuthCredential) {
          print('abd => verificationCompleted: ${phoneAuthCredential.smsCode}');
          _isLoading.value = false;
        },
        verificationFailed: (error) {
          print('abd => verificationFailed: ${error.message}');
          showAlertDialog('رقم الهاتف غير صالح', 'تحقق من رقم الهاتف ثم حاول مجدداً');
          _isLoading.value = false;
        },
        codeSent: (verificationId, forceResendingToken) {
          print('abd => codeSent: $verificationId || $forceResendingToken');
          _isLoading.value = false;
          this.verificationId = verificationId;
          showBottomSheet();
        },
        codeAutoRetrievalTimeout: (verificationId) {
          print('abd => codeAutoRetrievalTimeout: $verificationId');
          this.verificationId = verificationId;
        },
      );
    } catch (error) {
      print('abd => catch: $error');
      _isLoading.value = false;
    }
  }

  // This function to login the user using phone number
  void _register() {
    _isLoading.value = true;
    print('abd => Phone Number: ${countryCode + phoneNumberController.text.trim()}');
    print('abd => User Name: ${usernameController.text.trim()}');
    print('abd => User Image: ${getPickedImage.toString()}');
    _isLoading.value = false;
  }

  // This function to verify the phone number "OTP"
  void _verifyOTP(String smsCode) async {
    try {
      var credential = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
          verificationId: this.verificationId!,
          smsCode: smsCode
        )
      );
      if (credential.user != null)
      {
        print('abd => verifyOTP: credential: ${credential.user.toString()}');
        Get.toNamed(AppPages.REGISTER);
      } else {
        Get.snackbar('Current User Null', 'Current User Is Null');
      }
    } catch (error) {
      print('abd => verifyOTP: catch: $error');
      showAlertDialog('الرمز غير صحيح', 'تحقق من الرمز ثم حاول مجدداً');
      codeController.clear();
    }
  }

  // To get the image that user select it
  Future<void> pickImage(ImageSource src) async {
    final pickedImageFile =
        await _picker.pickImage(source: src, imageQuality: 50, maxWidth: 150);
    if (pickedImageFile != null) {
      _pickedImage = File(pickedImageFile.path);
      update();
    }
  }

  // For bottom sheet
  void showBottomSheet() {
    //startTimer();
    Get.bottomSheet(
      Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildText(
                text: 'تم إرسال رمز التحقق من رقم الهاتف',
                size: 20.0,
                weight: FontWeight.bold
              ),
              const SizedBox(height: 10.0),
              Container(
                child: PinPut(
                  fieldsCount: 6,
                  controller: codeController,
                  onSubmit: (String code) {
                    _verifyOTP(code);
                    Get.focusScope!.unfocus();
                  },
                  submittedFieldDecoration: _pinPutDecoration(20.0),
                  selectedFieldDecoration: _pinPutDecoration(15.0),
                  followingFieldDecoration: _pinPutDecoration(5.0),
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildText(
                    text: 'سيتم إعادة إرسال الرمز بعد ',
                    size: 18.0,
                    color: Colors.black
                  ),
                  buildCustomTimer(),
                  buildText(
                    text: ' ث',
                    size: 18.0,
                    color: Colors.black
                  ),
                ],
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     buildText(text: 'لم يصلك الرمز؟', size: 18.0),
              //     TextButton(
              //       onPressed: () {
              //       },
              //       child: buildText(
              //         text: 'إعادة الإرسال',
              //         size: 18,
              //         isUpperCase: true,
              //         weight: FontWeight.bold,
              //         color: Get.theme.accentColor
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white
    );
  }

  // For pinPut box decoration
  BoxDecoration _pinPutDecoration(double raduis) {
    return BoxDecoration(
      border: Border.all(width: 2.0, color: Get.theme.accentColor),
      borderRadius: BorderRadius.circular(raduis),
    );
  }

  // For CustomTimer
  Widget buildCustomTimer() {
    return CustomTimer(
      from: Duration(seconds: 5),
      to: Duration(seconds: 0),
      onBuildAction: CustomTimerAction.auto_start,
      builder: (CustomTimerRemainingTime remaining) {
        return buildText(
          text: remaining.seconds,
          size: 18.0,
          color: Get.theme.accentColor,
          weight: FontWeight.bold,
        );
      },
    );
  }

}
