import 'package:angkut_yuk/data/model/request/admin/kendaraan_request_model.dart';
import 'package:angkut_yuk/data/model/response/get_all_kendaraan_response_model.dart';
import 'package:angkut_yuk/data/repository/kendaraan_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'kendaraan_event.dart';
part 'kendaraan_state.dart';

class KendaraanBloc extends Bloc<KendaraanEvent, KendaraanState> {
  final KendaraanRepository kendaraanRepository;

  KendaraanBloc({required this.kendaraanRepository}) : super(KendaraanInitial()) {
    on<KendaraanRequested>(_onKendaraanRequested);
    on<KendaraanCreateRequested>(_onKendaraanCreateRequested);
    on<KendaraanDeleted>(_onKendaraanDeleted);
    on<KendaraanUpdateRequested>(_onKendaraanUpdateRequested);
    on<FilterKendaraanByKategori>(_onKendaraanFilter);
    on<FilterKendaraanByStatus>(_onKendaraanFilterStatus);
  }

  Future<void> _onKendaraanRequested(
    KendaraanRequested event,
    Emitter<KendaraanState> emit,
  ) async {
    emit(KendaraanLoading());

    final Either<String, GetAllKendaraanModel> result =
        await kendaraanRepository.getAllKendaraan();

    result.fold(
      (failure) => emit(KendaraanFailure(error: failure)),
      (data) => emit(KendaraanLoaded(listKendaraan: data.dataKendaraan)),
    );
  }

  Future<void> _onKendaraanCreateRequested(
    KendaraanCreateRequested event,
    Emitter<KendaraanState> emit,
  ) async {
    emit(KendaraanLoading());

    final result = await kendaraanRepository.createKendaraan(event.requestModel);

    result.fold(
      (failure) => emit(KendaraanFailure(error: failure)),
      (message) => emit(KendaraanOperationSuccess(message: message)),
    );
  }

  Future<void> _onKendaraanFilter(
    FilterKendaraanByKategori event,
    Emitter<KendaraanState> emit,
  ) async {
    if (state is KendaraanLoaded) {
      final loadedState = state as KendaraanLoaded;

      final filtered = loadedState.listKendaraan
          .where((k) =>
              k.idKategori == event.idKategori &&
              k.statusKendaraan.toLowerCase() == 'tersedia')
          .toList();

      emit(KendaraanFiltered(filtered));
    }
  }

  Future<void> _onKendaraanFilterStatus(
    FilterKendaraanByStatus event,
    Emitter<KendaraanState> emit,
  ) async {
    if (state is KendaraanLoaded) {
      final list = (state as KendaraanLoaded).listKendaraan;

      final filtered = list
          .where((k) =>
              k.statusKendaraan.toLowerCase() == event.status.toLowerCase())
          .toList();

      emit(KendaraanFiltered(filtered));
    } else {
      final result = await kendaraanRepository.getAllKendaraan();
      result.fold(
        (error) => emit(KendaraanFailure(error: error)),
        (data) {
          final filtered = data.dataKendaraan
              .where((k) =>
                  k.statusKendaraan.toLowerCase() == event.status.toLowerCase())
              .toList();

          emit(KendaraanFiltered(filtered));
        },
      );
    }
  }

  Future<void> _onKendaraanUpdateRequested(
    KendaraanUpdateRequested event,
    Emitter<KendaraanState> emit,
  ) async {
    emit(KendaraanLoading());

    final result = await kendaraanRepository.updateKendaraan(
      event.id,
      event.requestModel,
    );

    result.fold(
      (error) => emit(KendaraanFailure(error: error)),
      (message) => emit(KendaraanOperationSuccess(message: message)),
    );
  }


  Future<void> _onKendaraanDeleted(
    KendaraanDeleted event,
    Emitter<KendaraanState> emit,
  ) async {
    emit(KendaraanLoading());

    final result = await kendaraanRepository.deleteKendaraan(event.id);

    await result.fold(
      (error) async => emit(KendaraanFailure(error: error)),
      (success) async {
        final refreshResult = await kendaraanRepository.getAllKendaraan();
        refreshResult.fold(
          (error) => emit(KendaraanFailure(error: error)),
          (data) => emit(KendaraanLoaded(listKendaraan: data.dataKendaraan)),
        );
      },
    );
  }
}
