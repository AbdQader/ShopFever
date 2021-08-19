import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController with SingleGetTickerProviderMixin {

  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

}
