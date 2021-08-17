import 'package:get/get.dart';

import 'app_exceptions.dart';

class ErrorHandler {
  static void handleError(exception) {
    if(exception is FetchDataException)
        showErrorSnackbar(
            title: 'Error',
            message: exception.message!);

     if(exception is ApiNotRespondingException)
        showErrorSnackbar(
            title: 'Error',
            message: exception.message!);

      if(exception is UnauthorizedException)
        showErrorSnackbar(
            title: 'Error',
            message: exception.message!);

      if(exception is NotFoundException)
        showErrorSnackbar(
            title: 'Error', message: exception.message!);


      if(exception is BadRequestException)
        showErrorSnackbar(
            title: 'Error',
            message: exception.message!);
  }

  static showErrorSnackbar({required String title, required String message}) {
    Get.snackbar(title, message);
  }
}
