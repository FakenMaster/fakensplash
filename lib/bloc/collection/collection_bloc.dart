import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fakensplash/bloc/collection_bloc_mixin.dart';
import 'package:fakensplash/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../repository/repository.dart';

part 'collection_bloc.freezed.dart';
part 'collection_event.dart';
part 'collection_state.dart';

class CollectionBloc
    extends CollectionBlocMixin<CollectionEvent, CollectionState> {
  CollectionSuccess _collectionSuccess;
  bool featured = false;
  bool _hasMore = true;

  CollectionBloc() : super(CollectionState.initial());
  CollectionSuccess get collectionSuccess => _collectionSuccess;

  @override
  Stream<Transition<CollectionEvent, CollectionState>> transformEvents(
      Stream<CollectionEvent> events, transitionFn) {
    return events.distinct((previous, current) {
      var isEqual = current != null &&
          current is! CollectionRefreshEvent &&
          previous == current;
      // print('请求相同吗:$isEqual');
      var currentStateIsError = state is CollectionError;
      // print('上次的结果是error吗:$currentStateIsError');
      return isEqual && !currentStateIsError;
    }).switchMap(transitionFn);
  }

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
      if (event.featured != null) {
        featured = event.featured;
      }
      yield await _loadData();
    } else if (event is CollectionLoadMoreEvent) {
      var data = await _loadData(page: event.page);
      yield data;
    }
  }

  @override
  loadMore() async {
    // should use rxdart to detect repeat same request.
    print('加载更多：${_collectionSuccess.page + 1}');
    if (_hasMore) {
      add(CollectionLoadMoreEvent(_collectionSuccess.page + 1));
    }
  }

  Future<CollectionState> _loadData({int page = 1}) async {
    try {
      var data = await GetIt.I<Repository>()
          .collections(page: page, featured: featured);
      if (data == null) {
        return CollectionState.error('数据为空');
      }
      List<Collection> collections = (_collectionSuccess?.collections ?? []);
      if (page == 1) {
        // clear old data.
        collections.clear();
      }
      _hasMore = data.isNotEmpty;

      _collectionSuccess =
          CollectionState.success(page, collections..addAll(data));
      return _collectionSuccess;
    } catch (e) {
      print('异常:$e');
      return CollectionState.error(e);
    }
  }
}
