import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_fever/app/modules/home/controllers/home_controller.dart';
import 'package:shop_fever/app/routes/app_pages.dart';
import 'package:shop_fever/app/utils/components.dart';

class DrawerView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.close, size: 30.0),
              padding: const EdgeInsets.only(top: 40.0, left: 10.0),
              alignment: Alignment.topLeft,
              onPressed: () => Get.back(),
            ),
          ),
          Expanded(
            flex: 0,
            child: ListTile(
              onTap: () => Get.toNamed(AppPages.PROFILE),
              title: buildText(
                text: controller.currentUser.name,
                size: 24.0,
                weight: FontWeight.bold
              ),
              subtitle: buildText(text: 'الدخول الى صفحتي'),
              contentPadding: const EdgeInsets.only(bottom: 20.0),
              tileColor: Colors.white,
              leading: CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(controller.currentUser.photo),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                const SizedBox(height: 10.0),
                buildListTile(
                  title: 'بحوثات محفوظة',
                  icon: Icons.search,
                  onTap: () {}
                ),
                buildListTile(
                  title: 'جميع اعجاباتي',
                  icon: Icons.favorite_border,
                  onTap: () {}
                ),
                buildListTile(
                  title: 'شارك التطبيق',
                  icon: Icons.shortcut_outlined,
                  onTap: () {}
                ),
                buildListTile(
                  title: 'اسئلة شائعة',
                  icon: Icons.support_outlined,
                  onTap: () {}
                ),
                buildListTile(
                  title: 'تواصل معنا',
                  icon: Icons.email_outlined,
                  onTap: () {}
                ),
                buildListTile(
                  title: 'اعدادات',
                  icon: Icons.settings_outlined,
                  onTap: () {}
                ),
                buildListTile(
                  title: 'سياسة الخصوصية',
                  icon: Icons.policy_outlined,
                  onTap: () {}
                ),
                buildListTile(
                  title: 'الخروج',
                  icon: Icons.exit_to_app_outlined,
                  onTap: () {}
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ListTile buildListTile({
    required String title,
    required IconData icon,
    required Function onTap,
  }) {
    return ListTile(
      onTap: onTap(),
      title: buildText(text: title, size: 18.0),
      leading: Icon(icon, color: Colors.black54),
      dense: true,
    );
  }

}
