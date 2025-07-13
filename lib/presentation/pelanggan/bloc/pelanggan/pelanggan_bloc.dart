import 'dart:io';
import 'package:angkut_yuk/data/model/request/pelanggan/pelanggan_request_model.dart';
import 'package:angkut_yuk/data/model/response/get_all_kategori_response_model.dart';
import 'package:angkut_yuk/data/model/response/pelanggan_response_model.dart';
import 'package:angkut_yuk/data/repository/pelanggan_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

part 'pelanggan_event.dart';
part 'pelanggan_state.dart';

class PelangganBloc extends Bloc<PelangganEvent, PelangganState> {
  final PelangganRepository pelangganRepository;

  PelangganBloc({required this.pelangganRepository}) : super(PelangganInitial()) {
    on<GetPelangganProfileRequested>(_onPelangganProfileRequested);
    on<UpdatePelangganRequested>(_onPelangganUpdateRequested);
    on<UploadFotoPelangganRequested>(_onUploadFotoPelangganRequested);
    on<AmbilKategoriPelangganEvent>(_onAmbilKategoriPelanggan);
  }

  Future<void> _onPelangganProfileRequested(
    GetPelangganProfileRequested event,
    Emitter<PelangganState> emit,
  ) async {
    emit(PelangganLoading());

    final Either<String, DataPelanggan> result = await pelangganRepository.getProfile();

    result.fold(
      (error) => emit(PelangganFailure(error: error)),
      (data) => emit(PelangganLoaded(pelanggan: data)),
    );
  }

  Future<void> _onPelangganUpdateRequested(
    UpdatePelangganRequested event,
    Emitter<PelangganState> emit,
  ) async {
    emit(PelangganLoading());

    final Either<String, String> result =
        await pelangganRepository.updateProfile(event.requestModel);

    result.fold(
      (error) => emit(PelangganFailure(error: error)),
      (message) => emit(PelangganUpdateSuccess(message: message)),
    );
  }

  Future<void> _onUploadFotoPelangganRequested(
    UploadFotoPelangganRequested event,
    Emitter<PelangganState> emit,
  ) async {
    emit(PelangganLoading());

    final result = await pelangganRepository.uploadFotoProfil(event.imageFile);

    result.fold(
      (error) => emit(PelangganFailure(error: error)),
      (message) {
        emit(PelangganFotoUploadSuccess(message: message));
        add(GetPelangganProfileRequested());
      },
    );
  }

  Future<void> _onAmbilKategoriPelanggan(
    AmbilKategoriPelangganEvent event,
    Emitter<PelangganState> emit,
  ) async {
    emit(PelangganLoading());
    final result = await pelangganRepository.getAllKategoriuntukPelanggan();
    result.fold(
      (error) => emit(PelangganFailure(error: error)),
      (kategoriResponse) => emit(KategoriPelangganLoaded(kategoriResponse.dataKategori)),
    );
  }
}
