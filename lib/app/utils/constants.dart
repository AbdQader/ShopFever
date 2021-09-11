class Constants {

  // API Url's
  static String BASE_URL = 'https://selling-appx.herokuapp.com' ;
  //const String BASE_URL = 'http://192.168.0.109:3000' ;
  static String LOGIN_URL = '${BASE_URL}/api/v1/users/login';
  static String REGISTER_URL = '${BASE_URL}/api/v1/users/signUp';
  static String USER_LOCATION_URL = '${BASE_URL}/api/v1/users/location';
  static String CATEGORIES_URL = '${BASE_URL}/api/v1/categories';
  static String PRODUCTS_URL = '${BASE_URL}/api/v1/products';
  static String SPECIAL_USERS_URL = '${BASE_URL}/api/v1/users/special';
  static String SPECIAL_PRODUCTS_URL = '${BASE_URL}/api/v1/products/special';
  static String CLOSE_PRODUCTS_URL = '${BASE_URL}/api/v1/products/near';
  static String FAVORITE_PRODUCTS_URL = '${BASE_URL}/api/v1/products/favourite';
  static String WATCHED_PRODUCTS_URL = '${BASE_URL}/api/v1/products/watched';

  // API keywords
  static String API_AUTHORIZATION = 'authorization';
  static String API_CONTENT_TYPE = 'content-type';
  static String API_APPLICATION_JSON = 'application/json';
  static String API_ACCEPT = 'Accept';
  static String API_MULTIPART_DATA = 'multipart/form-data';
  static String API_STATUS = 'status';
  static String API_MESSAGE = 'message';
  static String API_SUCCESS = 'success';


  // Models Variables
  static String ID = "_id";
  static String TOKEN = 'token';
  static String NAME = 'name';
  static String PHOTO = 'photo';
  static String PHONE = 'phone';
  static String PRODUCT_PHOTO = 'photos';
  static String PRODUCTS_COUNT = 'productsCount';
  static String USER_ID = 'userId';
  static String SOLD = 'sold';
  static String PRICE = 'price';
  static String DESCRIPTION = 'description';
  static String CURRENCY = 'currency';
  static String IS_IT_USED = 'isItUsed';
  static String CATEGORY_ID = 'categoryId';
  static String PUBLISH_DATE = 'publishDate';
  static String PHOTOS = 'photos';

}