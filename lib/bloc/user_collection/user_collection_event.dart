part of 'user_collection_bloc.dart';

@immutable
@freezed
abstract class UserCollectionEvent with _$UserCollectionEvent {
  const factory UserCollectionEvent.refresh() = UserCollectionRefreshEvent;
  const factory UserCollectionEvent.loadMore(int page) =
      UserCollectionLoadMoreEvent;
}
