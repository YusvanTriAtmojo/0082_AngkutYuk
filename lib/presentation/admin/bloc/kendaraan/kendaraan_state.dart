part of 'kendaraan_bloc.dart';

sealed class KendaraanState {}

final class KendaraanInitial extends KendaraanState {}

final class KendaraanLoading extends KendaraanState {}

final class KendaraanLoaded extends KendaraanState {
  final List<Kendaraan> listKendaraan;

  KendaraanLoaded({required this.listKendaraan});
}

final class KendaraanOperationSuccess extends KendaraanState {
  final String message;

  KendaraanOperationSuccess({required this.message});
}

final class KendaraanFailure extends KendaraanState {
  final String error;

  KendaraanFailure({required this.error});
}