import 'dart:convert';
import 'package:angkut_yuk/data/model/response/pelanggan_pesanan_response_model.dart';
import 'package:intl/intl.dart';

class PesananPetugasResponseModel {
  final String message;
  final int statusCode;
  final List<DataPesananPetugas> data;

  PesananPetugasResponseModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory PesananPetugasResponseModel.fromRawJson(String str) =>
      PesananPetugasResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PesananPetugasResponseModel.fromJson(Map<String, dynamic> json) =>
      PesananPetugasResponseModel(
        message: json["message"],
        statusCode: json["status_code"],
        data: List<DataPesananPetugas>.from(
          json["data"].map((x) => DataPesananPetugas.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataPesananPetugas {
  final int id;
  final int pelangganId;
  final int? petugasId;
  final int? idKendaraan;
  final int idKategori;
  final DateTime? tanggalJemput;
  final String alamatJemput;
  final String alamatTujuan;
  final double? latJemput;
  final double? lngJemput;
  final double? latTujuan;
  final double? lngTujuan;
  final double jarakKm;
  final int biaya;
  final String status;
  final String? fotoBuktiSelesai;
  final String namaKategori;
  final DataPelangganPesanan? pelanggan;

  DataPesananPetugas({
    required this.id,
    required this.pelangganId,
    this.petugasId,
    this.idKendaraan,
    required this.idKategori,
    this.tanggalJemput,
    required this.alamatJemput,
    required this.alamatTujuan,
    required this.latJemput,
    required this.lngJemput,
    required this.latTujuan,
    required this.lngTujuan,
    required this.jarakKm,
    required this.biaya,
    required this.status,
    this.fotoBuktiSelesai,
    required this.namaKategori,
    this.pelanggan,
  });

  factory DataPesananPetugas.fromRawJson(String str) =>
      DataPesananPetugas.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataPesananPetugas.fromJson(Map<String, dynamic> json) => DataPesananPetugas(
        id: json["id"],
        pelangganId: json["pelanggan_id"],
        petugasId: json["petugas_id"],
        idKendaraan: json["id_kendaraan"],
        idKategori: json["id_kategori"],
        tanggalJemput: json["tanggal_jemput"] != null
            ? DateTime.tryParse(json["tanggal_jemput"])
            : null,
        alamatJemput: json["alamat_jemput"],
        alamatTujuan: json["alamat_tujuan"],
        latJemput: double.tryParse(json["lat_jemput"].toString()) ?? 0.0,
        lngJemput: double.tryParse(json["lng_jemput"].toString()) ?? 0.0,
        latTujuan: double.tryParse(json["lat_tujuan"].toString()) ?? 0.0,
        lngTujuan: double.tryParse(json["lng_tujuan"].toString()) ?? 0.0,
        jarakKm: double.tryParse(json["jarak_km"].toString()) ?? 0.0,
        biaya: json["biaya"],
        status: json["status"],
        fotoBuktiSelesai: json["foto_bukti_selesai"],
        namaKategori: json["kategori"]?["nama_kategori"] ?? '',
        pelanggan: json["pelanggan"] != null
            ? DataPelangganPesanan.fromJson(json["pelanggan"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pelanggan_id": pelangganId,
        "petugas_id": petugasId,
        "id_kendaraan": idKendaraan,
        "id_kategori": idKategori,
        "tanggal_jemput": tanggalJemput != null
          ? DateFormat('yyyy-MM-dd HH:mm:ss').format(tanggalJemput!)
          : null,
        "alamat_jemput": alamatJemput,
        "alamat_tujuan": alamatTujuan,
        "lat_jemput": latJemput,
        "lng_jemput": lngJemput,
        "lat_tujuan": latTujuan,
        "lng_tujuan": lngTujuan,
        "jarak_km": jarakKm,
        "biaya": biaya,
        "status": status,
        "foto_bukti_selesai": fotoBuktiSelesai,
        "kategori": {"nama_kategori": namaKategori},
        "pelanggan": pelanggan?.toJson(),
      };
}
