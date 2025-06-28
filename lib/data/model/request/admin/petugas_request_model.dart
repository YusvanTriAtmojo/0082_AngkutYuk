import 'dart:convert';

class PetugasRequestModel {
    final int? userId;
    final String? namaPetugas;
    final String? notlpPetugas;
    final String? alamatPetugas;
    final String? statusPetugas;
    final String? email;
    final String? password;


    PetugasRequestModel({
        this.userId,
        this.namaPetugas,
        this.notlpPetugas,
        this.alamatPetugas,
        this.statusPetugas,
        this.email,
        this.password,
    });

    factory PetugasRequestModel.fromJson(String str) => PetugasRequestModel.fromMap(json.decode(str));

    Map<String, dynamic> toJson() => toMap();

    factory PetugasRequestModel.fromMap(Map<String, dynamic> json) => PetugasRequestModel(
        userId: json["user_id"],
        namaPetugas: json["nama_petugas"],
        notlpPetugas: json["notlp_petugas"],
        alamatPetugas: json["alamat_petugas"],
        statusPetugas: json["status_petugas"],
        email: json["email"],
        password: json["password"],
    );

    Map<String, dynamic> toMap() => {
        "user_id": userId,
        "nama_petugas": namaPetugas,
        "notlp_petugas": notlpPetugas,
        "alamat_petugas": alamatPetugas,
        "status_petugas": statusPetugas,
        "email": email,
        "password": password,
    };
}
