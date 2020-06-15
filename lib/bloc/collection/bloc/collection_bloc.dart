import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../model/collection.dart';
import '../../../repository/repository.dart';

part 'collection_event.dart';
part 'collection_state.dart';
part 'collection_bloc.freezed.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  CollectionSuccess _collectionSuccess;

  CollectionSuccess get collectionSuccess => _collectionSuccess;

  bool _isLoadingMore = false;
  @override
  CollectionState get initialState => CollectionInitial();

  @override
  Stream<CollectionState> mapEventToState(
    CollectionEvent event,
  ) async* {
    if (event is CollectionLoadMoreEvent) {
      yield CollectionLoadMore();
    } else {
      yield CollectionLoading();
    }
    if (event is CollectionRefreshEvent) {
      yield await _loadData();
    } else if (event is CollectionLoadMoreEvent) {
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
      print('加载更多：${_collectionSuccess.page + 1}');
      add(CollectionLoadMoreEvent(_collectionSuccess.page + 1));
    } else {
      print('正在加载中，不要重复加载：${_collectionSuccess.page + 1}');
    }
  }

  Future<CollectionState> _loadData({int page = 1}) async {
    try {
      var data = await GetIt.I<Repository>().collections(page: page);
      if (data == null) {
        return CollectionState.error('数据为空');
      }
      List<Collection> collctions = (_collectionSuccess?.collections ?? []);
      if (page == 1) {
        // clear old data.
        collctions.clear();
      }
      _collectionSuccess =
          CollectionState.success(page, collctions..addAll(data));
      return _collectionSuccess;
    } catch (e) {
      return CollectionState.error(e);
    }
  }
}
