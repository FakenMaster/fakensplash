part of 'collection_bloc.dart';

@immutable
@freezed
abstract class CollectionEvent with _$CollectionEvent{
  const factory CollectionEvent.refresh({bool featured}) = CollectionRefreshEvent;
  const factory CollectionEvent.loadMore(int page) = CollectionLoadMoreEvent;
}
