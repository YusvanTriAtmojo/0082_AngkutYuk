part of 'pelanggan_bloc.dart';

sealed class PelangganState {}

final class PelangganInitial extends PelangganState {}

final class PelangganLoading extends PelangganState {}

final class PelangganLoaded extends PelangganState {
  final DataPelanggan pelanggan;

  PelangganLoaded({required this.pelanggan});
}

final class PelangganUpdateSuccess extends PelangganState {
  final String message;

  PelangganUpdateSuccess({required this.message});
}

final class PelangganFailure extends PelangganState {
  final String error;

  PelangganFailure({required this.error});
}

final class PelangganFotoUploadSuccess extends PelangganState {
  final String message;
  PelangganFotoUploadSuccess({required this.message});
}

final class KategoriPelangganLoaded extends PelangganState {
  final List<Kategori> kategoriList;

  KategoriPelangganLoaded(this.kategoriList);
}

