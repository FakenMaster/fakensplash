import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'photo_detail_event.dart';
part 'photo_detail_state.dart';

class PhotoDetailBloc extends Bloc<PhotoDetailEvent, PhotoDetailState> {
  @override
  PhotoDetailState get initialState => PhotodetailInitial();

  @override
  Stream<PhotoDetailState> mapEventToState(
    PhotoDetailEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
