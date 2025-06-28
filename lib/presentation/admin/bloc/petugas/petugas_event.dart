part of 'petugas_bloc.dart';

sealed class PetugasEvent {}

final class PetugasRequested extends PetugasEvent {}

final class PetugasCreateRequested extends PetugasEvent {
  final PetugasRequestModel requestModel;

  PetugasCreateRequested({required this.requestModel});
}

class PetugasDeleted extends PetugasEvent {
  final int id;

  PetugasDeleted(this.id);
}