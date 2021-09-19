import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/components/special_product_item.dart';
import 'package:shop_fever/app/data/models/product_model.dart';
import 'package:shop_fever/app/data/models/user_model.dart';
import 'package:shop_fever/app/utils/components.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'ابحث عن السلع',
            style: TextStyle(
              fontSize: 22.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              buildFormField(
                controller: TextEditingController(),
                type: TextInputType.text,
                validate: () {},
                hint: 'ابحث...'
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0.0),
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2/3.33,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0,
                  ),
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return SpecialProductItem(
                      productModel: ProductModel(
                        categoryId: '',
                        currency: 'd',
                        description: '',
                        id: '',
                        isItUsed: false,
                        name: 'بضان عجل تازة',
                        photos: ['https://timelinecovers.pro/facebook-cover/download/blue-bubbles-facebook-cover.jpg'],
                        price: 99,
                        publishDate: '',
                        sold: false,
                        user: UserModel(id: '', name: '', phone: '', photo: '', token: ''),
                      )
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
