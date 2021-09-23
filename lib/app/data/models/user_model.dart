import 'package:hive/hive.dart';
import 'package:shop_fever/app/utils/constants.dart';
part 'user_model.g.dart';

//here we prepared the model to be like (table) in local(HIVE) db
//NOTE: there is auto generated (user_model.g.dart) file its from hive dont touch it nigga

@HiveType(typeId : 1)
class UserModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String token;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final String photo;
  @HiveField(4)
  final String phone;
  @HiveField(5)
  final String? productPhoto;
  @HiveField(6)
  final int? productsCount;

  const UserModel({
    required this.token,
    required this.name,
    required this.photo,
    required this.phone,
    this.productsCount,
    this.productPhoto,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    var photo = null;
    try {
      photo = json[Constants.PRODUCT_PHOTO][0];
    } catch (error) {}
    return UserModel(
      name: json[Constants.NAME],
      id: json[Constants.ID],
      token: json[Constants.TOKEN] ?? 'emad is a bitch',
      photo: json[Constants.PHOTO],
      phone: json[Constants.PHONE],
      productsCount: json[Constants.PRODUCTS_COUNT],
      productPhoto: photo
    );
  }

  Map<String, dynamic> toJson() => {
    Constants.ID: id,
    Constants.TOKEN: token,
    Constants.NAME: name,
    Constants.PHONE: phone,
    Constants.PHOTO: photo,
    Constants.PRODUCTS_COUNT: productsCount,
    Constants.PRODUCT_PHOTO: productPhoto,
  };
}
