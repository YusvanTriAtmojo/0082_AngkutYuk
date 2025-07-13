part of 'pelanggan_bloc.dart';

sealed class PelangganEvent {}

final class GetPelangganProfileRequested extends PelangganEvent {}

final class UpdatePelangganRequested extends PelangganEvent {
  final PelangganRequestModel requestModel;

  UpdatePelangganRequested({required this.requestModel});
}

final class UploadFotoPelangganRequested extends PelangganEvent {
  final File imageFile;
  UploadFotoPelangganRequested(this.imageFile);
}

final class AmbilKategoriPelangganEvent extends PelangganEvent {}

