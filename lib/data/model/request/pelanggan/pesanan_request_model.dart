import 'dart:convert';

class PesananRequestModel {
  final String alamatJemput;
  final double latJemput;
  final double lngJemput;
  final String alamatTujuan;
  final double latTujuan;
  final double lngTujuan;
  final double? jarakKm;
  final int? biaya;
  final String tanggalJemput;
  final int idKategori;
  final String namaKategori;

  PesananRequestModel({
    required this.alamatJemput,
    required this.latJemput,
    required this.lngJemput,
    required this.alamatTujuan,
    required this.latTujuan,
    required this.lngTujuan,
    required this.tanggalJemput,
    required this.idKategori,
    required this.namaKategori,
    this.jarakKm,
    this.biaya,
  });

  factory PesananRequestModel.fromJson(String str) =>
      PesananRequestModel.fromMap(json.decode(str));

  Map<String, dynamic> toJson() => toMap();

  factory PesananRequestModel.fromMap(Map<String, dynamic> json) =>
      PesananRequestModel(
        alamatJemput: json["alamat_jemput"],
        latJemput: (json["lat_jemput"] ?? 0).toDouble(),
        lngJemput: (json["lng_jemput"] ?? 0).toDouble(),
        alamatTujuan: json["alamat_tujuan"],
        latTujuan: (json["lat_tujuan"] ?? 0).toDouble(),
        lngTujuan: (json["lng_tujuan"] ?? 0).toDouble(),
        jarakKm: json["jarak_km"] != null ? (json["jarak_km"] ?? 0).toDouble() : null,
        biaya: json["biaya"],
        tanggalJemput: json["tanggal_jemput"],
        idKategori: json["id_kategori"],
        namaKategori: json["nama_kategori"] ?? '',
      );

  Map<String, dynamic> toMap() => {
        "alamat_jemput": alamatJemput,
        "lat_jemput": latJemput,
        "lng_jemput": lngJemput,
        "alamat_tujuan": alamatTujuan,
        "lat_tujuan": latTujuan,
        "lng_tujuan": lngTujuan,
        "jarak_km": jarakKm,
        "biaya": biaya,
        "tanggal_jemput": tanggalJemput,
        "id_kategori": idKategori,
        "nama_kategori": namaKategori,
      };
}
