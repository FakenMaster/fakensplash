import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../../repository/repository.dart';

part 'collection_event.dart';
part 'collection_state.dart';
part 'collection_bloc.freezed.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  @override
  CollectionState get initialState => CollectionInitial();

  @override
  Stream<CollectionState> mapEventToState(
    CollectionEvent event,
  ) async* {
    yield CollectionLoading();
    if (event is CollectionRefreshEvent) {
      yield await refresh();
    } else if (event is CollectionLoadMoreEvent) {}
  }

  Future<CollectionState> refresh() async {
    try {
      List<Collection> data = await GetIt.I<Repository>().collections();
      if (data == null) {
        return CollectionState.error('数据为空');
      }
      print('collection：${data.join()}');
      return CollectionState.success(1, data);
    } catch (e) {
      print('错误:$e');
      return CollectionState.error(e);
    }
  }
}
