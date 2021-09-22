import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/components/empty_view.dart';
import 'package:shop_fever/app/modules/favorite/controllers/favorite_controller.dart';
import 'package:shop_fever/app/utils/components.dart';
import 'favorite_item.dart';

class FavoriteView extends GetView<FavoriteController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: GetBuilder<FavoriteController>(
          builder: (controller) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 2.0,
              title: buildText(
                text: 'المفضلة',
                size: 24.0,
                color: Colors.black,
                weight: FontWeight.bold
              ),
              iconTheme: const IconThemeData(color: Colors.black),
              bottom: TabBar(
                indicatorColor: Get.theme.colorScheme.secondary,
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    child: buildText(
                      text: 'السلع (${controller.favProducts.length})',
                      size: 18.0,
                      color: Colors.black
                    ),
                  ),
                  Tab(
                    child: buildText(
                      text: 'المشتركين (${controller.favUsers.length})',
                      size: 18.0,
                      color: Colors.black
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                controller.isLoading
                  ? showProgressIndicator()
                  : controller.favProducts.isEmpty
                    ? EmptyView(text: 'لم تضيف اي سلعة على المفضلة بعد !')
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.favProducts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FavoriteItem(
                            productModel: controller.favProducts[index],
                            userModel: null,
                          );
                        },
                      ),
                controller.isLoading
                  ? showProgressIndicator()
                  : controller.favUsers.isEmpty
                    ? EmptyView(text: 'لم تضيف اي مستخدم على المفضلة بعد !')
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.favUsers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FavoriteItem(
                            userModel: controller.favUsers[index],
                            productModel: null,
                          );
                        },
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}