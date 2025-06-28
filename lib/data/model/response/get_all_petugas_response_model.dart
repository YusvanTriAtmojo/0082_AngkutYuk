import 'dart:convert';

class GetAllPetugasModel {
  final String message;
  final int statusCode;
  final List<Petugas> dataPetugas;

  GetAllPetugasModel({
    required this.message,
    required this.statusCode,
    required this.dataPetugas,
  });

  factory GetAllPetugasModel.fromRawJson(String str) =>
      GetAllPetugasModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetAllPetugasModel.fromJson(Map<String, dynamic> json) =>
      GetAllPetugasModel(
        message: json["message"],
        statusCode: json["status_code"],
        dataPetugas: List<Petugas>.from(
          json["data"].map((x) => Petugas.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status_code": statusCode,
        "data": List<dynamic>.from(dataPetugas.map((x) => x.toJson())),
      };
}

class Petugas {
  final int idPetugas;
  final int userId;
  final String namaPetugas;
  final String notlpPetugas;
  final String alamatPetugas;
  final String statusPetugas;

  Petugas({
    required this.idPetugas,
    required this.userId,
    required this.namaPetugas,
    required this.notlpPetugas,
    required this.alamatPetugas,
    required this.statusPetugas,
  });

  factory Petugas.fromRawJson(String str) =>
      Petugas.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Petugas.fromJson(Map<String, dynamic> json) => Petugas(
        idPetugas: json["id"],
        userId: json["user_id"],
        namaPetugas: json["nama_petugas"],
        notlpPetugas: json["notlp_petugas"],
        alamatPetugas: json["alamat_petugas"],
        statusPetugas: json["status_petugas"],
      );

  Map<String, dynamic> toJson() => {
        "id": idPetugas,
        "user_id": userId,
        "nama_petugas": namaPetugas,
        "notlp_petugas": notlpPetugas,
        "alamat_petugas": alamatPetugas,
        "status_petugas": statusPetugas,
      };
}
