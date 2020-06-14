import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fakensplash/model/photo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../repository/repository.dart';


part 'photo_event.dart';
part 'photo_state.dart';
part 'photo_bloc.freezed.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  @override
  PhotoState get initialState => PhotoInitial();

  @override
  Stream<PhotoState> mapEventToState(
    PhotoEvent event,
  ) async* {
    yield PhotoLoading();
    if(event is PhotoRefreshEvent){
      yield await refresh();
    }else if(event is PhotoLoadMoreEvent){
      
    }
   
  }

  Future<PhotoState> refresh() async {
    try {
      var data = await GetIt.I<Repository>().photos();
      if (data == null) {
        return PhotoState.error('数据为空');
      }
      return PhotoState.success(1, data);
    } catch (e) {
      return PhotoState.error(e);
    }
  }
}
