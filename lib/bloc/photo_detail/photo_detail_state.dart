part of 'photo_detail_bloc.dart';

@immutable
@freezed
abstract class PhotoDetailState with _$PhotoDetailState {
  const factory PhotoDetailState.initial() = PhotoDetailInitial;
  const factory PhotoDetailState.loading() = PhotoDetailLoading;
  const factory PhotoDetailState.error(dynamic error) = PhotoDetailError;
  const factory PhotoDetailState.success(Photo photo) = PhotoDetailSuccess;
}
