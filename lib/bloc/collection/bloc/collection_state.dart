part of 'collection_bloc.dart';

@immutable
@freezed
abstract class CollectionState with _$CollectionState {
  const factory CollectionState.initial() = CollectionInitial;
  const factory CollectionState.loading() = CollectionLoading;
  const factory CollectionState.loadMore() = CollectionLoadMore;
  const factory CollectionState.error(dynamic error) = CollectionError;
  const factory CollectionState.success(
      int page, List<Collection> collections) = CollectionSuccess;
}
