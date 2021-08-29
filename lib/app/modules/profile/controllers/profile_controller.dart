import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/data/local/my_hive.dart';
import 'package:shop_fever/app/data/models/user_model.dart';

class ProfileController extends GetxController with SingleGetTickerProviderMixin {

  // For Current User
  UserModel? _currentUser;
  UserModel get currentUser => _currentUser!;
  
  late final TabController tabController;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    getCurrentUser();
  }

  // to get current user from local db
  Future<void> getCurrentUser() async {
    try {
      _currentUser = await MyHive.getCurrentUser();
    } catch (error) {
      print('abd => getCurrentUser Error: $error');
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

}
