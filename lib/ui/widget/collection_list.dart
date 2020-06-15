import 'package:auto_route/auto_route.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../route/splash_router.gr.dart';

class CollectionListWidget extends StatelessWidget {
  final List<Collection> collections;
  final bool hasLoadMore;
  CollectionListWidget({Key key, @required this.collections, this.hasLoadMore})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: PageStorageKey(10),
      itemBuilder: (context, index) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            ExtendedNavigator.of(context)
                .pushNamed(Routes.collectionDetailPage);
          },
          child: itemWidget(index),
        );
      },
      itemCount: collections.length + 1,
    );
  }

  Widget itemWidget(int index) {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: BACKGROUND_COLORS[index.remainder(BACKGROUND_COLORS.length)],
          child: AspectRatio(
            aspectRatio: coverPhoto.width / coverPhoto.height,
            child: Image.network(
              coverPhoto.urls.small,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20.0),
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
