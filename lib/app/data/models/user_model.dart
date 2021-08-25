import 'package:hive/hive.dart';
import 'package:shop_fever/app/utils/constants.dart';

part 'user_model.g.dart';

//TODO here we prepared the model to be like (table) in local(HIVE) db
//NOTE: there is auto generated (user_model.g.dart) file its from hive dont touch it nigga

@HiveType(typeId : 1)
class UserModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String photo;
  @HiveField(3)
  final String phone;
  @HiveField(4)
  final String? productPhoto;
  @HiveField(5)
  final int? productsCount;

  const UserModel({
    required this.id,
    required this.name,
    required this.photo,
    required this.phone,
    this.productsCount,
    this.productPhoto
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json[ID],
    name: json[NAME],
    photo: json[PHOTO],
    phone: json[PHONE],
    productsCount: json[PRODUCTS_COUNT],
    productPhoto: json[PRODUCT_PHOTO][0]
  );

  Map<String, dynamic> toJson() => {
    ID: id,
    NAME: name,
    PHONE: phone,
    PHOTO: photo,
  };
}
