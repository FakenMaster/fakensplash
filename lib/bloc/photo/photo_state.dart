part of 'photo_bloc.dart';

@immutable
@freezed
abstract class PhotoState with _$PhotoState{
  const factory PhotoState.initial() = PhotoInitial;
  const factory PhotoState.loading() = PhotoLoading;
  const factory PhotoState.error(dynamic error) = PhotoError;
  const factory PhotoState.success(int page,List<Photo>photos) = PhotoSuccess;
}

