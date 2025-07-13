import 'package:angkut_yuk/data/model/request/pelanggan/pesanan_request_model.dart';
import 'package:angkut_yuk/data/model/response/pesanan_response_model.dart';
import 'package:angkut_yuk/data/repository/pesanan_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';

part 'pesanan_event.dart';
part 'pesanan_state.dart';

class PesananBloc extends Bloc<PesananEvent, PesananState> {
  final PesananRepository pesananrepository;

  PesananBloc({required this.pesananrepository}) : super(PesananInitial()) {
    on<PesananCreateRequested>(_onBuatPesanan);
    on<AmbilPesananAktifEvent>(_onAmbilPesananAktif);
    on<AmbilPesananSelesaiEvent>(_onAmbilPesananSelasai);
    on<HapusPesananEvent>(_onHapusPesanan);
    on<HitungBiayaEvent>(_onHitungBiaya);
  }

  Future<void> _onBuatPesanan(
    PesananCreateRequested event,
    Emitter<PesananState> emit,
  ) async {
    emit(PesananLoading());
    final result = await pesananrepository.createPesanan(event.request);
    result.fold(
      (error) => emit(PesananFailure(error)),
      (dataPesanan) => emit(PesananSuccess("Pesanan berhasil dibuat")),
    );
  }

  Future<void> _onAmbilPesananAktif(
    AmbilPesananAktifEvent event,
    Emitter<PesananState> emit,
  ) async {
    emit(PesananLoading());
    final result = await pesananrepository.getAllPesanan();

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
    final result = await pesananrepository.getAllPesanan();

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

  Future<void> _onHitungBiaya(
    HitungBiayaEvent event,
    Emitter<PesananState> emit,
  ) async {
    emit(PesananLoading());

    try {
      final jarakKm = Geolocator.distanceBetween(
            event.latJemput,
            event.lngJemput,
            event.latTujuan,
            event.lngTujuan,
          ) /
          1000;

      final biaya = (jarakKm * 10000).toInt();

      emit(BiayaHitungSuccess(jarakKm: jarakKm, biaya: biaya));
    } catch (e) {
      emit(PesananFailure('Gagal menghitung biaya: ${e.toString()}'));
    }
  }


  Future<void> _onHapusPesanan(
    HapusPesananEvent event,
    Emitter<PesananState> emit,
  ) async {
    emit(PesananLoading());
    final result = await pesananrepository.deletePesanan(event.id);
    result.fold(
      (error) => emit(PesananFailure(error)),
      (successMessage) {
        emit(PesananSuccess("Pesanan berhasil dihapus"));
        add(AmbilPesananAktifEvent()); 
      },
    );
  }
  
}
