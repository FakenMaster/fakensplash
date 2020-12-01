import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

part 'user_photo_bloc.freezed.dart';
part 'user_photo_event.dart';
part 'user_photo_state.dart';

class UserPhotoBloc extends Bloc<UserPhotoEvent, UserPhotoState> {
  // save latest load success data
  UserPhotoSuccess _photoSuccess;

  UserPhotoSuccess get photoSuccess => _photoSuccess;

  final String username;
  final bool like;

  bool _hasMore = true;

  UserPhotoBloc({@required this.username, @required this.like}): super(UserPhotoState.initial());

  @override
  Stream<Transition<UserPhotoEvent, UserPhotoState>> transformEvents(
      Stream<UserPhotoEvent> events, transitionFn) {
    return events.distinct((previous, current) {
      var isEqual = current != null &&
          current is! UserPhotoRefreshEvent &&
          previous == current;
      // print('请求相同吗:$isEqual');
      var currentStateIsError = state is UserPhotoError;
      // print('上次的结果是error吗:$currentStateIsError');
      return isEqual && !currentStateIsError;
    }).switchMap(transitionFn)
      ..listen((event) {});
  }

  @override
  Stream<UserPhotoState> mapEventToState(
    UserPhotoEvent event,
  ) async* {
    if (event is UserPhotoLoadMoreEvent) {
      yield UserPhotoLoadMore();
    } else {
      yield UserPhotoLoading();
    }

    if (event is UserPhotoRefreshEvent) {
      yield await _loadData();
    } else if (event is UserPhotoLoadMoreEvent) {
      var data = await _loadData(page: event.page);
      yield data;
    }
  }

  loadMore() async {
    if (_hasMore) {
      add(UserPhotoLoadMoreEvent(_photoSuccess.page + 1));
    }
  }

  Future<UserPhotoState> _loadData({int page = 1}) async {
    page ??= 1;
    try {
      var data = await GetIt.I<Repository>()
          .userPhotosWithLike(username, page: page, like: like);
      if (data == null) {
        return UserPhotoState.error('数据为空');
      }
      List<Photo> photos = (_photoSuccess?.photos ?? []);
      if (page == 1) {
        // clear old data.
        photos.clear();
      }
      _hasMore = data.isNotEmpty;

      _photoSuccess = UserPhotoState.success(page, photos..addAll(data));
      return _photoSuccess;
    } catch (e) {
      print('捕获到了异常:$e');
      return UserPhotoState.error(e);
    }
  }
}
