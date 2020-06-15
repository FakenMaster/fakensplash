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
  // save latest load success data
  PhotoSuccess _photoSuccess;
  PhotoSuccess get photoSuccess => _photoSuccess;

  bool _isLoadingMore = false;
  @override
  PhotoState get initialState => PhotoInitial();

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
      _isLoadingMore = false;
      yield data;
    }
  }

  loadMore() async {
    //_loadData(page: _photoSuccess.page + 1);
    // should use rxdart to detect repeat same request.
    if (!_isLoadingMore) {
      _isLoadingMore = true;
      print('加载更多：${_photoSuccess.page + 1}');
      add(PhotoLoadMoreEvent(_photoSuccess.page + 1));
    } else {
      print('正在加载中，不要重复加载：${_photoSuccess.page + 1}');
    }
  }

  Future<PhotoState> _loadData({int page = 1}) async {
    try {
      var data = await GetIt.I<Repository>().photos();
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
      return PhotoState.error(e);
    }
  }
}
