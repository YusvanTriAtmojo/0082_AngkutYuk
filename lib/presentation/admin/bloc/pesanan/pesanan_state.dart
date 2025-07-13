part of 'pesanan_bloc.dart';

sealed class PesananAdminState {}

final class PesananInitial extends PesananAdminState {}

final class PesananAdminLoading extends PesananAdminState {}

final class PesananAdminLoaded extends PesananAdminState {
  final List<DataPesananAdmin> daftarPesanan;

  PesananAdminLoaded({required this.daftarPesanan});
}

final class DetailPesananAdminLoaded extends PesananAdminState {
  final DataPesananAdmin pesanan;

  DetailPesananAdminLoaded({required this.pesanan});
}

final class PesananAdminSuccess extends PesananAdminState {
  final String message;

  PesananAdminSuccess(this.message);
}

final class PesananAdminFailure extends PesananAdminState {
  final String error;

  PesananAdminFailure({required this.error});
}
