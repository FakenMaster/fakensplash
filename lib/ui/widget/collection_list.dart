import 'package:auto_route/auto_route.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../route/splash_router.gr.dart';

class CollectionListWidget extends StatelessWidget {
  final List<Collection> collections;
  CollectionListWidget({Key key, @required this.collections}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: PageStorageKey(10),
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var collection = collections[index];
        var coverPhoto = collection.coverPhoto;
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            ExtendedNavigator.of(context)
                .pushNamed(Routes.collectionDetailPage);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                color: AMERICAN_COLORS[index.remainder(AMERICAN_COLORS.length)],
                child: AspectRatio(
                  aspectRatio: coverPhoto.width / coverPhoto.height,
                  child: Image.network(
                    coverPhoto.urls.small,
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
          ),
        );
      },
      itemCount: collections.length,
    );
  }
}
