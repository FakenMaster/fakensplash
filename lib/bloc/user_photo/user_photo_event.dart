part of 'user_photo_bloc.dart';

@immutable
@freezed
abstract class UserPhotoEvent with _$UserPhotoEvent {
  const factory UserPhotoEvent.refresh() = UserPhotoRefreshEvent;

  const factory UserPhotoEvent.loadData(int page) = UserPhotoLoadMoreEvent;
}
