part of 'pesanan_bloc.dart';

sealed class PesananEvent {} 

final class PesananCreateRequested extends PesananEvent {
  final PesananRequestModel request;
  PesananCreateRequested(this.request);
}

final class AmbilPesananAktifEvent extends PesananEvent {}

final class AmbilPesananSelesaiEvent extends PesananEvent {}

final class HapusPesananEvent extends PesananEvent {
  final int id;

  HapusPesananEvent(this.id);
}

final class HitungBiayaEvent extends PesananEvent {
  final double latJemput;
  final double lngJemput;
  final double latTujuan;
  final double lngTujuan;

  HitungBiayaEvent({
    required this.latJemput,
    required this.lngJemput,
    required this.latTujuan,
    required this.lngTujuan,
  });
}
