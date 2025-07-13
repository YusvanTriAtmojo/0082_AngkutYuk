import 'dart:convert';
import 'dart:io';

import 'package:angkut_yuk/data/model/request/admin/kendaraan_request_model.dart';
import 'package:angkut_yuk/data/model/response/get_all_kendaraan_response_model.dart';
import 'package:angkut_yuk/services/service_http_client.dart';
import 'package:dartz/dartz.dart';

class KendaraanRepository {
  final ServiceHttpClient httpClient;

  KendaraanRepository(this.httpClient);

  Future<Either<String, GetAllKendaraanModel>> getAllKendaraan() async {
    try {
      final response = await httpClient.get("admin/kendaraan");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final kendaraanResponse = GetAllKendaraanModel.fromJson(jsonResponse);
        return Right(kendaraanResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return _infopenyimpangan(e);
    }
  }

  Future<Either<String, String>> createKendaraan(KendaraanRequestModel request) async {
    try {
      final response = await httpClient.postWithToken(
        "admin/kendaraan",
        request.toJson(),
      );

      if (response.statusCode == 201) {
        return Right("Kendaraan berhasil ditambahkan");
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Gagal menambahkan kendaraan');
      }
    } catch (e) {
      return _infopenyimpangan(e);
    }
  }

  Future<Either<String, String>> updateKendaraan(
    int idKendaraan,
    KendaraanRequestModel request,
  ) async {
    try {
      final response = await httpClient.put(
        "admin/kendaraan/$idKendaraan",
        request.toJson(),
      );

      if (response.statusCode == 200) {
        return Right("Kendaraan berhasil diubah");
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Gagal mengubah kendaraan');
      }
    } catch (e) {
      return _infopenyimpangan(e);
    }
  }

  Future<Either<String, String>> deleteKendaraan(int id) async {
    try {
      final response = await httpClient.delete(
        "admin/kendaraan/$id",
      );

      if (response.statusCode == 200) {
        return Right("Kendaraan berhasil dihapus");
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Gagal menghapus kendaraan');
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
