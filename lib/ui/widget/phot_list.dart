import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/util/colors.dart';
import 'package:flutter/widgets.dart';

class PhotoListWidget extends StatelessWidget {
  final List<Photo> photos;
  PhotoListWidget({Key key, @required this.photos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: PageStorageKey(10),
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        var photo = photos[index];
        return Container(
          color: AMERICAN_COLORS[index.remainder(AMERICAN_COLORS.length)],
          child: AspectRatio(
            aspectRatio: photo.width / photo.height,
            child: Image.network(
              photos[index].urls.small,
            ),
          ),
        );
      },
      itemCount: photos.length,
    );
  }
}
