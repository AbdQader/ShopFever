import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final String profile = 'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80';
  final String cover = 'https://timelinecovers.pro/facebook-cover/download/blue-bubbles-facebook-cover.jpg';
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.favorite_border,
                color: Colors.white
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shortcut_outlined,
                color: Colors.white
              ),
            ),
          ],
        ),
        body: Container(
          height: double.infinity,
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
                top: 150.0,
                right: 30.0,
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(profile),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
