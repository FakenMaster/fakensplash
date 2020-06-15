import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fakensplash/model/photo.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../repository/repository.dart';

part 'photo_event.dart';
part 'photo_state.dart';
part 'photo_bloc.freezed.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  // save latest load success data
  PhotoSuccess _photoSuccess;
  PhotoSuccess get photoSuccess => _photoSuccess;

  @override
  PhotoState get initialState => PhotoInitial();

  @override
  Stream<Transition<PhotoEvent, PhotoState>> transformEvents(
      Stream<PhotoEvent> events, transitionFn) {
    return events.distinct((previous, current) {
      var isEqual = previous != null && previous == current;
      print('请求相同吗:$isEqual');
      var currentStateIsError = state is PhotoError;
      print('上次的结果是error吗:$currentStateIsError');
      return isEqual && !currentStateIsError;
    }).switchMap(transitionFn)..listen((event) {
      
    });
  }

  @override
  Stream<PhotoState> mapEventToState(
    PhotoEvent event,
  ) async* {
    if (event is PhotoLoadMoreEvent) {
      yield PhotoLoadMore();
    } else {
      yield PhotoLoading();
    }
    if (event is PhotoRefreshEvent) {
      yield await _loadData();
    } else if (event is PhotoLoadMoreEvent) {
      var data = await _loadData(page: event.page);
      print('结果:$data');
      yield data;
    }
  }

  loadMore() async {
    print('加载更多：${_photoSuccess.page + 1}');
    add(PhotoLoadMoreEvent(_photoSuccess.page + 1));
  }

  Future<PhotoState> _loadData({int page = 1}) async {
    print('调用接口加载数据: 页码:$page');
    page ??= 1;
    try {
      var data = await GetIt.I<Repository>().photos(page: page);
      print('data数据类型:$data');
      if (data == null) {
        return PhotoState.error('数据为空');
      }
      List<Photo> photos = (_photoSuccess?.photos ?? []);
      if (page == 1) {
        // clear old data.
        photos.clear();
      }
      _photoSuccess = PhotoState.success(page, photos..addAll(data));
      return _photoSuccess;
    } catch (e) {
      print('捕获到了异常:$e');
      return PhotoState.error(e);
    }
  }
}
