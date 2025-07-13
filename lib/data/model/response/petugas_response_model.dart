import 'dart:convert';

class PetugasResponseModel {
  final String message;
  final int statusCode;
  final DataPetugas? data;

  PetugasResponseModel({
    required this.message,
    required this.statusCode,
    this.data,
  });

  factory PetugasResponseModel.fromRawJson(String str) =>
      PetugasResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PetugasResponseModel.fromJson(Map<String, dynamic> json) =>
      PetugasResponseModel(
        message: json["message"],
        statusCode: json["status_code"],
        data: json["data"] != null ? DataPetugas.fromJson(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "data": data?.toJson(),
      };
}

class DataPetugas {
  final int id;
  final int userId;
  final String namaPetugas;
  final String notlpPetugas;
  final String alamatPetugas;
  final String email;

  DataPetugas({
    required this.id,
    required this.userId,
    required this.namaPetugas,
    required this.notlpPetugas,
    required this.alamatPetugas,
    required this.email,
  });

  factory DataPetugas.fromRawJson(String str) =>
      DataPetugas.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataPetugas.fromJson(Map<String, dynamic> json) => DataPetugas(
        id: json["id"],
        userId: json["user_id"],
        namaPetugas: json["nama_petugas"],
        notlpPetugas: json["notlp_petugas"],
        alamatPetugas: json["alamat_petugas"],
        email: json["user"]["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "nama_petugas": namaPetugas,
        "notlp_petugas": notlpPetugas,
        "alamat_petugas": alamatPetugas,
        "user": {
          "email": email,
        },
      };
}
