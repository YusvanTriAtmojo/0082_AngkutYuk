part of 'pesanan_bloc.dart';

sealed class PesananState {}

final class PesananInitial extends PesananState {}

final class PesananLoading extends PesananState {}

final class PesananLoaded extends PesananState {
  final List<DataPesanan> daftarPesanan;

  PesananLoaded(this.daftarPesanan);
}

final class PesananSuccess extends PesananState {
  final String pesan;

  PesananSuccess(this.pesan);
}

final class PesananFailure extends PesananState {
  final String error;

  PesananFailure(this.error);
}

final class BiayaHitungSuccess extends PesananState {
  final double jarakKm;
  final int biaya;

  BiayaHitungSuccess({required this.jarakKm, required this.biaya});
}
