import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shop_fever/app/services/base_client.dart';
import 'package:shop_fever/app/services/error_handler.dart';

class HomeController extends GetxController {
  onInit(){
    Logger().e('SS');
    getData();
    super.onInit();
  }

  /**
   *  Example of making http call with base client
   * */
  getData() async
  {
    try{
      var url = 'https://jsonplaceholder.typicode.com/todosx/1';
      var response = await BaseClient.get(url);
      Logger().e(response);
    }catch(error){ //if any type of error happen
      //this class will only show snackbar with the error
      //u can change it and handle error as u want
      Logger().e('Error => ${error}');
      ErrorHandler.handleError(error);
    }
  }
}
