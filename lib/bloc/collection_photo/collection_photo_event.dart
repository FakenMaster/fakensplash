part of 'collection_photo_bloc.dart';

@immutable
@freezed
abstract class CollectionPhotoEvent with _$CollectionPhotoEvent {
  const factory CollectionPhotoEvent.refresh() = CollectionPhotoRefreshEvent;

  const factory CollectionPhotoEvent.loadData(int page) = CollectionPhotoLoadMoreEvent;
}
