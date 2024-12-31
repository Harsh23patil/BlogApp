import 'package:blog_app/core/common/entity/user.dart';
import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel extends User {
  UserModel({
    required super.id,
    required super.email,
    required super.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "password": password,
      };

  UserModel copyWith({
    String? id,
    String? email,
    String? password,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
