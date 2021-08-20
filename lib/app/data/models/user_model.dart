import 'package:shop_fever/app/utils/constants.dart';

class UserModel {
  final String id;
  final String name;
  final String photo;
  final String phone;
  final String? productPhoto;
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
