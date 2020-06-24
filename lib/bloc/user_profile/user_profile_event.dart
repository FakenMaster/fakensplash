part of 'user_profile_bloc.dart';

@immutable
@freezed
abstract class UserProfileEvent with _$UserProfileEvent {
  const factory UserProfileEvent.loadData(String username) = UserProfileLoad;
}
