import 'dart:convert';

class PelangganPesananResponseModel {
  final String message;
  final int statusCode;
  final DataPelangganPesanan? data;

  PelangganPesananResponseModel({
    required this.message,
    required this.statusCode,
    this.data,
  });

  factory PelangganPesananResponseModel.fromRawJson(String str) =>
      PelangganPesananResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PelangganPesananResponseModel.fromJson(Map<String, dynamic> json) =>
      PelangganPesananResponseModel(
        message: json["message"],
        statusCode: json["status_code"],
        data: json["data"] != null
            ? DataPelangganPesanan.fromJson(json["data"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "data": data?.toJson(),
      };
}

class DataPelangganPesanan {
  final int id;
  final String namaPelanggan;

  DataPelangganPesanan({
    required this.id,
    required this.namaPelanggan,
  });

  factory DataPelangganPesanan.fromRawJson(String str) =>
      DataPelangganPesanan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataPelangganPesanan.fromJson(Map<String, dynamic> json) =>
      DataPelangganPesanan(
        id: json["id"],
        namaPelanggan: json["nama_pelanggan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_pelanggan": namaPelanggan,
      };
}
