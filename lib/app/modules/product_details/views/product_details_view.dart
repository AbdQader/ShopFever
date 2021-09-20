import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:shop_fever/app/modules/home/controllers/home_controller.dart';
import 'package:shop_fever/app/modules/profile/controllers/profile_controller.dart';
import 'package:shop_fever/app/routes/app_pages.dart';
import 'package:shop_fever/app/utils/components.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 270.0,
              pinned: true,
              backgroundColor: Colors.black.withOpacity(0.2),
              leading: IconButton(
                icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white
                ),
                onPressed: () => Get.back(),
              ),
              actions: [
                GetBuilder<ProductDetailsController>(
                  id: 'Favorites',
                  builder: (controller) => controller.isFavLoading
                  ? Transform.scale(
                      scale: 0.5,
                      child: showProgressIndicator(),
                    )
                  : IconButton(
                      onPressed: () => controller.markProductAsFavorites(controller.product.id),
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
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                      Icons.shortcut_outlined,
                      color: Colors.white
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    GetBuilder<ProductDetailsController>(
                      id: 'ImageSlider',
                      builder: (controller) => CarouselSlider(
                        items: controller.product.photos.map((image) {
                          return Image(
                            image: NetworkImage(image),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          );
                        }).toList(),
                        options: CarouselOptions(
                          height: 300.0,
                          initialPage: controller.currentIndex,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            controller.changeCurrentIndex(index);
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 165,
                      child: DotsIndicator(
                        dotsCount: controller.product.photos.length,
                        position: controller.currentIndex.toDouble(),
                        decorator: DotsDecorator(
                          size: Size.square(8.0),
                          activeSize: Size.square(10.0),
                          activeColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildText(
                          text: controller.product.name,
                          size: 24.0,
                          color: Colors.black,
                          weight: FontWeight.bold
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          buildText(
                              text: controller.product.currency.startsWith('s') ? '${controller.product.price}ILS' : "${controller.product.price}Dollar",
                              size: 24.0,
                              color: Get.theme.accentColor,
                              weight: FontWeight.bold
                          ),
                          const Spacer(),
                          const Icon(Icons.favorite_border, size: 20.0),
                          const SizedBox(width: 10.0),
                          GetBuilder<ProductDetailsController>(
                            id: 'FavTimes',
                            builder: (controller) => Text(
                              controller.favTimes.toString()
                            )
                          ),
                          const SizedBox(width: 20.0),
                          const Icon(Icons.remove_red_eye_outlined, size: 20.0),
                          const SizedBox(width: 10.0),
                          GetBuilder<ProductDetailsController>(
                            id: 'WatchedTimes',
                            builder: (controller) => Text(
                              controller.watchedTimes.toString()
                            )
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      const Divider(height: 40.0),
                      buildText(
                        text: controller.product.description,
                        size: 20.0
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          const Icon(Icons.history, size: 20.0, color: Colors.grey),
                          const SizedBox(width: 10.0),
                          buildText(text: 'تم التعديل قبل دقائق', size: 18.0, color: Colors.grey),
                          const SizedBox(width: 20.0),
                          const Icon(Icons.location_on_outlined, size: 20.0, color: Colors.grey),
                          const SizedBox(width: 10.0),
                          buildText(text: '2.0KM', size: 18.0, color: Colors.grey),
                        ],
                      ),
                      const Divider(height: 40.0, color: Colors.grey),
                      Card(
                        elevation: 5.0,
                        margin: const EdgeInsets.all(10.0),
                        child: Container(
                          color: Colors.white,
                          child: Table(
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            border: TableBorder.all(
                              color: Colors.grey[300]!,
                              width: 0.5,
                            ),
                            children: [
                              buildTableRow(
                                  title: 'البيع',
                                  value: controller.product.sold ? 'مباع' : 'متوفر',
                                  icon: Icons.sell_outlined
                              ),
                              buildTableRow(
                                  title: 'الحالة',
                                  value: controller.product.isItUsed ? 'مستخدم' : 'جديد',
                                  icon: Icons.inventory_2_outlined
                              ),
                              buildTableRow(
                                  title: 'الفئة',
                                  value: controller.productCategory(controller.product.categoryId),
                                  icon: Icons.label_outline
                              ),
                              buildTableRow(
                                  title: 'التاريخ',
                                  value: controller.productPublishDate(controller.product.publishDate),
                                  icon: Icons.date_range
                              ),
                            ],
                          ),
                        ),
                      ),
                      buildGoogleMap(),
                      const Divider(height: 40.0, color: Colors.grey),
                      ListTile(
                        onTap: () {
                          Get.find<HomeController>().currentClickedUser = controller.product.user;
                          Get.toNamed(AppPages.PROFILE);
                        },
                        leading: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(controller.product.user.photo),
                        ),
                        title: buildText(
                          text: controller.product.user.name,
                          size: 20.0,
                        ),
                        subtitle: Column(
                          children: [
                            buildStarRating(
                              starCount: 5,
                              rating: 2.5,
                              onRatingChanged: (rating) {},
                              color: Colors.amber
                            ),
                            Row(
                              children: [
                                Icon(Icons.location_on_outlined, color: Colors.grey),
                                SizedBox(width: 5.0),
                                buildText(text: 'فلسطين', size: 18.0)
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
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

  // For TableRow
  TableRow buildTableRow({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 24.0,
                ),
                const SizedBox(width: 10.0),
                buildText(
                  text: title,
                  size: 20.0,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: buildText(
                text: value,
                size: 18.0,
                weight: FontWeight.bold
            ),
          ),
        ]
    );
  }

  // For GoogleMap
  Widget buildGoogleMap() {
    //Completer<GoogleMapController> _controller = Completer();
    final CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(31.5000, 34.4667),
      zoom: 14.4746,
    );
    return Container(
      width: double.infinity,
      height: 300.0,
      padding: const EdgeInsets.all(10.0),
      child: GoogleMap(
        //mapType: MapType.hybrid,
        initialCameraPosition: _cameraPosition,
        // onMapCreated: (GoogleMapController controller) {
        //   _controller.complete(controller);
        // },
      ),
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

}