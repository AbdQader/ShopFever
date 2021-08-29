import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shop_fever/app/data/models/user_model.dart';
import 'package:shop_fever/app/routes/app_pages.dart';
import 'package:shop_fever/app/utils/components.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final String profile = 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80';
  final String cover = 'https://timelinecovers.pro/facebook-cover/download/blue-bubbles-facebook-cover.jpg';
  final String photo = 'https://www.weddingear.com/media/catalog/product/cache/1/thumbnail/600x/17f82f742ffe127f42dca9de82fb58b1/b/r/bridesmaid-gift-ideas-personalized-tumbler-25.jpg';
  final UserModel user = Get.arguments;
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
            // show this if it's other profile
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.white
              ),
            ),
            IconButton(
              onPressed: () => showBottomSheet(),
              icon: const Icon(
                //Icons.shortcut_outlined, // if other user profile
                Icons.more_vert, // if it's my profile
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
                          image: NetworkImage(cover),
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
                      onPressed: () {},
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
          padding: EdgeInsets.only(top: 10.0),
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
                      Icon(Icons.add, size: 30.0),
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
              GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(0.0),
                physics: BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  mainAxisExtent: 270,
                  childAspectRatio: 2/3,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                ),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return buildProfileProduct(
                    title: 'عصير فاخر',
                    image: photo,
                    price: 79.9
                  );
                },
              ),
              Center(child: buildText(text: 'Nothing To Show', size: 30.0))
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

  // For Profile Product
  Widget buildProfileProduct({
    required String title,
    required String image,
    required double price,
  }) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Card(
            elevation: 3.0,
            child: Container(
              width: 190.0,
              height: 260.0,
              padding: EdgeInsets.all(8.0),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image(
                      height: 170,
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border, size: 15.0),
                      const SizedBox(width: 10.0),
                      Text('23'),
                      const SizedBox(width: 50.0),
                      Icon(Icons.remove_red_eye_outlined, size: 15.0),
                      const SizedBox(width: 10.0),
                      Text('2078'),
                    ],
                  ),
                  buildText(
                    text: title,
                    size: 18.0,
                    weight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  buildText(
                    text: '$price ILS',
                    size: 16.0,
                    color: Get.theme.accentColor,
                    weight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis
                  ),
                ],
              ),
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
