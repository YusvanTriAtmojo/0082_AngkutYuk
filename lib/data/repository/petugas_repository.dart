import 'dart:convert';
import 'dart:io';

import 'package:angkut_yuk/data/model/request/admin/petugas_request_model.dart';
import 'package:angkut_yuk/data/model/response/get_all_petugas_response_model.dart';
import 'package:angkut_yuk/services/service_http_client.dart';
import 'package:dartz/dartz.dart';

class PetugasRepository {
  final ServiceHttpClient httpClient;

  PetugasRepository(this.httpClient);

  Future<Either<String, GetAllPetugasModel>> getAllPetugas() async {
    try {
      final response = await httpClient.get("admin/petugas");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final petugasResponse = GetAllPetugasModel.fromJson(jsonResponse);
        return Right(petugasResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return _infopenyimpangan(e);
    }
  }

  Future<Either<String, String>> createPetugas(PetugasRequestModel request) async {
    try {
      final response = await httpClient.postWithToken(
        "admin/petugas",
        request.toJson(),
      );

      if (response.statusCode == 201) {
        return Right("Petugas berhasil ditambahkan");
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Gagal menambahkan petugas');
      }
    } catch (e) {
      return _infopenyimpangan(e);
    }
  }

  Future<Either<String, String>> deletePetugas(int id) async {
    try {
      final response = await httpClient.delete(
        "admin/petugas/$id",
      );

      if (response.statusCode == 200) {
        return Right("Petugas berhasil dihapus");
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Gagal menghapus petugas');
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
