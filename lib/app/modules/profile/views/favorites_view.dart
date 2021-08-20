import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/utils/components.dart';

class FavoritesView extends GetView {
  final String profile = 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80';
  final String photo = 'https://www.weddingear.com/media/catalog/product/cache/1/thumbnail/600x/17f82f742ffe127f42dca9de82fb58b1/b/r/bridesmaid-gift-ideas-personalized-tumbler-25.jpg';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 2.0,
            title: buildText(
              text: 'المفضلة',
              size: 24.0,
              color: Colors.black,
              weight: FontWeight.bold
            ),
            iconTheme: IconThemeData(color: Colors.black),
            bottom: TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(
                  child: buildText(
                    text: 'السلع (5)',
                    size: 18.0,
                    color: Colors.black
                  ),
                ),
                Tab(
                  child: buildText(
                    text: 'المشتركين (6)',
                    size: 18.0,
                    color: Colors.black
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return buildFavoriteItem(
                    photo: profile,
                    title: 'عماد الدين البلتاجي',
                    subtitle: 'غير متوفر'
                  );
                },
              ),
              ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 4,
                itemBuilder: (BuildContext context, int index) {
                  return buildFavoriteItem(
                    photo: photo,
                    title: 'عصير بضان',
                    subtitle: '39.9 ILS',
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFavoriteItem({
    required String photo,
    required String title,
    required String subtitle,
  }) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image(
                  image: NetworkImage(photo),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200.0,
                ),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(30.0),
                      bottomLeft: const Radius.circular(30.0),
                      bottomRight: const Radius.circular(30.0),
                    )
                  ),
                  child: const Icon(
                    Icons.cancel_outlined,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            buildText(
              text: title,
              size: 24.0,
              color: Colors.black,
              weight: FontWeight.bold
            ),
            buildText(
              text: subtitle,
              size: 20.0,
              color: Get.theme.accentColor,
            ),
          ],
        ),
      ),
    );
  }

}
