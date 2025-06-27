import 'package:angkut_yuk/data/model/request/admin/kategori_request_model.dart';
import 'package:angkut_yuk/data/model/response/get_all_kategori_response_model.dart';
import 'package:angkut_yuk/data/repository/kategori_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'kategori_event.dart';
part 'kategori_state.dart';

class KategoriBloc extends Bloc<KategoriEvent, KategoriState> {
  final KategoriRepository kategoriRepository;

  KategoriBloc({required this.kategoriRepository}) : super(KategoriInitial()) {
    on<KategoriRequested>(_onKategoriRequested);
    on<KategoriCreateRequested>(_onKategoriCreateRequested);
    on<KategoriDeleted>(_onKategoriDeleted);
  }

  Future<void> _onKategoriRequested(
    KategoriRequested event,
    Emitter<KategoriState> emit,
  ) async {
    emit(KategoriLoading());

    final Either<String, GetAllKategoriResponseModel> result =
        await kategoriRepository.getAllKategori();

    result.fold(
      (failure) => emit(KategoriFailure(error: failure)),
      (data) => emit(KategoriLoaded(listKategori: data.dataKategori)),
    );
  }

  Future<void> _onKategoriCreateRequested(
    KategoriCreateRequested event,
    Emitter<KategoriState> emit,
  ) async {
    emit(KategoriLoading());

    final result =
        await kategoriRepository.createKategori(event.requestModel);

    result.fold(
      (failure) => emit(KategoriFailure(error: failure)),
      (message) => emit(KategoriOperationSuccess(message: message)),
    );
  }

  Future<void> _onKategoriDeleted(
    KategoriDeleted event,
    Emitter<KategoriState> emit,
  ) async {
    emit(KategoriLoading());

    final result = await kategoriRepository.deleteKategori(event.id);

    await result.fold(
      (error) async => emit(KategoriFailure(error: error)),
      (success) async {
        final refreshResult = await kategoriRepository.getAllKategori();
        refreshResult.fold(
          (error) => emit(KategoriFailure(error: error)),
          (data) => emit(KategoriLoaded(listKategori: data.dataKategori)),
        );
      },
    );
  }
}
