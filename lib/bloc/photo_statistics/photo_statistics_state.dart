part of 'photo_statistics_bloc.dart';

@immutable
@freezed
abstract class PhotoStatisticsState with _$PhotoStatisticsState {
  const factory PhotoStatisticsState.initial() = PhotoStatisticsInitial;
  const factory PhotoStatisticsState.loading() = PhotoStatisticsLoading;
  const factory PhotoStatisticsState.success(PhotoStatistics statistics) =
      PhotoStatisticsSuccess;
  const factory PhotoStatisticsState.error(dynamic error) =
      PhotoStatisticsError;
}
