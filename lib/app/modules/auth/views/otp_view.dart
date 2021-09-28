import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shop_fever/app/modules/auth/controllers/auth_controller.dart';
import 'package:shop_fever/app/utils/components.dart';

class OtpView extends GetView<AuthController> {

  final TextEditingController codeController;
  final Function(String) verifyOTP;
  
  const OtpView({
    required this.codeController,
    required this.verifyOTP,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30.0),
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15.0)
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Get.back(),
                ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  buildText(
                    text: 'تم إرسال رمز التحقق من رقم الهاتف',
                    size: 24.0,
                    weight: FontWeight.bold
                  ),
                  buildText(
                    text: 'يرجى ادخال الرمز',
                    size: 24.0,
                    weight: FontWeight.bold
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    child: PinPut(
                      eachFieldHeight: 50.0,
                      eachFieldWidth: 50.0,
                      fieldsCount: 6,
                      controller: codeController,
                      textStyle: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      ),
                      // inputDecoration: InputDecoration(
                      //   errorText: 'الرمز يحتوي على 6 ارقام',
                      //   errorStyle: TextStyle(fontSize: 16.0),
                      //   border: InputBorder.none,
                      //   counterText: ''
                      // ),
                      // onSubmit: (String code) {
                      //   verifyOTP(code);
                      //   Get.focusScope!.unfocus();
                      // },
                      submittedFieldDecoration: _pinPutDecoration(20.0),
                      selectedFieldDecoration: _pinPutDecoration(15.0),
                      followingFieldDecoration: _pinPutDecoration(5.0),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildText(
                        text: 'سيتم إعادة إرسال الرمز بعد ',
                        size: 20.0,
                        color: Colors.black
                      ),
                      buildCustomTimer(),
                      buildText(
                        text: ' ث',
                        size: 20.0,
                        color: Colors.black
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Obx(() => controller.isLoading
                    ? showProgressIndicator()
                    : Container(
                        height: 50.0,
                        child: buildMaterialButton(
                          text: 'تأكيد',
                          onPressed: () {
                            if (codeController.text.trim().length == 6)
                            {
                              verifyOTP(codeController.text);
                              Get.focusScope!.unfocus();
                            } else {
                              showAlertDialog('الرمز قصير!', 'الرمز يتكون من 6 ارقام');
                            }
                          },
                        ),
                      ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildText(text: 'لم يصلك الرمز؟', size: 20.0),
                      TextButton(
                        onPressed: () {},
                        child: buildText(
                          text: 'إعادة الإرسال',
                          size: 20.0,
                          isUpperCase: true,
                          weight: FontWeight.bold,
                          color: Get.theme.colorScheme.secondary
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // For pinPut box decoration
  BoxDecoration _pinPutDecoration(double raduis) {
    return BoxDecoration(
      border: Border.all(width: 2.0, color: Get.theme.colorScheme.secondary),
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
          size: 20.0,
          color: Get.theme.colorScheme.secondary,
          weight: FontWeight.bold,
        );
      },
    );
  }

}

// // For bottom sheet
// void showBottomSheet() {
//   Get.bottomSheet(
//     Directionality(
//       textDirection: TextDirection.rtl,
//       child: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             buildText(
//               text: 'تم إرسال رمز التحقق من رقم الهاتف',
//               size: 20.0,
//               weight: FontWeight.bold
//             ),
//             const SizedBox(height: 10.0),
//             Container(
//               child: PinPut(
//                 fieldsCount: 6,
//                 controller: codeController,
//                 onSubmit: (String code) {
//                   _verifyOTP(code);
//                   Get.focusScope!.unfocus();
//                 },
//                 submittedFieldDecoration: _pinPutDecoration(20.0),
//                 selectedFieldDecoration: _pinPutDecoration(15.0),
//                 followingFieldDecoration: _pinPutDecoration(5.0),
//               ),
//             ),
//             const SizedBox(height: 10.0),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 buildText(
//                   text: 'سيتم إعادة إرسال الرمز بعد ',
//                   size: 18.0,
//                   color: Colors.black
//                 ),
//                 buildCustomTimer(),
//                 buildText(
//                   text: ' ث',
//                   size: 18.0,
//                   color: Colors.black
//                 ),
//               ],
//             ),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   children: [
//             //     buildText(text: 'لم يصلك الرمز؟', size: 18.0),
//             //     TextButton(
//             //       onPressed: () {
//             //       },
//             //       child: buildText(
//             //         text: 'إعادة الإرسال',
//             //         size: 18,
//             //         isUpperCase: true,
//             //         weight: FontWeight.bold,
//             //         color: Get.theme.colorScheme.secondary
//             //       ),
//             //     ),
//             //   ],
//             // ),
//           ],
//         ),
//       ),
//     ),
//     backgroundColor: Colors.white
//   );
// }

// // For pinPut box decoration
// BoxDecoration _pinPutDecoration(double raduis) {
//   return BoxDecoration(
//     border: Border.all(width: 2.0, color: Get.theme.colorScheme.secondary),
//     borderRadius: BorderRadius.circular(raduis),
//   );
// }

// // For CustomTimer
// Widget buildCustomTimer() {
//   return CustomTimer(
//     from: Duration(seconds: 30),
//     to: Duration(seconds: 0),
//     onBuildAction: CustomTimerAction.auto_start,
//     builder: (CustomTimerRemainingTime remaining) {
//       return buildText(
//         text: remaining.seconds,
//         size: 18.0,
//         color: Get.theme.colorScheme.secondary,
//         weight: FontWeight.bold,
//       );
//     },
//   );
// }
