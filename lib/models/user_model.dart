import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

Map<String, dynamic> userModelToJson(UserModel data) => data.toJson();

class UserModel {
  final String uuid;
  final String username;
  final String email;
  final int age;
  final String jenisKelamin;
  final String diagnosisPenyakit;
  final String alamat;
  final String kontakPasien;
  final String kontakKeluarga;
  final Timestamp createdAt;
  final Timestamp updateAt;

  UserModel(
      {required this.uuid,
      required this.username,
      required this.email,
      required this.age,
      required this.jenisKelamin,
      required this.diagnosisPenyakit,
      required this.alamat,
      required this.kontakPasien,
      required this.kontakKeluarga,
      required this.createdAt,
      required this.updateAt});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uuid: json["uuid"] ?? '',
        username: json["username"] ?? '',
        email: json["email"] ?? '',
        age: json["age"],
        jenisKelamin: json["jenisKelamin"].toString().split('.').first,
        diagnosisPenyakit: json["diagnosisPenyakit"] ?? '',
        alamat: json["alamat"] ?? '',
        kontakPasien: json["kontakPasien"] ?? '',
        kontakKeluarga: json["kontakKeluarga"] ?? '',
        createdAt: json["createdAt"] as Timestamp,
        updateAt: json["updateAt"] as Timestamp,
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "username": username,
        "email": email,
        "age": age,
        "jenisKelamin": jenisKelamin,
        "diagnosisPenyakit": diagnosisPenyakit,
        "alamat": alamat,
        "kotakPasien": kontakPasien,
        "kontakKeluarga": kontakKeluarga,
        "createdAt": createdAt,
        "updateAt": updateAt,
      };
}
