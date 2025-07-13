import 'dart:io';

import 'package:angkut_yuk/data/model/response/pesanan_petugas_response_model.dart';
import 'package:angkut_yuk/data/repository/pesanan_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pesanan_event.dart';
part 'pesanan_state.dart';

class PesananPetugasBloc extends Bloc<PesananEvent, PesananState> {
  final PesananRepository pesananrepository;

  PesananPetugasBloc({required this.pesananrepository}) : super(PesananInitial()) {
    on<AmbilPesananAktifEvent>(_onAmbilPesananAktif);
    on<AmbilPesananSelesaiEvent>(_onAmbilPesananSelasai);
    on<UbahStatusPesananEvent>(_onUbahStatusPesanan);
    on<UploadBuktiSelesaiEvent>(_onUploadBuktiSelesai);
  }

  Future<void> _onAmbilPesananAktif(
    AmbilPesananAktifEvent event,
    Emitter<PesananState> emit,
  ) async {
    emit(PesananLoading());
    final result = await pesananrepository.getAllPesananPetugas();

    result.fold(
      (error) {
        emit(PesananFailure(error));
      },
      (dataList) {
        final filtered = dataList
            .where((pesanan) => pesanan.status.toLowerCase() != "selesai")
            .toList();
        emit(PesananLoaded(filtered));
      },
    );
  }

  Future<void> _onAmbilPesananSelasai(
    AmbilPesananSelesaiEvent event,
    Emitter<PesananState> emit,
  ) async {
    emit(PesananLoading());
    final result = await pesananrepository.getAllPesananPetugas();

    result.fold(
      (error) {
        emit(PesananFailure(error));
      },
      (dataList) {
        final filtered = dataList
            .where((pesanan) => pesanan.status.toLowerCase() == "selesai")
            .toList();
        emit(PesananLoaded(filtered));
      },
    );
  }

  Future<void> _onUbahStatusPesanan(
    UbahStatusPesananEvent event,
    Emitter<PesananState> emit,
  ) async {
    try {
      await pesananrepository.ubahStatus(event.idPesanan, event.status);
      add(AmbilPesananAktifEvent());
    } catch (e) {
      emit(PesananFailure(e.toString()));
    }
  }

  Future<void> _onUploadBuktiSelesai(
    UploadBuktiSelesaiEvent event,
    Emitter<PesananState> emit,
  ) async {
    emit(PesananLoading());
    final result = await pesananrepository.uploadBuktiSelesai(event.idPesanan, event.fotoBukti);
    result.fold(
      (error) => emit(PesananFailure(error)),
      (data) {
        emit(PesananSuccess("Bukti selesai berhasil diunggah"));
        add(AmbilPesananSelesaiEvent());
      },
    );
  }
}