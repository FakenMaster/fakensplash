part of 'user_profile_bloc.dart';

@immutable
@freezed
abstract class UserProfileState with _$UserProfileState {
  const factory UserProfileState.initial() = UserProfileInitial;
  const factory UserProfileState.loading() = UserProfileLoading;
  const factory UserProfileState.success(User userDetail) = UserProfileSuccess;
  const factory UserProfileState.error(dynamic error) = UserProfileError;
}
