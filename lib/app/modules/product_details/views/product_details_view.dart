import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:shop_fever/app/data/models/product_model.dart';
import 'package:shop_fever/app/utils/components.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  final String desc = 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق. إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوية، مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص، حيث يحتاج العميل فى كثير من الأحيان أن يطلع على صورة حقيقية لتصميم الموقع.';
  final String profile = 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80';
  final ProductModel product = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<ProductDetailsController>(
          builder: (controller) => CustomScrollView(
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
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Colors.white
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
                      CarouselSlider(
                        items: product.photos.map((image) {
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
                      Positioned(
                        bottom: 20,
                        right: 165,
                        child: DotsIndicator(
                          dotsCount: product.photos.length,
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
                          text: product.name,
                          size: 24.0,
                          color: Colors.black,
                          weight: FontWeight.bold
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            buildText(
                              text: '${product.price} ILS',
                              size: 24.0,
                              color: Get.theme.accentColor,
                              weight: FontWeight.bold
                            ),
                            const Spacer(),
                            const Icon(Icons.favorite_border, size: 20.0),
                            const SizedBox(width: 10.0),
                            const Text('23'),
                            const SizedBox(width: 20.0),
                            const Icon(Icons.remove_red_eye_outlined, size: 20.0),
                            const SizedBox(width: 10.0),
                            const Text('2078'),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        const Divider(height: 40.0),
                        buildText(
                          text: product.description,
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
                                  value: product.sold ? 'مباع' : 'متوفر',
                                  icon: Icons.sell_outlined
                                ),
                                buildTableRow(
                                  title: 'الحالة',
                                  value: product.isItUsed ? 'مستخدم' : 'جديد',
                                  icon: Icons.inventory_2_outlined
                                ),
                                buildTableRow(
                                  title: 'الفئة',
                                  value: controller.productCategory(product.categoryId),
                                  icon: Icons.label_outline
                                ),
                                buildTableRow(
                                  title: 'التاريخ',
                                  value: controller.productPublishDate(product.publishDate),
                                  icon: Icons.date_range
                                ),
                              ],
                            ),
                          ),
                        ),
                        buildGoogleMap(),
                        const Divider(height: 40.0, color: Colors.grey),
                        buildListTile(),
                        const SizedBox(height: 60.0)
                      ],
                    ),
                  ),
                ]),
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

  // For ListTile
  Widget buildListTile() {
    return ListTile(
      onTap: () {},
      leading: CircleAvatar(
        radius: 30.0,
        backgroundImage: NetworkImage(profile),
      ),
      title: buildText(
        text: 'بضان ابن بضان',
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
