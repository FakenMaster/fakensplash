part of 'search_photo_bloc.dart';

@immutable
@freezed
abstract class SearchPhotoState with _$SearchPhotoState {
  const factory SearchPhotoState.initial() = SearchPhotoInitial;
  const factory SearchPhotoState.loading() = SearchPhotoLoading;
  const factory SearchPhotoState.loadMore() = SearchPhotoLoadMore;
  const factory SearchPhotoState.error(dynamic error) = SearchPhotoError;
  const factory SearchPhotoState.success(int page, List<Photo> photos) =
      SearchPhotoSuccess;
}
