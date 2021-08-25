import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_fever/app/data/local/my_hive.dart';
import 'package:shop_fever/app/data/models/user_model.dart';
import 'app/data/local/sharedPref.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //TODO INIT SHARED AND LOCAL-DB
  //init shared pref
  await GetStorage.init(SharedPref.CONTAINER_NAME);
  //init local database
  var directory = await getApplicationDocumentsDirectory();
  Hive..init(directory.path)..registerAdapter(UserModelAdapter());
  //TODO FOR TESTING after you login
  Logger().e('Is user logged => ${SharedPref.isUserLogged()}');
  Logger().e('Current user => ${(await MyHive.getCurrentUser())}');
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        accentColor: Color(0xFF57bf72),
      ),
      initialRoute: SharedPref.isUserLogged() ? AppPages.INITIAL : AppPages.LOGIN,
      getPages: AppPages.routes,
    ),
  );
}
