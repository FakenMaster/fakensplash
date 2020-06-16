import 'package:auto_route/auto_route.dart';
import 'package:fakensplash/bloc/photo/photo_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/route/splash_router.gr.dart';
import 'package:fakensplash/ui/page/photo/photo_detail.dart';
import 'package:fakensplash/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
        key: PageStorageKey('Photo'),
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
          var width = MediaQuery.of(context).size.width.toInt();
          var dpr = MediaQuery.of(context).devicePixelRatio.toInt();
          // print('图片:' + photos[index].urls.raw + "&w=$width&dpr=$dpr");
          // print('smal:${photo.urls.toJson()}');
          return Hero(
            tag: photo.id,
            child: GestureDetector(
              onTap: () {
                ExtendedNavigator.of(context).push(MaterialPageRoute(
                  builder: (_) {
                    return Provider(
                      create: (_) => photo,
                      child: PhotoDetailPage(),
                    );
                  },
                ));
              },
              child: Container(
                color: HexColor.fromHex(photo.color),
                child: AspectRatio(
                  aspectRatio: photo.width / photo.height,
                  child: Image.network(
                    photo.urls.small,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
        itemCount: photos.length + 1,
      ),
    );
  }
}
