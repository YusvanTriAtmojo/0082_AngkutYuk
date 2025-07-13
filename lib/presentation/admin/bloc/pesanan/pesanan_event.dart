part of 'pesanan_bloc.dart';

sealed class PesananAdminEvent {}

final class AmbilSemuaPesananAdminEvent extends PesananAdminEvent {}

final class AmbilDetailPesananAdminEvent extends PesananAdminEvent {
  final int id;
  AmbilDetailPesananAdminEvent(this.id);
}

final class UpdatePesananAdminEvent extends PesananAdminEvent {
  final int id;
  final AdminPesananRequestModel request;

  UpdatePesananAdminEvent({
    required this.id,
    required this.request,
  });
}
