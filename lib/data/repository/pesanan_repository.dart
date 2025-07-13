import 'dart:convert';
import 'dart:io';

import 'package:angkut_yuk/data/model/request/admin/pesanan_request_model.dart';
import 'package:angkut_yuk/data/model/request/pelanggan/pesanan_request_model.dart';
import 'package:angkut_yuk/data/model/response/pesanan_admin_response_model.dart';
import 'package:angkut_yuk/data/model/response/pesanan_petugas_response_model.dart';
import 'package:angkut_yuk/data/model/response/pesanan_response_model.dart';
import 'package:angkut_yuk/data/model/response/pesanan_selesai_response_model.dart';
import 'package:angkut_yuk/services/service_http_client.dart';
import 'package:dartz/dartz.dart';

class PesananRepository {
  final ServiceHttpClient httpClient;

  PesananRepository(this.httpClient);

  Future<Either<String, DataPesanan>> createPesanan(PesananRequestModel request) async {
    try {
      final response = await httpClient.postWithToken(
        'pelanggan/pesanan',
        request.toMap(),
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final data = DataPesanan.fromJson(jsonResponse['data']);
        return Right(data);
      } else {
        final error = json.decode(response.body);
        return Left(error['message'] ?? 'Gagal membuat pesanan');
      }
    } catch (e) {
      return _infopenyimpangan(e);
    }
  }

  Future<Either<String, List<DataPesanan>>> getAllPesanan() async {
    try {
      final response = await httpClient.get("pelanggan/pesanan");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final list = (data['data'] as List)
            .map((e) => DataPesanan.fromJson(e)) 
            .toList();
        return Right(list);
      } else {
        return Left("Gagal mengambil data: ${response.statusCode}");
      }
    } catch (e) {
      return Left("Error: $e");
    }
  }

  Future<Either<String, List<DataPesananAdmin>>> getAllPesananAdmin() async {
    try {
      final response = await httpClient.get("admin/pesanan");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final list = (data['data'] as List)
            .map((e) => DataPesananAdmin.fromJson(e)) 
            .toList();
        return Right(list);
      } else {
        return Left("Gagal mengambil data: ${response.statusCode}");
      }
    } catch (e) {
      return Left("Error: $e");
    }
  }

  Future<Either<String, List<DataPesananPetugas>>> getAllPesananPetugas() async {
  try {
    final response = await httpClient.get("petugas/pesanan");

     if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final list = (data['data'] as List)
            .map((e) => DataPesananPetugas.fromJson(e)) 
            .toList();
        return Right(list);
      } else {
        return Left("Gagal mengambil data: ${response.statusCode}");
      }
    } catch (e) {
      return Left("Error: $e");
    }
  }

  Future<void> ubahStatus(int idPesanan, String status) async {
    try {
      final response = await httpClient.put(
        'petugas/pesanan/$idPesanan',
        {
          'status': status,
        },
      );

      if (response.statusCode != 200) {
        final error = json.decode(response.body);
        throw Exception(error['message'] ?? 'Gagal mengubah status');
      }
    } catch (e) {
      throw Exception("Error saat mengubah status: $e");
    }
  }


  Future<Either<String, DataPesananAdmin>> getPesananById(int id) async {
    try {
      final response = await httpClient.get('admin/pesanan/$id');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final data = DataPesananAdmin.fromJson(jsonResponse['data']);
        return Right(data);
      } else {
        final error = json.decode(response.body);
        return Left(error['message'] ?? 'Pesanan tidak ditemukan');
      }
    } catch (e) {
      return _infopenyimpangan(e);
    }
  }

  Future<Either<String, UploadBuktiData>> uploadBuktiSelesai(int id, File fotoBukti) async {
    try {
      final response = await httpClient.uploadFile(
        endPoint: 'petugas/pesanan/$id/bukti',
        file: fotoBukti,
        fieldName: 'foto_bukti_selesai',
      );

      final jsonResponseStr = await response.stream.bytesToString();
      final jsonResponse = json.decode(jsonResponseStr);

      if (response.statusCode == 200) {
        final data = UploadBuktiData.fromJson(jsonResponse['data']);
        return Right(data);
      } else {
        return Left(jsonResponse['message'] ?? 'Gagal upload bukti selesai');
      }
    } catch (e) {
      return _infopenyimpangan(e);
    }
  }

  Future<Either<String, DataPesananAdmin>> updatePesanan({
    required int id,
    required AdminPesananRequestModel request,
  }) async {
    try {
      final response = await httpClient.put(
        'admin/pesanan/$id',
        request.toMap(),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final data = DataPesananAdmin.fromJson(jsonResponse['data']);
        return Right(data);
      } else {
        final error = json.decode(response.body);
        return Left(error['message'] ?? 'Gagal mengupdate pesanan');
      }
    } catch (e) {
      return _infopenyimpangan(e);
    }
  }


  Future<Either<String, String>> deletePesanan(int id) async {
    try {
      final response = await httpClient.delete('pesanan/$id');

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final message = jsonResponse['message'] ?? 'Pesanan berhasil dihapus';
        return Right(message);
      } else {
        final error = json.decode(response.body);
        return Left(error['message'] ?? 'Gagal menghapus pesanan');
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
