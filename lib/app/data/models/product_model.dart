class ProductModel {

  final List<dynamic> photos;
  final String publishDate;
  final bool sold;
  final String id;
  final String userId;
  final String name;
  final String description;
  final int price;
  final String currency;
  final bool isItUsed;
  final String categoryId;

  ProductModel({
    required this.photos,
    required this.publishDate,
    required this.sold,
    required this.id,
    required this.userId,
    required this.name,
    required this.description,
    required this.price,
    required this.currency,
    required this.isItUsed,
    required this.categoryId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    photos: json["photos"],
    publishDate: json["publishDate"],
    sold: json["sold"],
    id: json["_id"],
    userId: json["userId"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    currency: json["currency"],
    isItUsed: json["isItUsed"],
    categoryId: json["categoryId"],
  );

  Map<String, dynamic> toJson() => {
    "photos": photos,
    "publishDate": publishDate,
    "sold": sold,
    "_id": id,
    "userId": userId,
    "name": name,
    "description": description,
    "price": price,
    "currency": currency,
    "isItUsed": isItUsed,
    "categoryId": categoryId,
  };
}
