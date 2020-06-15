part of 'photo_bloc.dart';

@immutable
@freezed
abstract class PhotoEvent with _$PhotoEvent{
  const factory PhotoEvent.refresh() = PhotoRefreshEvent;
  const factory PhotoEvent.loadMore(int page) = PhotoLoadMoreEvent;
}
