// To parse this JSON data, do
//
//     final register = registerFromJson(jsonString);

import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  final String username;
  final String password;
  final String password2;
  final String email;
  final bool isSeller;

  Register({
    required this.username,
    required this.password,
    required this.password2,
    required this.email,
    required this.isSeller,
  });

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        username: json["username"],
        password: json["password"],
        password2: json["password2"],
        email: json["email"],
        isSeller: json["is_seller"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "password2": password2,
        "email": email,
        "is_seller": isSeller,
      };
}
