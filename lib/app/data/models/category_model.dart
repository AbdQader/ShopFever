import 'package:shop_fever/app/utils/constants.dart';

class CategoryModel {

  final String id;
  final String name;
  final String photo;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.photo,   
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json[ID],
    name: json[NAME],
    photo: json[PHOTO],
  );

  Map<String, dynamic> toJson() => {
    ID: id,
    NAME: name,
    PHOTO: photo,
  };

}