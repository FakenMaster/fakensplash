part of 'search_user_bloc.dart';

@immutable
@freezed
abstract class SearchUserEvent with _$SearchUserEvent {
  const factory SearchUserEvent.refresh({String query}) =
      SearchUserRefreshEvent;
  const factory SearchUserEvent.loadMore(int page) = SearchUserLoadMoreEvent;
}
