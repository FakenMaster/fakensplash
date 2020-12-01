import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

part 'collection_photo_bloc.freezed.dart';
part 'collection_photo_event.dart';
part 'collection_photo_state.dart';

class CollectionPhotoBloc extends Bloc<CollectionPhotoEvent, CollectionPhotoState> {
  // save latest load success data
  CollectionPhotoSuccess _photoSuccess;

  CollectionPhotoSuccess get photoSuccess => _photoSuccess;

  final int collectionId;

  bool _hasMore = true;

  CollectionPhotoBloc({@required this.collectionId}):super(CollectionPhotoState.initial());

  @override
  Stream<Transition<CollectionPhotoEvent, CollectionPhotoState>> transformEvents(
      Stream<CollectionPhotoEvent> events, transitionFn) {
    return events.distinct((previous, current) {
      var isEqual = current != null &&
          current is! CollectionPhotoRefreshEvent &&
          previous == current;
      // print('请求相同吗:$isEqual');
      var currentStateIsError = state is CollectionPhotoError;
      // print('上次的结果是error吗:$currentStateIsError');
      return isEqual && !currentStateIsError;
    }).switchMap(transitionFn)
      ..listen((event) {});
  }

  @override
  Stream<CollectionPhotoState> mapEventToState(
    CollectionPhotoEvent event,
  ) async* {
    if (event is CollectionPhotoLoadMoreEvent) {
      yield CollectionPhotoLoadMore();
    } else {
      yield CollectionPhotoLoading();
    }

    if (event is CollectionPhotoRefreshEvent) {
      yield await _loadData();
    } else if (event is CollectionPhotoLoadMoreEvent) {
      var data = await _loadData(page: event.page);
      yield data;
    }
  }

  loadMore() async {
    if (_hasMore) {
      add(CollectionPhotoLoadMoreEvent(_photoSuccess.page + 1));
    }
  }

  Future<CollectionPhotoState> _loadData({int page = 1}) async {
    page ??= 1;
    try {
      var data = await GetIt.I<Repository>()
          .collectionPhotos(collectionId, page: page);
      if (data == null) {
        return CollectionPhotoState.error('数据为空');
      }
      List<Photo> photos = (_photoSuccess?.photos ?? []);
      if (page == 1) {
        // clear old data.
        photos.clear();
      }
      _hasMore = data.isNotEmpty;

      _photoSuccess = CollectionPhotoState.success(page, photos..addAll(data));
      return _photoSuccess;
    } catch (e) {
      print('捕获到了异常:$e');
      return CollectionPhotoState.error(e);
    }
  }
}
