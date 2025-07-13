import 'dart:convert';
import 'dart:io';

import 'package:angkut_yuk/data/model/request/pelanggan/pelanggan_request_model.dart';
import 'package:angkut_yuk/data/model/response/get_all_kategori_response_model.dart';
import 'package:angkut_yuk/data/model/response/pelanggan_response_model.dart';
import 'package:angkut_yuk/services/service_http_client.dart';
import 'package:dartz/dartz.dart';

class PelangganRepository {
  final ServiceHttpClient httpClient;

  PelangganRepository(this.httpClient);

  Future<Either<String, DataPelanggan>> getProfile() async {
    try {
      final response = await httpClient.get("pelanggan/profile");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final pelanggan = DataPelanggan.fromMap(jsonResponse['data']);
        return Right(pelanggan);
      } else {
        final error = json.decode(response.body);
        return Left(error['message'] ?? 'Gagal mengambil data pelanggan');
      }
    } catch (e) {
      return _infopenyimpangan(e);
    }
  }

  Future<Either<String, String>> updateProfile(PelangganRequestModel request) async {
    try {
      final response = await httpClient.put(
        "pelanggan/update",
        request.toMap(),
      );

      if (response.statusCode == 200) {
        return Right("Data pelanggan berhasil diperbarui");
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Gagal memperbarui pelanggan');
      }
    } catch (e) {
      return _infopenyimpangan(e);
    }
  }

  Future<Either<String, String>> uploadFotoProfil(File imageFile) async {
    try {
      final response = await httpClient.uploadFile(
        file: imageFile,
        endPoint: 'pelanggan/update-foto',
        fieldName: 'foto',
      );
      if (response.statusCode == 200) {
        return Right("Foto berhasil diperbarui");
      } else {
        final body = await response.stream.bytesToString();
        return Left("Upload gagal: $body");
      }
    } catch (e) {
      return Left("Terjadi kesalahan: $e");
    }
  }

  Future<Either<String, GetAllKategoriResponseModel>> getAllKategoriuntukPelanggan() async {
    try {
      final response = await httpClient.get("pelanggan/kategori");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final kategoriResponse = GetAllKategoriResponseModel.fromJson(jsonResponse);
        return Right(kategoriResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return _infopenyimpangan(e);
    }
    }


  Either<String, T> _infopenyimpangan<T>(Object e) {
    if (e is SocketException) {
      return Left("Tidak ada koneksi internet");
    } else if (e is HttpException) {
      return Left("Kesalahan HTTP: ${e.message}");
    } else if (e is FormatException) {
      return Left("Format respons tidak valid");
    } else {
      return Left("Terjadi kesalahan tak terduga: $e");
    }
  }
}
