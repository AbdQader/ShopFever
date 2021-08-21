import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:shop_fever/app/utils/components.dart';
import '../controllers/product_details_controller.dart';

class ProductDetailsView extends GetView<ProductDetailsController> {
  final String desc = 'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيق. إذا كنت تحتاج إلى عدد أكبر من الفقرات يتيح لك مولد النص العربى زيادة عدد الفقرات كما تريد، النص لن يبدو مقسما ولا يحوي أخطاء لغوية، مولد النص العربى مفيد لمصممي المواقع على وجه الخصوص، حيث يحتاج العميل فى كثير من الأحيان أن يطلع على صورة حقيقية لتصميم الموقع.';
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
                        items: controller.images.map((image) {
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
                          dotsCount: controller.images.length,
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
                          text: 'مثلجات ايس كريم',
                          size: 24.0,
                          color: Colors.black,
                          weight: FontWeight.bold
                        ),
                        const SizedBox(height: 20.0),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            buildText(
                              text: '35 ILS',
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
                        buildText(text: desc, size: 20.0),
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
                                  title: 'رقم السلعة',
                                  value: '7260',
                                  icon: Icons.label_outline
                                ),
                                buildTableRow(
                                  title: 'الحالة',
                                  value: 'جديد',
                                  icon: Icons.label_outline
                                ),
                                buildTableRow(
                                  title: 'القسم',
                                  value: 'طعام',
                                  icon: Icons.label_outline
                                ),
                                buildTableRow(
                                  title: 'النوع',
                                  value: 'بضان',
                                  icon: Icons.label_outline
                                ),
                              ],
                            ),
                          ),
                        ),
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
      // child: Scaffold(
      //   backgroundColor: Colors.white,
      //   extendBodyBehindAppBar: true,
      //   appBar: AppBar(
      //     backgroundColor: Colors.black.withOpacity(0.2),
      //     elevation: 0.0,
      //     leading: IconButton(
      //       icon: const Icon(Icons.arrow_back, color: Colors.white),
      //       onPressed: () => Get.back(),
      //     ),
      //     actions: [
      //       IconButton(
      //         onPressed: () {},
      //         icon: const Icon(
      //           Icons.favorite_border,
      //           color: Colors.white
      //         ),
      //       ),
      //       IconButton(
      //         onPressed: () {},
      //         icon: const Icon(
      //           Icons.shortcut_outlined,
      //           color: Colors.white
      //         ),
      //       ),
      //     ],
      //   ),
      //   body: GetBuilder<ProductDetailsController>(
      //     builder: (controller) => ListView(
      //       children: [
      //         Stack(
      //           children: [
      //             CarouselSlider(
      //               items: controller.images.map((image) {
      //                 return Image(
      //                   image: NetworkImage(image),
      //                   width: double.infinity,
      //                   fit: BoxFit.cover,
      //                 );
      //               }).toList(),
      //               options: CarouselOptions(
      //                 height: 300.0,
      //                 initialPage: controller.currentIndex,
      //                 viewportFraction: 1,
      //                 onPageChanged: (index, reason) {
      //                   controller.changeCurrentIndex(index);
      //                 },
      //               ),
      //             ),
      //             Positioned(
      //               bottom: 20,
      //               right: 165,
      //               child: DotsIndicator(
      //                 dotsCount: controller.images.length,
      //                 position: controller.currentIndex.toDouble(),
      //                 decorator: DotsDecorator(
      //                   size: Size.square(8.0),
      //                   activeSize: Size.square(10.0),
      //                   activeColor: Colors.white,
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //         Container(
      //           padding: const EdgeInsets.all(10.0),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               buildText(
      //                 text: 'مثلجات ايس كريم',
      //                 size: 24.0,
      //                 color: Colors.black,
      //                 weight: FontWeight.bold
      //               ),
      //               const SizedBox(height: 20.0),
      //               Row(
      //                 crossAxisAlignment: CrossAxisAlignment.end,
      //                 children: [
      //                   buildText(
      //                     text: '35 ILS',
      //                     size: 24.0,
      //                     color: Get.theme.accentColor,
      //                     weight: FontWeight.bold
      //                   ),
      //                   const Spacer(),
      //                   const Icon(Icons.favorite_border, size: 20.0),
      //                   const SizedBox(width: 10.0),
      //                   const Text('23'),
      //                   const SizedBox(width: 20.0),
      //                   const Icon(Icons.remove_red_eye_outlined, size: 20.0),
      //                   const SizedBox(width: 10.0),
      //                   const Text('2078'),
      //                 ],
      //               ),
      //               const SizedBox(height: 20.0),
      //               const Divider(height: 10),
      //               buildText(
      //                 text: desc,
      //                 size: 20.0,
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      //   floatingActionButton: buildFloatingActionButton(
      //     title: 'تواصل معي',
      //     icon: Icons.phone,
      //     width: 150.0,
      //     onPressed: () {}
      //   ),
      // ),
    );
  }

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

}
