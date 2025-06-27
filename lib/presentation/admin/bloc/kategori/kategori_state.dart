part of 'kategori_bloc.dart';

@immutable
sealed class KategoriState {}

final class KategoriInitial extends KategoriState {}

final class KategoriLoading extends KategoriState {}

final class KategoriLoaded extends KategoriState {
  final List<Kategori> listKategori;

  KategoriLoaded({required this.listKategori});
}

final class KategoriOperationSuccess extends KategoriState {
  final String message;

  KategoriOperationSuccess({required this.message});
}

final class KategoriFailure extends KategoriState {
  final String error;

  KategoriFailure({required this.error});
}