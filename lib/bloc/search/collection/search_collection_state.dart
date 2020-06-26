part of 'search_collection_bloc.dart';

@immutable
@freezed
abstract class SearchCollectionState with _$SearchCollectionState {
  const factory SearchCollectionState.initial() = SearchCollectionInitial;
  const factory SearchCollectionState.loading() = SearchCollectionLoading;
  const factory SearchCollectionState.loadMore() = SearchCollectionLoadMore;
  const factory SearchCollectionState.error(dynamic error) =
      SearchCollectionError;
  const factory SearchCollectionState.success(
      int page, List<Collection> collections) = SearchCollectionSuccess;
}
