import 'package:shop_fever/app/utils/constants.dart';

class HelperFunctions {
  ///check if status of api call was success
  static bool checkIfStatusSuccess(dynamic response)
    => response[Constants.API_STATUS].toString().toLowerCase() == Constants.API_SUCCESS;

  ///safe api calls and auto handling for errors
  static Future<void> safeApiCall({
    required Function execute,
    required Function(dynamic) onSuccess,
    Function(dynamic)? onError,
    Function? onLoading
  }) async {
    try {
      //execute function that user passed
      var response = await execute();
      if(onLoading != null)
        onLoading();
      onSuccess(response);
      return;
    } catch (error) {
      if (onError == null) return; //if user dont want to handle error
        onError(error);
      return;
    }
  }

}