import 'package:get_storage/get_storage.dart';

class SharedPref
{
  //keys
  static final STORAGE_USER_LOGGED_KEY = 'user_logged';
  static final CONTAINER_NAME = 'container';

  //storage instance
  static final storage = GetStorage(CONTAINER_NAME);

  ///check if user logged in before (and go to home directly if he is)
  static bool isUserLogged() {
    try {
      bool? hasLogged = storage.read(STORAGE_USER_LOGGED_KEY);
      return hasLogged ?? false;
    } catch(error) {
      return false;
    }
  }

  ///save user as logged
  static bool setUserAsLogged() {
    try {
      storage.write(STORAGE_USER_LOGGED_KEY, true);
      return true;
    } catch(error) {
      return false;
    }
  }
  
  ///save user as logged out
  static bool setUserAsLoggedOut() {
    try {
      storage.write(STORAGE_USER_LOGGED_KEY, false);
      return true;
    } catch(error) {
      return false;
    }
  }

}