part of 'user_photo_bloc.dart';

@immutable
@freezed
abstract class UserPhotoState with _$UserPhotoState {
  const factory UserPhotoState.initial() = UserPhotoInitial;

  const factory UserPhotoState.loading() = UserPhotoLoading;

  const factory UserPhotoState.loadMore() = UserPhotoLoadMore;

  const factory UserPhotoState.success(int page, List<Photo> photos) =
      UserPhotoSuccess;

  const factory UserPhotoState.error(dynamic error) = UserPhotoError;
}
