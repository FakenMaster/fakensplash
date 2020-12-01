import 'package:fakensplash/model/photo/photo_statistics.dart';
import 'package:fakensplash/repository/repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';

part 'photo_statistics_event.dart';
part 'photo_statistics_state.dart';
part 'photo_statistics_bloc.freezed.dart';

class PhotoStatisticsBloc
    extends Bloc<PhotoStatisticsEvent, PhotoStatisticsState> {

  PhotoStatisticsBloc() : super(PhotoStatisticsState.initial());
  @override
  Stream<PhotoStatisticsState> mapEventToState(
      PhotoStatisticsEvent event) async* {
    yield PhotoStatisticsState.loading();
    if (event is PhotoStatisticsLoadData) {
      yield await loadData(event.id);
    }
  }

  Future<PhotoStatisticsState> loadData(String id) async {
    try {
      var data = await GetIt.I<Repository>().photoStatistics(id);
      if (data is PhotoStatistics) {
        return PhotoStatisticsState.success(data);
      }
      return PhotoStatisticsState.error('null');
    } catch (e) {
      print('统计异常:$e');
      return PhotoStatisticsState.error(e);
    }
  }
}
