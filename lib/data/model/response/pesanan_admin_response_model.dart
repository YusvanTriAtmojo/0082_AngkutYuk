import 'dart:convert';
import 'package:angkut_yuk/data/model/response/pelanggan_pesanan_response_model.dart';

class PesananResponseModel {
  final String message;
  final int statusCode;
  final List<DataPesananAdmin> data;

  PesananResponseModel({
    required this.message,
    required this.statusCode,
    required this.data,
  });

  factory PesananResponseModel.fromRawJson(String str) =>
      PesananResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PesananResponseModel.fromJson(Map<String, dynamic> json) =>
      PesananResponseModel(
        message: json["message"],
        statusCode: json["status_code"],
        data: List<DataPesananAdmin>.from(
          json["data"].map((x) => DataPesananAdmin.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataPesananAdmin {
  final int id;
  final int pelangganId;
  final int? petugasId;
  final int? idKendaraan;
  final int idKategori;
  final DateTime? tanggalJemput;
  final String alamatJemput;
  final String alamatTujuan;
  final double jarakKm;
  final int biaya;
  final String status;
  final String? fotoBuktiSelesai;
  final String namaKategori;
  final DataPelangganPesanan? pelanggan;

  DataPesananAdmin({
    required this.id,
    required this.pelangganId,
    this.petugasId,
    this.idKendaraan,
    required this.idKategori,
    this.tanggalJemput,
    required this.alamatJemput,
    required this.alamatTujuan,
    required this.jarakKm,
    required this.biaya,
    required this.status,
    this.fotoBuktiSelesai,
    required this.namaKategori,
    this.pelanggan,
  });

  factory DataPesananAdmin.fromRawJson(String str) =>
      DataPesananAdmin.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DataPesananAdmin.fromJson(Map<String, dynamic> json) => DataPesananAdmin(
        id: json["id"],
        pelangganId: json["pelanggan_id"],
        petugasId: json["petugas_id"],
        idKendaraan: json["id_kendaraan"],
        idKategori: json["id_kategori"],
        tanggalJemput: json["tanggal_jemput"] != null
            ? DateTime.tryParse(json["tanggal_jemput"])
            : null,
        alamatJemput: json["alamat_jemput"] ?? '',
        alamatTujuan: json["alamat_tujuan"] ?? '',
        jarakKm: double.tryParse(json["jarak_km"].toString()) ?? 0.0,
        biaya: json["biaya"] ?? 0,
        status: json["status"] ?? '',
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
        "tanggal_jemput": tanggalJemput?.toIso8601String(),
        "alamat_jemput": alamatJemput,
        "alamat_tujuan": alamatTujuan,
        "jarak_km": jarakKm,
        "biaya": biaya,
        "status": status,
        "foto_bukti_selesai": fotoBuktiSelesai,
        "kategori": {
          "nama_kategori": namaKategori,
        },
        "pelanggan": pelanggan?.toJson(),
      };
}
