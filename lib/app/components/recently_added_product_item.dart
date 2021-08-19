import 'package:flutter/material.dart';

class RecentlyAddedProductItem extends StatelessWidget {

  final String image;
  const RecentlyAddedProductItem({required this.image});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: 110.0,
        height: 100.0,
        margin: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 10.0),
        padding: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: Colors.white, width: 3.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0),
            )
          ],
        ),
      ),
    );
  }
}