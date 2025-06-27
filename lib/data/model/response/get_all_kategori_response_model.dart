import 'dart:convert';

class GetAllKategoriResponseModel {
  final String message;
  final int statusCode;
  final List<Kategori> dataKategori;

  GetAllKategoriResponseModel({
    required this.message,
    required this.statusCode,
    required this.dataKategori,
  });

  factory GetAllKategoriResponseModel.fromRawJson(String str) =>
      GetAllKategoriResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllKategoriResponseModel.fromJson(Map<String, dynamic> json) =>
      GetAllKategoriResponseModel(
        message: json["message"],
        statusCode: json["status_code"],
        dataKategori: List<Kategori>.from(
          json["data"].map((x) => Kategori.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "data": List<dynamic>.from(dataKategori.map((x) => x.toJson())),
      };
}

class Kategori {
  final int id;
  final String namaKategori;

  Kategori({
    required this.id,
    required this.namaKategori,
  });

  factory Kategori.fromRawJson(String str) =>
      Kategori.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Kategori.fromJson(Map<String, dynamic> json) => Kategori(
        id: json["id_kategori"],
        namaKategori: json["nama_kategori"],
      );

  Map<String, dynamic> toJson() => {
        "id_kategori": id,
        "nama_kategori": namaKategori,
      };
}
