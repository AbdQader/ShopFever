import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/data/models/user_model.dart';
import 'package:shop_fever/app/modules/profile/views/product_item.dart';
import 'package:shop_fever/app/routes/app_pages.dart';
import 'package:shop_fever/app/utils/components.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    controller.getUserProducts();
    final UserModel user = controller.otherUser ?? controller.currentUser;
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
            if (user.id != controller.currentUser.id)
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.white
                ),
              ),
            IconButton(
              onPressed: () {
                user.id == controller.currentUser.id
                  ? showBottomSheet()
                  : null;
              },
              icon: Icon(
                user.id == controller.currentUser.id
                  ? Icons.more_vert
                  : Icons.shortcut_outlined,
                color: Colors.white
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
                        backgroundImage: NetworkImage(user.photo),
                      ),
                    ),
                    Positioned(
                      top: 200.0,
                      right: 150.0,
                      child: buildText(
                        text: user.name,
                        size: 24.0,
                        color: Colors.black,
                        weight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 40.0),
                child: Row(
                  children: [
                    TextButton.icon(
                      onPressed: null,
                      icon: Icon(
                        Icons.favorite_border,
                        size: 30.0,
                        color: Get.theme.accentColor,
                      ),
                      label: buildText(
                        text: '0',
                        size: 25.0,
                        color: Get.theme.accentColor,
                      )
                    ),
                    const Spacer(),
                    buildStarRating(
                      starCount: 5,
                      rating: 0.0,
                      onRatingChanged: (rating) {},
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 5.0),
                    buildText(
                      text: '(0)',
                      size: 20.0,
                    ),
                  ],
                ),
              ),
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
              Container(
                height: 680.0,
                padding: const EdgeInsets.only(top: 10.0),
                child: buildTabBar()
              ),
            ],
          ),
        ),
        floatingActionButton: buildFloatingActionButton(
          title: 'تواصل معي',
          icon: Icons.phone,
          width: 150.0,
          onPressed: () {}
        ),
      ),
    );
  }

  // For Tab Bar
  Widget buildTabBar() {
    return Column(
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
                      buildText(text: '4', size: 24.0),
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
                      buildText(text: 'المزيد', size: 20.0),
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
                : GetBuilder<ProfileController>(
                    id: 'UserProduct',
                    builder: (controller) => GridView.builder(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0.0),
                      physics: const BouncingScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        mainAxisExtent: 270,
                        childAspectRatio: 2/3,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 0.0,
                      ),
                      itemCount: controller.userProducts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProductItem(
                          productModel: controller.userProducts[index]
                        );
                      },
                    ),
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
    );
  }

  // For Rating Bar
  Widget buildStarRating({
    required int starCount,
    required double rating,
    required Function(double rating) onRatingChanged,
    required Color color,
  }) {
    Widget buildStar(int index) {
      Icon icon;
      if (index >= rating) {
        icon = new Icon(
          Icons.star_border,
          size: 30.0,
          color: Colors.amber,
        );
      }
      else if (index > rating - 1 && index < rating) {
        icon = Icon(
          Icons.star_half,
          size: 30.0,
          color: color,
        );
      } else {
        icon = Icon(
          Icons.star,
          size: 30.0,
          color: color,
        );
      }
      return InkResponse(
        onTap: () => onRatingChanged(index + 1.0),
        child: icon,
      );
    }
    return Row(
      children: List.generate(starCount, (index) => buildStar(index))
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
                text: 'ادارة صفحتي',
                size: 24.0,
                weight: FontWeight.bold
              ),
              trailing: const Icon(
                Icons.close,
                size: 35.0,
                color: Colors.black
              ),
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
              }
            ),
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
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0)
        ),
      )
    );
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
      shape: Border(
        top: BorderSide(color: Colors.grey[300]!, width: 1.0)
      ),
      //contentPadding: EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 5.0),
    );
    
  }

}
