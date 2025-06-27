import 'dart:convert';

class GetAllKendaraanModel {
  final String message;
  final int statusCode;
  final List<Kendaraan> dataKendaraan;

  GetAllKendaraanModel({
    required this.message,
    required this.statusCode,
    required this.dataKendaraan,
  });

  factory GetAllKendaraanModel.fromRawJson(String str) =>
      GetAllKendaraanModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllKendaraanModel.fromJson(Map<String, dynamic> json) =>
      GetAllKendaraanModel(
        message: json["message"],
        statusCode: json["status_code"],
        dataKendaraan: List<Kendaraan>.from(
          json["data"].map((x) => Kendaraan.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "data": List<dynamic>.from(dataKendaraan.map((x) => x.toJson())),
      };
}

class Kendaraan {
  final int idKendaraan;
  final String namaKendaraan;
  final int idKategori;
  final String? namaKategori;
  final String platNomor;
  final int kapasitasMuatan;
  final String statusKendaraan;

  Kendaraan({
    required this.idKendaraan,
    required this.namaKendaraan,
    required this.idKategori,
    required this.namaKategori,
    required this.platNomor,
    required this.kapasitasMuatan,
    required this.statusKendaraan,
  });

  factory Kendaraan.fromRawJson(String str) =>
      Kendaraan.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Kendaraan.fromJson(Map<String, dynamic> json) => Kendaraan(
        idKendaraan: json["id_kendaraan"],
        namaKendaraan: json["nama_kendaraan"],
        idKategori: json["id_kategori"],
        namaKategori: json["nama_kategori"],
        platNomor: json["plat_nomor"],
        kapasitasMuatan: json["kapasitas_muatan"],
        statusKendaraan: json["status_kendaraan"],
      );

  Map<String, dynamic> toJson() => {
        "id_kendaraan": idKendaraan,
        "nama_kendaraan": namaKendaraan,
        "id_kategori": idKategori,
        "nama_kategori": namaKategori,
        "plat_nomor": platNomor,
        "kapasitas_muatan": kapasitasMuatan,
        "status_kendaraan": statusKendaraan,
      };
}
