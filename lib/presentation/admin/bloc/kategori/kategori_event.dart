part of 'kategori_bloc.dart';

sealed class KategoriEvent {}

class KategoriRequested extends KategoriEvent {}

class KategoriCreateRequested extends KategoriEvent {
  final KategoriRequestModel requestModel;

  KategoriCreateRequested({required this.requestModel});
}

class KategoriDeleted extends KategoriEvent {
  final int id;

  KategoriDeleted(this.id);
}