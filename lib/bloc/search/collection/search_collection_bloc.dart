import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fakensplash/bloc/collection_bloc_mixin.dart';
import 'package:fakensplash/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../repository/repository.dart';

part 'search_collection_bloc.freezed.dart';
part 'search_collection_event.dart';
part 'search_collection_state.dart';

class SearchCollectionBloc
    extends CollectionBlocMixin<SearchCollectionEvent, SearchCollectionState> {
  SearchCollectionSuccess _collectionSuccess;
  bool _hasMore = true;
  String query;

  SearchCollectionBloc() : super(SearchCollectionState.initial());

  SearchCollectionSuccess get collectionSuccess => _collectionSuccess;

  @override
  Stream<Transition<SearchCollectionEvent, SearchCollectionState>>
      transformEvents(Stream<SearchCollectionEvent> events, transitionFn) {
    return events.distinct((previous, current) {
      var isEqual = current != null &&
          current is! SearchCollectionRefreshEvent &&
          previous == current;
      // print('请求相同吗:$isEqual');
      var currentStateIsError = state is SearchCollectionError;
      // print('上次的结果是error吗:$currentStateIsError');
      return isEqual && !currentStateIsError;
    }).switchMap(transitionFn);
  }

  @override
  Stream<SearchCollectionState> mapEventToState(
    SearchCollectionEvent event,
  ) async* {
    if (event is SearchCollectionLoadMoreEvent) {
      yield SearchCollectionLoadMore();
    } else {
      yield SearchCollectionLoading();
    }
    if (event is SearchCollectionRefreshEvent) {
      if (event.query != null) {
        query = event.query;
      }
      yield await _loadData();
    } else if (event is SearchCollectionLoadMoreEvent) {
      var data = await _loadData(page: event.page);
      yield data;
    }
  }

  @override
  loadMore() async {
    // should use rxdart to detect repeat same request.
    print('加载更多：${_collectionSuccess.page + 1}');
    if (_hasMore) {
      add(SearchCollectionLoadMoreEvent(_collectionSuccess.page + 1));
    }
  }

  Future<SearchCollectionState> _loadData({int page = 1}) async {
    try {
      var result = await GetIt.I<Repository>()
          .searchCollection(query: query, page: page);
      if (result == null) {
        return SearchCollectionState.error('数据为空');
      }
      var data = result.results;
      List<Collection> collections = (_collectionSuccess?.collections ?? []);
      if (page == 1) {
        // clear old data.
        collections.clear();
      }
      _hasMore = data.isNotEmpty;

      _collectionSuccess =
          SearchCollectionState.success(page, collections..addAll(data));
      return _collectionSuccess;
    } catch (e) {
      print('异常:$e');
      return SearchCollectionState.error(e);
    }
  }
}
