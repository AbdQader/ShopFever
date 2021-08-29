import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/components/category_item.dart';
import 'package:shop_fever/app/components/close_product_item.dart';
import 'package:shop_fever/app/components/recently_added_product_item.dart';
import 'package:shop_fever/app/components/special_product_item.dart';
import 'package:shop_fever/app/components/user_item.dart';
import 'package:shop_fever/app/routes/app_pages.dart';
import '../controllers/home_controller.dart';
import '../../../utils/components.dart';

class HomeView extends GetView<HomeController> {
  final String userImage = 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'الرئيسية',
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 2.0,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none),
            ),
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Get.offAllNamed(AppPages.LOGIN);
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: MixinBuilder<HomeController>(
          builder: (controller) => Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 120.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CategoryItem(
                        categoryModel: controller.categories[index],
                      );
                    },
                  ),
                ),
                buildDivider(),
                buildListHeader('مشتركين', 'مميزين'),
                const SizedBox(height: 5.0),
                SizedBox(
                  height: 235.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.users.length,
                    itemBuilder: (BuildContext context, int index) {
                      return UserItem(
                        userModel: controller.users[index]
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10.0),
                buildDivider(),
                buildListHeader('منتجات', 'خاصة'),
                SizedBox(
                  height: 320.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.specialProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SpecialProductItem(
                        productModel: controller.specialProducts[index],
                      );
                    },
                  ),
                ),
                buildDivider(),
                buildListHeader('منتجات', 'اضيفت حديثا'),
                SizedBox(
                  height: 120.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: controller.products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return RecentlyAddedProductItem(
                        productModel: controller.products[index]
                      );
                    },
                  ),
                ),
                buildDivider(),
                buildListHeader('منتجات', 'قريبة منك'),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 2/3.2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                    ),
                    itemCount: controller.closeProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return CloseProductItem(
                        productModel: controller.closeProducts[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        drawer: buildDrawer(),
        floatingActionButton: buildFloatingActionButton(
          title: 'انشر سلعة جديدة',
          icon: Icons.add,
          width: 180.0,
          onPressed: () => Get.toNamed(AppPages.ADD_PRODUCT)
        ),
      ),
    );
  }

  // For List Headers
  Widget buildListHeader(String firstWord, String secondWord) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildText(
            text: firstWord,
            size: 24.0,
            color: Get.theme.accentColor,
            weight: FontWeight.bold,
          ),
          const SizedBox(width: 5.0),
          buildText(
            text: secondWord,
            size: 24.0,
            weight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget buildDivider() {
    return Divider(thickness: 2.0, color: Colors.grey[100]);
  }

  Drawer buildDrawer() {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.close, size: 30.0),
              padding: const EdgeInsets.only(top: 40.0, left: 10.0),
              alignment: Alignment.topLeft,
              onPressed: () {
                Get.back();
              },
            ),
          ),
          Expanded(
            flex: 0,
            child: buildDrawerHeader(
              title: 'محمد أحمد',
              image: userImage
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                const SizedBox(height: 10.0),
                buildListTile(title: 'بحوثات محفوظة', icon: Icons.search),
                buildListTile(title: 'جميع اعجاباتي', icon: Icons.favorite_border),
                buildListTile(title: 'شارك التطبيق', icon: Icons.shortcut_outlined),
                buildListTile(title: 'اسئلة شائعة', icon: Icons.support_outlined),
                buildListTile(title: 'تواصل معنا', icon: Icons.email_outlined),
                buildListTile(title: 'اعدادات', icon: Icons.settings_outlined),
                buildListTile(title: 'سياسة الخصوصية', icon: Icons.policy_outlined),
                buildListTile(title: 'الخروج', icon: Icons.exit_to_app_outlined),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDrawerHeader({
    required String title,
    required String image,
  }) {
    return ListTile(
      onTap: () => Get.toNamed(AppPages.PROFILE),
      title: buildText(
        text: title,
        size: 24.0,
        weight: FontWeight.bold
      ),
      subtitle: buildText(text: 'الدخول الى صفحتي'),
      //contentPadding: EdgeInsets.only(top: 60.0, bottom: 0.0),
      contentPadding: const EdgeInsets.only(bottom: 20.0),
      tileColor: Colors.white,
      leading: CircleAvatar(
        radius: 50.0,
        backgroundImage: NetworkImage(image),
      ),
    );
  }

  Widget buildListTile({
    required String title,
    required IconData icon,
  }) {
    return ListTile(
      title: buildText(text: title, size: 18.0),
      leading: Icon(icon, color: Colors.black54),
      dense: true,
      onTap: () {},
    );
  }

}
