import 'dart:convert';
import 'dart:io';

import 'package:angkut_yuk/data/model/request/admin/kategori_request_model.dart';
import 'package:angkut_yuk/data/model/response/get_all_kategori_response_model.dart';
import 'package:angkut_yuk/services/service_http_client.dart';
import 'package:dartz/dartz.dart';

class KategoriRepository {
  final ServiceHttpClient httpClient;

  KategoriRepository(this.httpClient);

  Future<Either<String, GetAllKategoriResponseModel>> getAllKategori() async {
    try {
      final response = await httpClient.get("admin/kategori");

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

  Future<Either<String, String>> createKategori(KategoriRequestModel request) async {
    try {
      final response = await httpClient.postWithToken(
        "admin/kategori",
        request.toJson(),
      );

      if (response.statusCode == 201) {
        return Right("Kategori berhasil ditambahkan");
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Gagal menambahkan kategori');
      }
    } catch (e) {
      return _infopenyimpangan(e);
    }
  }

  Future<Either<String, String>> deleteKategori(int id) async {
    try {
      final response = await httpClient.delete(
        "admin/kategori/$id",
      );

      if (response.statusCode == 200) {
        return Right("Kategori berhasil dihapus");
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Gagal menghapus kategori');
      }
    } catch (e) {
      return Left("Terjadi kesalahan: $e");
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
