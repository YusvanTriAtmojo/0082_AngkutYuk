import 'package:angkut_yuk/data/model/request/admin/pesanan_request_model.dart';
import 'package:angkut_yuk/data/model/response/pesanan_admin_response_model.dart';
import 'package:angkut_yuk/data/repository/pesanan_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pesanan_event.dart';
part 'pesanan_state.dart';

class PesananAdminBloc extends Bloc<PesananAdminEvent, PesananAdminState> {
  final PesananRepository pesananrepository;

  PesananAdminBloc({required this.pesananrepository}) : super(PesananInitial()) {
    on<AmbilSemuaPesananAdminEvent>(_onAmbilSemua);
    on<AmbilDetailPesananAdminEvent>(_onAmbilDetail);
    on<UpdatePesananAdminEvent>(_onUpdatePesanan);
  }

  Future<void> _onAmbilSemua(
    AmbilSemuaPesananAdminEvent event,
    Emitter<PesananAdminState> emit,
  ) async {
    emit(PesananAdminLoading());
    final result = await pesananrepository.getAllPesananAdmin();
    result.fold(
      (error) => emit(PesananAdminFailure(error: error)),
      (data) => emit(PesananAdminLoaded(daftarPesanan: data)),
    );
  }

  Future<void> _onAmbilDetail(
    AmbilDetailPesananAdminEvent event,
    Emitter<PesananAdminState> emit,
  ) async {
    emit(PesananAdminLoading());
    final result = await pesananrepository.getPesananById(event.id);
    result.fold(
      (error) => emit(PesananAdminFailure(error: error)),
      (data) => emit(DetailPesananAdminLoaded(pesanan: data)),
    );
  }

  Future<void> _onUpdatePesanan(
    UpdatePesananAdminEvent event,
    Emitter<PesananAdminState> emit,
  ) async {
    emit(PesananAdminLoading());

    final result = await pesananrepository.updatePesanan(
      id: event.id,
      request: event.request,
    );

    result.fold(
      (error) => emit(PesananAdminFailure(error: error)),
      (message) => emit(PesananAdminSuccess("Pesanan berhasil diperbarui")),
    );
  }
}
