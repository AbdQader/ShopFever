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
    id: json[Constants.ID],
    name: json[Constants.NAME],
    photo: json[Constants.PHOTO],
  );

  Map<String, dynamic> toJson() => {
    Constants.ID: id,
    Constants.NAME: name,
    Constants.PHOTO: photo,
  };

}