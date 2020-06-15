import 'package:fakensplash/bloc/photo/photo_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoListWidget extends StatelessWidget {
  final List<Photo> photos;
  final bool hasLoadMore;
  PhotoListWidget({Key key, @required this.photos, this.hasLoadMore = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
          context.bloc<PhotoBloc>().loadMore();
          return true;
        }
        return false;
      },
      child: ListView.builder(
        key: PageStorageKey(10),
        itemBuilder: (context, index) {
          if (index == photos.length) {
            if (hasLoadMore) {
              return Center(
                child: Container(
                  width: 50,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return SizedBox();
          }
          var photo = photos[index];
          double width = MediaQuery.of(context).size.width;
          double dpr = MediaQuery.of(context).devicePixelRatio;
          return Container(
            color: BACKGROUND_COLORS[index.remainder(BACKGROUND_COLORS.length)],
            child: AspectRatio(
              aspectRatio: photo.width / photo.height,
              child: Image.network(
                photos[index].urls.raw+"?w=$width&dpr=$dpr",
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        itemCount: photos.length + 1,
      ),
    );
  }
}
