import 'package:shop_fever/app/core/utils/constants.dart';

class UserModel {
  final String userId;
  final String userName;
  final String userImage;
  final String phoneNumber;

  const UserModel({
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    userId: json[USER_ID],
    userName: json[USER_NAME],
    userImage: json[USER_IMAGE],
    phoneNumber: json[PHONE_NUMBER],
  );

  Map<String, dynamic> toJson() => {
    USER_ID: userId,
    USER_NAME: userName,
    PHONE_NUMBER: phoneNumber,
    USER_IMAGE: userImage,
  };
}
