part of 'photo_statistics_bloc.dart';

@immutable
@freezed
abstract class PhotoStatisticsEvent with _$PhotoStatisticsEvent {
  const factory PhotoStatisticsEvent.loadData(String id) =
      PhotoStatisticsLoadData;
}
