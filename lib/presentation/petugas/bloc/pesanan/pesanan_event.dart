part of 'pesanan_bloc.dart';

sealed class PesananEvent {}

class AmbilPesananAktifEvent extends PesananEvent {}

class AmbilPesananSelesaiEvent extends PesananEvent {}

class UbahStatusPesananEvent extends PesananEvent {
  final int idPesanan;
  final String status;

  UbahStatusPesananEvent({
    required this.idPesanan,
    required this.status,
  });
}

class UploadBuktiSelesaiEvent extends PesananEvent {
  final int idPesanan;
  final File fotoBukti;

  UploadBuktiSelesaiEvent({required this.idPesanan, required this.fotoBukti});
}

