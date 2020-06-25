import 'package:auto_route/auto_route.dart';
import 'package:fakensplash/bloc/collection_photo/collection_photo_bloc.dart';
import 'package:fakensplash/bloc/photo_detail/photo_detail_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/page/photo/photo_detail.dart';
import 'package:fakensplash/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CollectionPhotoListWidget extends StatelessWidget {
  final List<Photo> photos;
  final bool hasLoadMore;

  CollectionPhotoListWidget(
      {Key key, @required this.photos, this.hasLoadMore = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
          context.bloc<CollectionPhotoBloc>().loadMore();
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
          return Hero(
            tag: photo.id,
            child: GestureDetector(
              onTap: () {
                ExtendedNavigator.of(context).push(MaterialPageRoute(
                  builder: (_) {
                    return MultiProvider(
                      providers: [
                        Provider(
                          create: (_) => photo,
                        ),
                        BlocProvider(
                          create: (_) => PhotoDetailBloc(),
                        )
                      ],
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
