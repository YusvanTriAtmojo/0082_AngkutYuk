import 'dart:convert';

class RegisterRequestModel {
    final String? name;
    final String? email;
    final String? password;
    final String? notlpPelanggan;
    final String? alamatPelanggan;

    RegisterRequestModel({
        this.name,
        this.email,
        this.password,
        this.notlpPelanggan,
        this.alamatPelanggan,
    });

    factory RegisterRequestModel.fromJson(String str) => RegisterRequestModel.fromMap(json.decode(str));

    Map<String, dynamic> toJson() => toMap();

    factory RegisterRequestModel.fromMap(Map<String, dynamic> json) => RegisterRequestModel(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        notlpPelanggan: json["notlp_pelanggan"],
        alamatPelanggan: json["alamat_pelanggan"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "password": password,
        "notlp_pelanggan": notlpPelanggan,
        "alamat_pelanggan": alamatPelanggan,
    };
}
