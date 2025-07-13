import 'package:angkut_yuk/data/model/response/petugas_response_model.dart';
import 'package:angkut_yuk/data/repository/petugas_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'petugas_event.dart';
part 'petugas_state.dart';

class PetugasprofilBloc extends Bloc<PetugasEvent, PetugasState> {
 final PetugasRepository petugasRepository;

  PetugasprofilBloc({required this.petugasRepository}) : super(PetugasInitial()) {
    on<GetPetugasProfileRequested>(_onPetugasProfileRequested);
  }

  Future<void> _onPetugasProfileRequested(
    GetPetugasProfileRequested event,
    Emitter<PetugasState> emit,
  ) async {
    emit(PetugasLoading());

    final Either<String, DataPetugas> result = await petugasRepository.getProfile();

    result.fold(
      (error) => emit(PetugasFailure(error: error)),
      (data) => emit(PetugasLoaded(petugas: data)),
    );
  }
}
