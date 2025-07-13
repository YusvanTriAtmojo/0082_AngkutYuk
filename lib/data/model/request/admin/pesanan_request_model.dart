import 'dart:convert';

class AdminPesananRequestModel {
  final String? status;
  final int? petugasId;
  final int? idKendaraan;
  final String? statusPetugas;  
  final String? statusKendaraan;

  AdminPesananRequestModel({
    this.status,
    this.petugasId,
    this.idKendaraan,
    this.statusPetugas,
    this.statusKendaraan,
  });

  factory AdminPesananRequestModel.fromJson(String str) =>
      AdminPesananRequestModel.fromMap(json.decode(str));

  Map<String, dynamic> toJson() => toMap();

  factory AdminPesananRequestModel.fromMap(Map<String, dynamic> json) =>
      AdminPesananRequestModel(
        status: json["status"],
        petugasId: json["petugas_id"],
        idKendaraan: json["id_kendaraan"],
        statusPetugas: json["status_petugas"],
        statusKendaraan: json["status_kendaraan"],
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "petugas_id": petugasId,
        "id_kendaraan": idKendaraan,
        "status_petugas": statusPetugas,
        "status_kendaraan": statusKendaraan
      };
}
