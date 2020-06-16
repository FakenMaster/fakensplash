import 'package:auto_route/auto_route.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/collection/collection_bloc.dart';
import '../../route/splash_router.gr.dart';

class CollectionListWidget extends StatelessWidget {
  final List<Collection> collections;
  final bool hasLoadMore;
  CollectionListWidget(
      {Key key, @required this.collections, this.hasLoadMore = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
          context.bloc<CollectionBloc>().loadMore();
          return true;
        }
        return false;
      },
      child: ListView.builder(
        key: PageStorageKey('Collections'),
        itemBuilder: (context, index) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              ExtendedNavigator.of(context)
                  .pushNamed(Routes.collectionDetailPage);
            },
            child: itemWidget(index, context),
          );
        },
        itemCount: collections.length + 1,
      ),
    );
  }

  Widget itemWidget(int index, BuildContext context) {
    if (index == collections.length) {
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
    var collection = collections[index];
    var coverPhoto = collection.coverPhoto;

    double width = MediaQuery.of(context).size.width;
    double dpr = MediaQuery.of(context).devicePixelRatio;
    // print('图片:' + coverPhoto.urls.raw + "&w=$width&dpr=$dpr");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: HexColor.fromHex(coverPhoto.color),
          child: AspectRatio(
            aspectRatio: coverPhoto.width / coverPhoto.height,
            child: Image.network(
              coverPhoto.urls.small,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${collection.title}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                '${collection.totalPhotos} photos',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
