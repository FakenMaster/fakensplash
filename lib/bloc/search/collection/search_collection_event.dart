part of 'search_collection_bloc.dart';

@immutable
@freezed
abstract class SearchCollectionEvent with _$SearchCollectionEvent {
  const factory SearchCollectionEvent.refresh({String query}) =
      SearchCollectionRefreshEvent;
  const factory SearchCollectionEvent.loadMore(int page) =
      SearchCollectionLoadMoreEvent;
}
