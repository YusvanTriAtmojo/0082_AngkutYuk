import 'dart:convert';

class PelangganResponseModel {
  final String message;
  final int statusCode;
  final DataPelanggan? data;

  PelangganResponseModel({
    required this.message,
    required this.statusCode,
    this.data,
  });

  factory PelangganResponseModel.fromJson(String str) =>
      PelangganResponseModel.fromMap(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PelangganResponseModel.fromMap(Map<String, dynamic> json) =>
      PelangganResponseModel(
        message: json["message"],
        statusCode: json["status_code"],
        data: json["data"] != null ? DataPelanggan.fromMap(json["data"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "data": data?.toJson(),
      };
}

class DataPelanggan {
  final int id;
  final int userId;
  final String namaPelanggan;
  final String notlpPelanggan;
  final String alamatPelanggan;
  final String? fotoProfile;
  final String email;

  DataPelanggan({
    required this.id,
    required this.userId,
    required this.namaPelanggan,
    required this.notlpPelanggan,
    required this.alamatPelanggan,
    this.fotoProfile,
    required this.email,
  });

  factory DataPelanggan.fromMap(Map<String, dynamic> json) => DataPelanggan(
        id: json["id"],
        userId: json["user_id"],
        namaPelanggan: json["nama_pelanggan"],
        notlpPelanggan: json["notlp_pelanggan"],
        alamatPelanggan: json["alamat_pelanggan"],
        fotoProfile: json["foto_profile"],
        email: json["user"]?["email"] ?? '',
      );

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "nama_pelanggan": namaPelanggan,
        "notlp_pelanggan": notlpPelanggan,
        "alamat_pelanggan": alamatPelanggan,
        "foto_profile": fotoProfile,
        "email": email,
      };
}
