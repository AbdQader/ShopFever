import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/modules/profile/views/product_item.dart';
import 'package:shop_fever/app/routes/app_pages.dart';
import 'package:shop_fever/app/utils/components.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0.2),
          elevation: 0.0,
          title: Text('الملف الشخصي'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
          actions: [
            controller.isTheCurrent()
            ? IconButton(
                onPressed: () => showBottomSheet(),
                icon: const Icon(Icons.more_vert, color: Colors.white),
              )
            : GetBuilder<ProfileController>(
                id: 'Favorites',
                builder: (controller) => controller.isFavLoading
                ? Transform.scale(
                    scale: 0.5,
                    child: showProgressIndicator(),
                  )
                : IconButton(
                    onPressed: () => controller.markUserAsFavorites(),
                    icon: Icon(
                      controller.isFavorites
                        ? Icons.favorite
                        : Icons.favorite_border,
                      color: controller.isFavorites
                        ? Colors.redAccent
                        : Colors.white
                    ),
                  ),
              ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250.0,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('https://timelinecovers.pro/facebook-cover/download/blue-bubbles-facebook-cover.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 160.0,
                      right: 30.0,
                      child: CircleAvatar(
                        radius: 40.0,
                        backgroundImage: NetworkImage(controller.currentUser.photo),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildText(
                      text: controller.currentUser.name,
                      size: 24.0,
                      color: Colors.black,
                      weight: FontWeight.bold
                    ),
                    TextButton.icon(
                      onPressed: null,
                      icon: Icon(
                        Icons.favorite_border,
                        size: 30.0,
                        color: Get.theme.colorScheme.secondary,
                      ),
                      label: GetBuilder<ProfileController>(
                        id: 'FavTimes',
                        builder: (controller) => buildText(
                          text: controller.favTimes.toString(),
                          size: 25.0,
                          color: Get.theme.colorScheme.secondary,
                        )
                      ),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20.0, right: 40.0),
              //   child: Row(
              //     children: [
              //       // TextButton.icon(
              //       //   onPressed: null,
              //       //   icon: Icon(
              //       //     Icons.favorite_border,
              //       //     size: 30.0,
              //       //     color: Get.theme.colorScheme.secondary,
              //       //   ),
              //       //   label: buildText(
              //       //     text: '0',
              //       //     size: 25.0,
              //       //     color: Get.theme.colorScheme.secondary,
              //       //   )
              //       // ),
              //       const Spacer(),
              //       // buildStarRating(
              //       //   starCount: 5,
              //       //   rating: 0.0,
              //       //   onRatingChanged: (rating) {},
              //       //   color: Colors.amber,
              //       // ),
              //       // const SizedBox(width: 5.0),
              //       // buildText(
              //       //   text: '(0)',
              //       //   size: 20.0,
              //       // ),
              //     ],
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey[200]!),
                    bottom: BorderSide(color: Colors.grey[200]!)
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.shopping_cart, color: Colors.black45),
                    buildText(text: '  عدد السلع التي تم بيعها  ', size: 20.0),
                    buildText(text: '(7)', size: 20.0)
                  ],
                ),
              ),
              GetBuilder<ProfileController>(
                id: 'UserProduct',
                builder: (controller) => Container(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
                  child: Row(
                    children: [
                      const Icon(Icons.shopping_cart, color: Colors.black45),
                      buildText(text: '  عدد السلع المعروضة للبيع  ', size: 20.0),
                      buildText(text: '(${controller.userProducts.length})', size: 20.0)
                    ],
                  ),
                ),
              ),
              GetBuilder<ProfileController>(
                id: 'UserProduct',
                builder: (controller) => controller.isLoading
                  ? showProgressIndicator()
                  : controller.userProducts.isEmpty
                    ? Container(
                        padding: const EdgeInsets.only(top: 30.0),
                        alignment: Alignment.topCenter,
                        child: buildText(
                          text: 'لم يتم عرض شيء للبيع حتى هذه اللحظة!',
                          size: 24.0,
                          weight: FontWeight.bold
                        ),
                      )
                    : GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0.0),
                        physics: const BouncingScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2/3,
                          crossAxisSpacing: 0.0,
                          mainAxisSpacing: 0.0,
                        ),
                        itemCount: controller.userProducts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductItem(
                            productModel: controller.userProducts[index],
                            isCurrentUser: controller.isTheCurrent()
                          );
                        },
                      ),
              ),
              // Container(
              //   height: 680.0,
              //   padding: const EdgeInsets.only(top: 10.0),
              //   child: buildTabBar(),
              // ),
            ],
          ),
        ),
        floatingActionButton: !controller.isTheCurrent()
          ? buildFloatingActionButton(
              title: 'تواصل معي',
              icon: Icons.phone,
              width: 150.0,
              onPressed: () {}
            )
          : null
      ),
    );
  }

  // For Tab Bar
  Widget buildTabBar() {
    return GetBuilder<ProfileController>(
      id: 'UserProduct',
      builder: (controller) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: TabBar(
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[600],
              tabs: [
                Container(
                  height: 70.0,
                  child: Tab(
                    child: Column(
                      children: [
                        buildText(text: '${controller.userProducts.length}', size: 24.0),
                        buildText(text: 'سلع للبيع', size: 20.0),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 70.0,
                  child: Tab(
                    child: Column(
                      children: [
                        const Icon(Icons.add, size: 30.0),
                        buildText(text: 'المنتجات المفضلة', size: 20.0),
                      ],
                    ),
                  ),
                ),
              ],
              controller: controller.tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                controller.userProducts.isEmpty
                  ? Container(
                      padding: const EdgeInsets.only(top: 30.0),
                      alignment: Alignment.topCenter,
                      child: buildText(
                        text: 'لم تعرض شيء للبيع حتى هذه اللحظة!',
                        size: 24.0,
                        weight: FontWeight.bold
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0.0),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2/3,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 0.0,
                      ),
                      itemCount: controller.userProducts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductItem(
                          productModel: controller.userProducts[index],
                          isCurrentUser: controller.isTheCurrent()
                        );
                      },
                    ),
                Container(
                  padding: const EdgeInsets.only(top: 30.0),
                  alignment: Alignment.topCenter,
                  child: buildText(
                    text: 'لا يوجد بيانات حتى الان!',
                    size: 24.0,
                    weight: FontWeight.bold
                  ),
                ),
              ],
              controller: controller.tabController,
            ),
          ),
        ],
      ),
    );
  }

  // For Profile Settings
  void showBottomSheet() {
    Get.bottomSheet(
        Directionality(
          textDirection: TextDirection.rtl,
          child: Wrap(
            children: [
              ListTile(
                onTap: () => Get.back(),
                title: buildText(
                    text: 'ادارة صفحتي', size: 24.0, weight: FontWeight.bold),
                trailing:
                    const Icon(Icons.close, size: 35.0, color: Colors.black),
              ),
              buildListTile(
                title: 'تعديل معلوماتي',
                icon: Icons.edit_outlined,
                onPressed: () => Get.back(),
              ),
              buildListTile(
                  title: 'السلع والصفحات المفضلة',
                  icon: Icons.favorite_border,
                  onPressed: () {
                    Get.back();
                    Get.toNamed(AppPages.FAVORITES);
                  }),
              buildListTile(
                title: 'ترقية الصفحة',
                icon: Icons.local_fire_department_outlined,
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        barrierColor: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ));
  }

  // For ListTile
  Widget buildListTile({
    required String title,
    required IconData icon,
    required Function() onPressed
  }) {
    return ListTile(
      onTap: onPressed,
      title: buildText(
        text: title,
        size: 20.0,
      ),
      leading: Icon(
        icon,
        size: 25.0,
      ),
      shape: Border(top: BorderSide(color: Colors.grey[300]!, width: 1.0)),
    );
  }

}