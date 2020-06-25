part of 'user_collection_bloc.dart';

@immutable
@freezed
abstract class UserCollectionState with _$UserCollectionState {
  const factory UserCollectionState.initial() = UserCollectionInitial;

  const factory UserCollectionState.loading() = UserCollectionLoading;

  const factory UserCollectionState.loadMore() = UserCollectionLoadMore;

  const factory UserCollectionState.error(dynamic error) = UserCollectionError;

  const factory UserCollectionState.success(
      int page, List<Collection> collections) = UserCollectionSuccess;
}
