part of 'photo_detail_bloc.dart';

@immutable
@freezed
abstract class PhotoDetailEvent with _$PhotoDetailEvent {
  const factory PhotoDetailEvent.loadData(String id) = PhotoDetailLoadEvent;
}
