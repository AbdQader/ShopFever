import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_fever/app/data/local/my_hive.dart';
import 'package:shop_fever/app/data/local/sharedPref.dart';
import 'package:shop_fever/app/data/models/user_model.dart';
import 'package:shop_fever/app/modules/auth/views/otp_view.dart';
import 'package:shop_fever/app/services/app_exceptions.dart';
import 'package:shop_fever/app/services/base_client.dart';
import 'package:shop_fever/app/services/error_handler.dart';
import 'package:shop_fever/app/utils/constants.dart';
import 'package:shop_fever/app/utils/helperFunctions.dart';
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

  @override
  void onClose() {
    usernameController.dispose();
    phoneNumberController.dispose();
    codeController.dispose();
    super.onClose();
  }

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
          Get.bottomSheet(
            OtpView(
              codeController: codeController,
              verifyOTP: _verifyOTP
            ),
            backgroundColor: Colors.white,
            isScrollControlled: true,
          );
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
    _isLoading.value = true;
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
      _isLoading.value = false;
      showAlertDialog('الرمز غير صحيح', 'تحقق من الرمز ثم حاول مجدداً');
      codeController.clear();
    }
  }

  // Login the user in API
  void _loginToApi() async {
    HelperFunctions.safeApiCall(
      execute: () async
      {
        return await BaseClient.post(
          Constants.LOGIN_URL,
          body: {
            Constants.PHONE : countryCode + phoneNumberController.text.trim()
          },
          headers: {
            Constants.API_CONTENT_TYPE: Constants.API_APPLICATION_JSON,
          }
        );
      },
      onSuccess: (response)
      {
        saveUserToLocal(UserModel.fromJson(response['user']));
        _isLoading.value = false;
      },
      onError: (error)
      {
        if (error is UnauthorizedException)
          Get.toNamed(AppPages.REGISTER);
        else
          ErrorHandler.handleError(error);
      },
      onLoading: () {}
    );
  }

  // Register the user in API
  void _registerToApi() async {
    HelperFunctions.safeApiCall(
      execute: () async
      {
        _isLoading.value = true;
        return await BaseClient.post(
          Constants.REGISTER_URL,
          body: FormData({
            Constants.NAME : usernameController.text.trim(),
            Constants.PHONE: countryCode + phoneNumberController.text.trim(),
            Constants.PHOTO: MultipartFile(getPickedImage, filename: DateTime.now().millisecondsSinceEpoch.toString()),
          }),
          headers: {
            Constants.API_ACCEPT: Constants.API_MULTIPART_DATA,
          }
        );
      },
      onSuccess: (response)
      {
        _isLoading.value = false;
        saveUserToLocal(UserModel.fromJson(response['user']));
      },
      onError: (error)
      {
        _isLoading.value = false;
        ErrorHandler.handleError(error);
      },
      onLoading: () {}
    );
  }

  // To get the image that user select it
  Future<void> pickImage(ImageSource src) async {
    final pickedImageFile =
        await _picker.pickImage(source: src, imageQuality: 50, maxWidth: 150);
    if (pickedImageFile != null) {
      _pickedImage = File(pickedImageFile.path);
      update(['PickImage']);
    }
  }

  ///save user to local db and set it as logged in sharedPref
  Future<void> saveUserToLocal(UserModel user) async {
    await MyHive.saveUser(user);
    SharedPref.setUserAsLogged();
    Get.offAllNamed(Routes.HOME);
  }

}