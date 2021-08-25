import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:custom_timer/custom_timer.dart';
import 'package:shop_fever/app/data/local/my_hive.dart';
import 'package:shop_fever/app/data/local/sharedPref.dart';
import 'package:shop_fever/app/data/models/user_model.dart';
import 'package:shop_fever/app/services/app_exceptions.dart';
import 'package:shop_fever/app/services/base_client.dart';
import 'package:shop_fever/app/services/error_handler.dart';
import 'package:shop_fever/app/utils/constants.dart';
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
      _registerToApi();
    }
  }

  // This function to register new user using phone number
  Future<void> _login() async {
    try {
      _isLoading.value = true;
      await _auth.verifyPhoneNumber(
        phoneNumber: countryCode + phoneNumberController.text.trim(),
        verificationCompleted: (phoneAuthCredential) {
          _isLoading.value = false;
        },
        verificationFailed: (error) {
          showAlertDialog('رقم الهاتف غير صالح', 'تحقق من رقم الهاتف ثم حاول مجدداً');
          _isLoading.value = false;
        },
        codeSent: (verificationId, forceResendingToken) {
          _isLoading.value = false;
          this.verificationId = verificationId;
          showBottomSheet();
        },
        codeAutoRetrievalTimeout: (verificationId) {
          this.verificationId = verificationId;
        },
      );
    } catch (error) {
      print('abd => catch: $error');
      _isLoading.value = false;
    }
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
      // If the user credential != null, Call "_loginToApi" fun
      if (credential.user != null)
        _loginToApi();

    } catch (error) {
      print('abd => verifyOTP: catch: $error');
      showAlertDialog('الرمز غير صحيح', 'تحقق من الرمز ثم حاول مجدداً');
      codeController.clear();
    }
  }

  // Login the user in API
  void _loginToApi() async {
    try {
      Logger().e('CD => ${countryCode} | PN => ${phoneNumberController.text}');
      var response = await BaseClient.post(
        LOGIN_URL,
        body: {
          'phone' : countryCode + phoneNumberController.text.trim()
        },
        headers: {
          'content-type': 'application/json'
        }
      );
      // When Login Success
      Logger().e('User => ${response['user'].runtimeType}');
      if (response['status'] == 'Success')
        saveUserToLocal(UserModel.fromJson(response['user']));
      
      Logger().e('Login => $response');
      Logger().e('Login: Status: => ${response['status']}');
    } catch (error) {
      Logger().e('Error => ${error}');
      // Error
      if (error is UnauthorizedException)
        Get.toNamed(AppPages.REGISTER);
      else
        ErrorHandler.handleError(error);
    }
  }

  // Register the user in API
  void _registerToApi() async {
    try {
      _isLoading.value = true;
      var response = await BaseClient.post(
        REGISTER_URL,
        body: FormData({
          'name': usernameController.text.trim(),
          'phone': countryCode + phoneNumberController.text.trim(),
          'photo': MultipartFile(getPickedImage, filename: DateTime.now().millisecondsSinceEpoch.toString()),
        }),
        headers: {
          'Accept': 'multipart/form-data',
        }
      );

      // TODO: Here When User Register & Go To Home Screen
      // When Register Success
      if (response['status'] == 'Success')
        saveUserToLocal(UserModel.fromJson(response['user']));

      // Stop Loading
      _isLoading.value = false;

      Logger().e('Register => $response');
      Logger().e('Register: Status: => ${response['status']}');
    } catch (error) {
      _isLoading.value = false;
      Logger().e('Error => ${error}');
      // Error
      ErrorHandler.handleError(error);
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
      from: Duration(seconds: 30),
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


  //TODO bla bla bla
  ///save user to local db and set it as logged in sharedPref
  Future<void> saveUserToLocal(UserModel user) async {
    MyHive.saveUser(user);
    SharedPref.setUserAsLogged();
    Get.toNamed(Routes.HOME);
  }

}
