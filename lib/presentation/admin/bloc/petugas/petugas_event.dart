part of 'petugas_bloc.dart';

sealed class PetugasEvent {}

final class PetugasRequested extends PetugasEvent {}

final class PetugasCreateRequested extends PetugasEvent {
  final PetugasRequestModel requestModel;

  PetugasCreateRequested({required this.requestModel});
}

final class PetugasUpdateRequested extends PetugasEvent {
  final int id;
  final PetugasRequestModel requestModel;

  PetugasUpdateRequested({
    required this.id,
    required this.requestModel,
  });
}

final class PetugasDeleted extends PetugasEvent {
  final int id;

  PetugasDeleted(this.id);
}

final class FilterStatusPetugas extends PetugasEvent {
   final String status;

  FilterStatusPetugas(this.status);
}