part of 'petugas_bloc.dart';

sealed class PetugasState {}

final class PetugasInitial extends PetugasState {}

final class PetugasLoading extends PetugasState {}

final class PetugasLoaded extends PetugasState {
  final DataPetugas petugas ;

  PetugasLoaded({required this.petugas});
}

final class PetugasFailure extends PetugasState {
  final String error;

  PetugasFailure({required this.error});
}