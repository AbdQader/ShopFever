import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shop_fever/app/data/models/user_model.dart';
import 'app/data/local/sharedPref.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Init Firebase
  await Firebase.initializeApp();
  // Init Shared pref
  await GetStorage.init(SharedPref.CONTAINER_NAME);
  // Init Local Database (Hive)
  var directory = await getApplicationDocumentsDirectory();
  Hive..init(directory.path)..registerAdapter(UserModelAdapter());
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