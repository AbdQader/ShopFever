import 'package:flutter/material.dart';
import 'package:shop_fever/app/utils/components.dart';

class EmptyView extends StatelessWidget {
  final String text;
  const EmptyView({ required this.text });
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_outlined,
            size: 130,
            color: Colors.black,
          ),
          const SizedBox(height: 30),
          buildText(
            text: text,
            size: 24.0,
            color: Colors.black,
            weight: FontWeight.bold,
          ),
        ],
      )
    );
  }
}