import 'dart:convert';

class KendaraanRequestModel {
    final String? namaKendaraan;
    final int? idKategori;
    final String? platNomor;
    final int? kapasitasMuatan;
    final String? statusKendaraan;

    KendaraanRequestModel({
        this.namaKendaraan,
        this.idKategori,
        this.platNomor,
        this.kapasitasMuatan,
        this.statusKendaraan,
    });

    factory KendaraanRequestModel.fromJson(String str) => KendaraanRequestModel.fromMap(json.decode(str));

    Map<String, dynamic> toJson() => toMap();

    factory KendaraanRequestModel.fromMap(Map<String, dynamic> json) => KendaraanRequestModel(
        namaKendaraan: json["nama_kendaraan"],
        idKategori: json["id_kategori"],
        platNomor: json["plat_nomor"],
        kapasitasMuatan: json["kapasitas_muatan"],
        statusKendaraan: json["status_kendaraan"],
    );

    Map<String, dynamic> toMap() => {
        "nama_kendaraan": namaKendaraan,
        "id_kategori": idKategori,
        "plat_nomor": platNomor,
        "kapasitas_muatan": kapasitasMuatan,
        "status_kendaraan": statusKendaraan,
    };
}
