import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

part 'user_collection_bloc.freezed.dart';
part 'user_collection_event.dart';
part 'user_collection_state.dart';

class UserCollectionBloc
    extends Bloc<UserCollectionEvent, UserCollectionState> {
  UserCollectionSuccess _collectionSuccess;

  UserCollectionSuccess get collectionSuccess => _collectionSuccess;
  final String username;
  bool _hasMore = true;

  UserCollectionBloc({@required this.username}):super(UserCollectionState.initial());

  @override
  Stream<Transition<UserCollectionEvent, UserCollectionState>> transformEvents(
      Stream<UserCollectionEvent> events, transitionFn) {
    return events.distinct((previous, current) {
      var isEqual = current != null &&
          current is! UserCollectionRefreshEvent &&
          previous == current;
      // print('请求相同吗:$isEqual');
      var currentStateIsError = state is UserCollectionError;
      // print('上次的结果是error吗:$currentStateIsError');
      return isEqual && !currentStateIsError;
    }).switchMap(transitionFn);
  }

  @override
  Stream<UserCollectionState> mapEventToState(
    UserCollectionEvent event,
  ) async* {
    if (event is UserCollectionLoadMoreEvent) {
      yield UserCollectionLoadMore();
    } else {
      yield UserCollectionLoading();
    }
    if (event is UserCollectionRefreshEvent) {
      yield await _loadData();
    } else if (event is UserCollectionLoadMoreEvent) {
      var data = await _loadData(page: event.page);
      yield data;
    }
  }

  loadMore() async {
    if (_hasMore) {
      add(UserCollectionLoadMoreEvent(_collectionSuccess.page + 1));
    }
  }

  Future<UserCollectionState> _loadData({int page = 1}) async {
    try {
      var data =
          await GetIt.I<Repository>().userCollections(username, page: page);
      if (data == null) {
        return UserCollectionState.error('数据为空');
      }
      List<Collection> collections = (_collectionSuccess?.collections ?? []);
      if (page == 1) {
        // clear old data.
        collections.clear();
      }
      _hasMore = data.isNotEmpty;

      _collectionSuccess =
          UserCollectionState.success(page, collections..addAll(data));
      return _collectionSuccess;
    } catch (e) {
      print('异常:$e');
      return UserCollectionState.error(e);
    }
  }
}
