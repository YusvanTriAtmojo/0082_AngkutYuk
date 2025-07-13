import 'dart:convert';

class PelangganRequestModel {
  final String? namaPelanggan;
  final String? notlpPelanggan;
  final String? alamatPelanggan;

  PelangganRequestModel({
    this.namaPelanggan,
    this.notlpPelanggan,
    this.alamatPelanggan,
  });

  factory PelangganRequestModel.fromJson(String str) =>
      PelangganRequestModel.fromMap(json.decode(str));

  String toRawJson() => json.encode(toMap());

  factory PelangganRequestModel.fromMap(Map<String, dynamic> json) =>
      PelangganRequestModel(
        namaPelanggan: json["nama_pelanggan"],
        notlpPelanggan: json["notlp_pelanggan"],
        alamatPelanggan: json["alamat_pelanggan"],
      );

  Map<String, dynamic> toMap() => {
    "nama_pelanggan": namaPelanggan,
    "notlp_pelanggan": notlpPelanggan,
    "alamat_pelanggan": alamatPelanggan,
  };
}
