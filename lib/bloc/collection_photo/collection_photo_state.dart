part of 'collection_photo_bloc.dart';

@immutable
@freezed
abstract class CollectionPhotoState with _$CollectionPhotoState {
  const factory CollectionPhotoState.initial() = CollectionPhotoInitial;

  const factory CollectionPhotoState.loading() = CollectionPhotoLoading;

  const factory CollectionPhotoState.loadMore() = CollectionPhotoLoadMore;

  const factory CollectionPhotoState.success(int page, List<Photo> photos) =
      CollectionPhotoSuccess;

  const factory CollectionPhotoState.error(dynamic error) = CollectionPhotoError;
}
