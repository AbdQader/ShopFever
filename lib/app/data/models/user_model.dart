import 'package:shop_fever/app/utils/constants.dart';

class UserModel {
  final String id;
  final String name;
  final String photo;
  final String phone;

  const UserModel({
    required this.id,
    required this.name,
    required this.photo,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json[ID],
    name: json[NAME],
    photo: json[PHOTO],
    phone: json[PHONE],
  );

  Map<String, dynamic> toJson() => {
    ID: id,
    NAME: name,
    PHONE: phone,
    PHOTO: photo,
  };
}
