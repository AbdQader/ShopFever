import 'package:flutter/material.dart';
import 'package:shop_fever/app/data/models/category_model.dart';
import 'package:shop_fever/app/utils/components.dart';

class CategoryItem extends StatelessWidget {

  final CategoryModel categoryModel;

  const CategoryItem({required this.categoryModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Image(
              image: NetworkImage(categoryModel.photo),
              width: 80.0,
              height: 80.0,
            ),
          ),
          // Container(
          //   width: 80.0,
          //   height: 80.0,
          //   margin: EdgeInsets.symmetric(horizontal: 5.0),
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: NetworkImage(categoryModel.photo),
          //     ),
          //   ),
          // ),
          const SizedBox(height: 5.0),
          Container(
            constraints: BoxConstraints(maxWidth: 70.0),
            child: buildText(
              text: categoryModel.name,
              size: 16.0,
              weight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}