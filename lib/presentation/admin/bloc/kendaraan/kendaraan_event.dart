part of 'kendaraan_bloc.dart';

sealed class KendaraanEvent {}

final class KendaraanRequested extends KendaraanEvent {}

final class KendaraanCreateRequested extends KendaraanEvent {
  final KendaraanRequestModel requestModel;

  KendaraanCreateRequested({required this.requestModel});
}

class KendaraanDeleted extends KendaraanEvent {
  final int id;

  KendaraanDeleted(this.id);
}