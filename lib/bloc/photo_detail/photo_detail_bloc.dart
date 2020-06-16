import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/repository/repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'photo_detail_event.dart';
part 'photo_detail_state.dart';
part 'photo_detail_bloc.freezed.dart';

class PhotoDetailBloc extends Bloc<PhotoDetailEvent, PhotoDetailState> {
  @override
  PhotoDetailState get initialState => PhotoDetailInitial();

  @override
  Stream<PhotoDetailState> mapEventToState(
    PhotoDetailEvent event,
  ) async* {
    yield PhotoDetailState.loading();
    if (event is PhotoDetailLoadEvent) {
      yield await loadDetail(event.id);
    }
  }

  Future<PhotoDetailState> loadDetail(String id) async {
    try {
      var data = await GetIt.I<Repository>().photoDetail(id);
      if (data is Photo) {
        return PhotoDetailState.success(data);
      }
      return PhotoDetailState.error('null');
    } catch (e) {
      print('详情异常:$e');
      return PhotoDetailState.error(e);
    }
  }
}
