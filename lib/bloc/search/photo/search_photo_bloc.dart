import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/repository/repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'search_photo_bloc.freezed.dart';
part 'search_photo_event.dart';
part 'search_photo_state.dart';

class SearchPhotoBloc extends Bloc<SearchPhotoEvent, SearchPhotoState> {
  // save latest load success data
  SearchPhotoSuccess _photoSuccess;

  SearchPhotoBloc() : super(SearchPhotoState.initial());

  SearchPhotoSuccess get photoSuccess => _photoSuccess;
  String orientation;
  String query = '';

  bool _hasMore = true;

  @override
  Stream<Transition<SearchPhotoEvent, SearchPhotoState>> transformEvents(
      Stream<SearchPhotoEvent> events, transitionFn) {
    return events.distinct((previous, current) {
      var isEqual = current != null &&
          current is! SearchPhotoRefreshEvent &&
          previous == current;
      // print('请求相同吗:$isEqual');
      var currentStateIsError = state is SearchPhotoError;
      // print('上次的结果是error吗:$currentStateIsError');
      return isEqual && !currentStateIsError;
    }).switchMap(transitionFn)
      ..listen((event) {});
  }

  @override
  Stream<SearchPhotoState> mapEventToState(
    SearchPhotoEvent event,
  ) async* {
    if (event is SearchPhotoLoadMoreEvent) {
      yield SearchPhotoLoadMore();
    } else {
      yield SearchPhotoLoading();
    }
    if (event is SearchPhotoRefreshEvent) {
      if (event.orientation != null) {
        orientation = event.orientation;
      }
      if (event.query != null) {
        query = event.query;
      }
      yield await _loadData();
    } else if (event is SearchPhotoLoadMoreEvent) {
      var data = await _loadData(page: event.page);
      yield data;
    }
  }

  loadMore() async {
    if (_hasMore) {
      add(SearchPhotoLoadMoreEvent(_photoSuccess.page + 1));
    }
  }

  Future<SearchPhotoState> _loadData({int page = 1}) async {
    page ??= 1;
    try {
      var result = await GetIt.I<Repository>()
          .searchPhoto(query: query, page: page, orientation: orientation);
      if (result == null) {
        return SearchPhotoState.error('数据为空');
      }
      var data = result.results;
      List<Photo> photos = (_photoSuccess?.photos ?? []);
      if (page == 1) {
        // clear old data.
        photos.clear();
      }
      _hasMore = data.isNotEmpty;
      _photoSuccess = SearchPhotoState.success(page, photos..addAll(data));
      return _photoSuccess;
    } catch (e) {
      print('捕获到了异常:$e');
      return SearchPhotoState.error(e);
    }
  }
}
