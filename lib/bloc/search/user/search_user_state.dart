part of 'search_user_bloc.dart';

@immutable
@freezed
abstract class SearchUserState with _$SearchUserState {
  const factory SearchUserState.initial() = SearchUserInitial;
  const factory SearchUserState.loading() = SearchUserLoading;
  const factory SearchUserState.loadMore() = SearchUserLoadMore;
  const factory SearchUserState.error(dynamic error) = SearchUserError;
  const factory SearchUserState.success(int page, List<User> users) =
      SearchUserSuccess;
}
