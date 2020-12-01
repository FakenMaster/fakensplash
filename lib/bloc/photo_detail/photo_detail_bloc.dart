import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/repository/repository.dart';
import 'package:fakensplash/util/utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

part 'photo_detail_event.dart';
part 'photo_detail_state.dart';
part 'photo_detail_bloc.freezed.dart';

class PhotoDetailBloc extends Bloc<PhotoDetailEvent, PhotoDetailState> {

  PhotoDetailBloc() : super(PhotoDetailState.initial());
  @override
  Stream<PhotoDetailState> mapEventToState(
    PhotoDetailEvent event,
  ) async* {
    yield PhotoDetailState.loading();
    if (event is PhotoDetailLoadEvent) {
      yield await loadDetail(event.id);
    }
  }

  Future _trackDownload(String id) async {
    GetIt.I<Repository>().trackDownload(id);
  }

  Future download(String url, String photoId) async {
    toast("Download started");

    /// track photo download from unsplash api request.
    _trackDownload(photoId);
    GallerySaver.saveImage(url).then((bool success) {
      if (success) {
        toast('Download success');
      }
    }, onError: (e) {
      toast('$e');
    });
  }

  Future<PhotoDetailState> loadDetail(String id) async {
    try {
      var data = await GetIt.I<Repository>().photoDetail(id);
      if (data is Photo) {
        return PhotoDetailState.success(data);
      }
      return PhotoDetailState.error('null');
    } catch (e) {
      print('详情异常:$e');
      return PhotoDetailState.error(e);
    }
  }
}
