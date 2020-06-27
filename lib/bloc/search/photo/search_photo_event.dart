part of 'search_photo_bloc.dart';

@immutable
@freezed
abstract class SearchPhotoEvent with _$SearchPhotoEvent {
  const factory SearchPhotoEvent.refresh({String query, String orientation}) =
      SearchPhotoRefreshEvent;
  const factory SearchPhotoEvent.loadMore(int page) = SearchPhotoLoadMoreEvent;
}
