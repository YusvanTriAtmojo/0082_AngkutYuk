import 'package:angkut_yuk/data/model/request/admin/petugas_request_model.dart';
import 'package:angkut_yuk/data/model/response/get_all_petugas_response_model.dart';
import 'package:angkut_yuk/data/repository/petugas_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'petugas_event.dart';
part 'petugas_state.dart';

class PetugasBloc extends Bloc<PetugasEvent, PetugasState> {
  final PetugasRepository petugasRepository;

  PetugasBloc({required this.petugasRepository}) : super(PetugasInitial()) {
    on<PetugasRequested>(_onPetugasRequested);
    on<PetugasCreateRequested>(_onPetugasCreateRequested);
    on<PetugasUpdateRequested>(_onPetugasUpdateRequested);
    on<FilterStatusPetugas>(_onStatusPetugas);
    on<PetugasDeleted>(_onPetugasDeleted);
  }

  Future<void> _onPetugasRequested(
    PetugasRequested event,
    Emitter<PetugasState> emit,
  ) async {
    emit(PetugasLoading());

    final Either<String, GetAllPetugasModel> result =
        await petugasRepository.getAllPetugas();

    result.fold(
      (failure) => emit(PetugasFailure(error: failure)),
      (data) => emit(PetugasLoaded(listPetugas: data.dataPetugas)),
    );
  }

  Future<void> _onPetugasCreateRequested(
    PetugasCreateRequested event,
    Emitter<PetugasState> emit,
  ) async {
    emit(PetugasLoading());

    final result = await petugasRepository.createPetugas(event.requestModel);

    result.fold(
      (failure) => emit(PetugasFailure(error: failure)),
      (message) => emit(PetugasOperationSuccess(message: message)),
    );
  }

  Future<void> _onPetugasUpdateRequested(
    PetugasUpdateRequested event,
    Emitter<PetugasState> emit,
  ) async {
    emit(PetugasLoading());

    final result = await petugasRepository.updatePetugas(
      event.id,
      event.requestModel,
    );

    result.fold(
      (error) => emit(PetugasFailure(error: error)),
      (message) => emit(PetugasOperationSuccess(message: message)),
    );
  }

  Future<void> _onStatusPetugas(
    FilterStatusPetugas event,
    Emitter<PetugasState> emit,
  ) async {
    if (state is PetugasLoaded) {
      final list = (state as PetugasLoaded).listPetugas;

      final filtered = list
          .where((p) =>
              p.statusPetugas.toLowerCase() == event.status.toLowerCase())
          .toList();

      emit(PetugasFiltered(filteredPetugas: filtered));
    } else {
      final result = await petugasRepository.getAllPetugas();
      result.fold(
        (error) => emit(PetugasFailure(error: error)),
        (data) {
          final filtered = data.dataPetugas
              .where((p) =>
                  p.statusPetugas.toLowerCase() == event.status.toLowerCase())
              .toList();

          emit(PetugasFiltered(filteredPetugas: filtered));
        },
      );
    }
  }

  Future<void> _onPetugasDeleted(
    PetugasDeleted event,
    Emitter<PetugasState> emit,
  ) async {
    emit(PetugasLoading());

    final result = await petugasRepository.deletePetugas(event.id);

    await result.fold(
      (error) async => emit(PetugasFailure(error: error)),
      (success) async {
        final refreshResult = await petugasRepository.getAllPetugas();
        refreshResult.fold(
          (error) => emit(PetugasFailure(error: error)),
          (data) => emit(PetugasLoaded(listPetugas: data.dataPetugas)),
        );
      },
    );
  }
}
