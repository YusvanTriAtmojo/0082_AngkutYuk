part of 'petugas_bloc.dart';

sealed class PetugasState {}

final class PetugasInitial extends PetugasState {}

final class PetugasLoading extends PetugasState {}

final class PetugasLoaded extends PetugasState {
  final List<Petugas> listPetugas;

  PetugasLoaded({required this.listPetugas});
}

final class PetugasOperationSuccess extends PetugasState {
  final String message;

  PetugasOperationSuccess({required this.message});
}

final class PetugasFiltered extends PetugasState {
  final List<Petugas> filteredPetugas;

  PetugasFiltered({required this.filteredPetugas});
}

final class PetugasFailure extends PetugasState {
  final String error;

  PetugasFailure({required this.error});
}
