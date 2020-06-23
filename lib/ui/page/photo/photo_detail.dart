import 'package:fakensplash/bloc/photo_detail/photo_detail_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/widget/load_error_widget.dart';
import 'package:fakensplash/ui/widget/loading_widget.dart';
import 'package:fakensplash/util/colors.dart';
import 'package:fakensplash/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:tuple/tuple.dart';

class PhotoDetailPage extends StatefulWidget {
  @override
  _PhotoDetailPageState createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  bool actionVisible = false;

  @override
  Widget build(BuildContext context) {
    var photo = context.watch<Photo>();
    print('photo:${photo.toJson().toString()}');
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.public),
                  onPressed: () {
                    // Todo:这个链接好像要加上本应用的数据
                    launchUrl(photo.links.html);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    final RenderBox box = context.findRenderObject();
                    Share.share(photo.links.html,
                        sharePositionOrigin:
                            box.localToGlobal(Offset.zero) & box.size);
                  },
                )
              ],
            )
          ];
        },
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: photo.width / photo.height,
                    child: Image.network(
                      '${photo.urls.regular}',
                      fit: BoxFit.contain,
                    ),
                  ),
                  BlocBuilder<PhotoDetailBloc, PhotoDetailState>(
                    builder: (BuildContext context, PhotoDetailState state) {
                      return state.when(
                        initial: () {
                          context.bloc<PhotoDetailBloc>().add(
                              PhotoDetailEvent.loadData(
                                  context.watch<Photo>().id));
                          return Container();
                        },
                        loading: () => LoadingWidget(
                          center: false,
                        ),
                        error: (error) => LoadErrorWidget(error: error),
                        success: (Photo photoDetail) {
                          print('数据:${photoDetail.toJson().toString()}');
                          List<Tuple2<IconData, String>> data = [
                            if (photo.location != null &&
                                photo.location.city != null)
                              Tuple2(Icons.location_on,
                                  '${photo.location.city},${photo.location.country}'),
                            Tuple2(
                                Icons.date_range,
                                DateFormat('yyyy-MM-dd')
                                    .format(photoDetail.createdAt)),
                            Tuple2(
                                Icons.favorite, '${photoDetail.likes} Likes'),
                            Tuple2(Icons.file_download,
                                '${photoDetail.downloads} Downloads'),
                            Tuple2(Icons.palette, photoDetail.color)
                          ];
                          return Column(
                            children: [
                              Container(
                                height: 50.0,
                                width: double.infinity,
                                color: Color(0xfff5f6fa),
                                padding: EdgeInsets.symmetric(horizontal: 16.0),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 30.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                            photoDetail
                                                .user.profileImage.medium,
                                          ))),
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                    Expanded(
                                        child: Text(
                                      'By ${photoDetail.user.name}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.favorite_border)),
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.bookmark_border)),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${photoDetail.description ?? ''}'),
                                    SizedBox(
                                      height: 6.0,
                                    ),
                                    ...data.asMap().entries.map((entry) {
                                      var isLast = entry.key == data.length - 1;
                                      var tuple = entry.value;
                                      print('$isLast,$tuple');
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.0),
                                        child: Row(
                                          children: [
                                            Icon(tuple.item1),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            Text(tuple.item2),
                                            SizedBox(
                                              width: 20.0,
                                            ),
                                            if (isLast)
                                              Container(
                                                width: 12.0,
                                                height: 12.0,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: HexColor.fromHex(
                                                      tuple.item2),
                                                ),
                                              )
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: context.bloc<PhotoDetailBloc>().state is PhotoDetailSuccess,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            AnimatedOpacity(
              duration: Duration(milliseconds: 200),
              opacity: actionVisible ? 1.0 : 0.0,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'Stats',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FloatingActionButton(
                          mini: true,
                          heroTag: 'Stats',
                          onPressed: () {},
                          child: Icon(Icons.timeline),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 6.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            'Info',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FloatingActionButton(
                          heroTag: 'Info',
                          mini: true,
                          onPressed: () {},
                          child: Icon(Icons.info_outline),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'Set as wallpaper',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: FloatingActionButton(
                          heroTag: 'Set as wallpaper',
                          mini: true,
                          onPressed: () {},
                          child: Icon(Icons.wallpaper),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 4.0,
                          horizontal: 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          'Download',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: FloatingActionButton(
                          heroTag: 'Download',
                          onPressed: () {},
                          mini: true,
                          child: Icon(Icons.file_download),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            FloatingActionButton(
              heroTag: 'actions',
              child: RotatedBox(
                quarterTurns: actionVisible ? 2 : 0,
                child: Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  actionVisible = !actionVisible;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
