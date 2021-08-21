import 'package:get/get.dart';

class ProductDetailsController extends GetxController {

  final List<String> images = [
    'https://cdn.pixabay.com/photo/2020/11/01/23/22/breakfast-5705180_1280.jpg',
    'https://cdn.pixabay.com/photo/2019/01/14/17/25/gelato-3932596_1280.jpg',
    'https://cdn.pixabay.com/photo/2017/04/04/18/07/ice-cream-2202561_1280.jpg',
  ];
  
  int currentIndex = 0;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    update();
  }

}
