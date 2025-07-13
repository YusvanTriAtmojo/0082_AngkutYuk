part of 'kendaraan_bloc.dart';

sealed class KendaraanEvent {}

final class KendaraanRequested extends KendaraanEvent {}

final class KendaraanCreateRequested extends KendaraanEvent {
  final KendaraanRequestModel requestModel;

  KendaraanCreateRequested({required this.requestModel});
}

final class FilterKendaraanByKategori extends KendaraanEvent {
  final int idKategori;

  FilterKendaraanByKategori(this.idKategori);
}

final class FilterKendaraanByStatus extends KendaraanEvent {
  final String status;

  FilterKendaraanByStatus(this.status);
}

final class KendaraanUpdateRequested extends KendaraanEvent {
  final int id;
  final KendaraanRequestModel requestModel;

  KendaraanUpdateRequested({
    required this.id,
    required this.requestModel,
  });
}


final class KendaraanDeleted extends KendaraanEvent {
  final int id;

  KendaraanDeleted(this.id);
}