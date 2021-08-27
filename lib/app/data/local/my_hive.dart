import 'package:hive/hive.dart';
import 'package:shop_fever/app/data/models/user_model.dart';

class MyHive
{
  //box for user (its like table or seperated file for users)
  static Box? userHiveBox;

  //to make it singleton (only init box once)
  static Future<Box> getInstanceOfUserBox() async {
    if (userHiveBox == null) {
      userHiveBox = await Hive.openBox<UserModel>('notifications_box');
    }
    return userHiveBox!;
  }

  ///save user to locale DB
  static saveUser(UserModel user) async {
    var box = await getInstanceOfUserBox();
    await box.add(user);
  }

  ///get current user if it exist or return null
  static Future<UserModel?> getCurrentUser() async {
    var box = await getInstanceOfUserBox();
    try {
      return await box.getAt(0);
    } catch(error) {
      return null;
    }
  }

  ///delete all data on box
  static Future<void> clearDatabase() async {
    var box = await getInstanceOfUserBox();
    box.clear();
  }

}