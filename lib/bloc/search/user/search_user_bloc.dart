import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../repository/repository.dart';

part 'search_user_bloc.freezed.dart';
part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  SearchUserSuccess _userSuccess;
  bool _hasMore = true;
  String query;

  SearchUserBloc() : super(SearchUserState.initial());

  SearchUserSuccess get userSuccess => _userSuccess;

  @override
  Stream<Transition<SearchUserEvent, SearchUserState>> transformEvents(
      Stream<SearchUserEvent> events, transitionFn) {
    return events.distinct((previous, current) {
      var isEqual = current != null &&
          current is! SearchUserRefreshEvent &&
          previous == current;
      // print('请求相同吗:$isEqual');
      var currentStateIsError = state is SearchUserError;
      // print('上次的结果是error吗:$currentStateIsError');
      return isEqual && !currentStateIsError;
    }).switchMap(transitionFn);
  }

  @override
  Stream<SearchUserState> mapEventToState(
    SearchUserEvent event,
  ) async* {
    if (event is SearchUserLoadMoreEvent) {
      yield SearchUserLoadMore();
    } else {
      yield SearchUserLoading();
    }
    if (event is SearchUserRefreshEvent) {
      if (event.query != null) {
        query = event.query;
      }
      yield await _loadData();
    } else if (event is SearchUserLoadMoreEvent) {
      var data = await _loadData(page: event.page);
      yield data;
    }
  }

  loadMore() async {
    // should use rxdart to detect repeat same request.
    print('加载更多：${_userSuccess.page + 1}');
    if (_hasMore) {
      add(SearchUserLoadMoreEvent(_userSuccess.page + 1));
    }
  }

  Future<SearchUserState> _loadData({int page = 1}) async {
    try {
      var result =
          await GetIt.I<Repository>().searchUser(query: query, page: page);
      if (result == null) {
        return SearchUserState.error('数据为空');
      }
      var data = result.results;
      List<User> users = (_userSuccess?.users ?? []);
      if (page == 1) {
        // clear old data.
        users.clear();
      }
      _hasMore = data.isNotEmpty;

      _userSuccess = SearchUserState.success(page, users..addAll(data));
      return _userSuccess;
    } catch (e) {
      print('异常:$e');
      return SearchUserState.error(e);
    }
  }
}
