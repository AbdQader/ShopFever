import 'package:logger/logger.dart';
import 'package:shop_fever/app/data/models/user_model.dart';

class ProductModel {
  final List<dynamic> photos;
  final String publishDate;
  final bool sold;
  final String id;
  final String name;
  final String description;
  final int price;
  final String currency;
  final bool isItUsed;
  final UserModel user;
  final String categoryId;

  ProductModel({
    required this.photos,
    required this.publishDate,
    required this.sold,
    required this.id,
    required this.name,
    required this.user,
    required this.description,
    required this.price,
    required this.currency,
    required this.isItUsed,
    required this.categoryId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    dynamic user;
    if (json["user"] == null) {
      user = {
        'photo': json['photo'],
        '_id': json['_id'],
        'name': json['username'],
        'phone': json['phone'],
      };
    } else {
      user = json["user"][0];
    }
    return ProductModel(
      photos: json["photos"],
      publishDate: json["publishDate"],
      sold: json["sold"],
      id: json["_id"],
      user: UserModel.fromJson(user),
      name: json["name"],
      description: json["description"],
      price: json["price"],
      currency: json["currency"],
      isItUsed: json["isItUsed"],
      categoryId: json["categoryId"],
    );
  }

  Map<String, dynamic> toJson() => {
        "photos": photos,
        "publishDate": publishDate,
        "sold": sold,
        "_id": id,
        "user": user,
        "name": name,
        "description": description,
        "price": price,
        "currency": currency,
        "isItUsed": isItUsed,
        "categoryId": categoryId,
      };
}
