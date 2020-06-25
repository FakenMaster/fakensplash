import 'dart:ui' as ui;

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakensplash/bloc/photo_detail/photo_detail_bloc.dart';
import 'package:fakensplash/bloc/photo_statistics/photo_statistics_bloc.dart';
import 'package:fakensplash/bloc/user_profile/user_profile_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/route/splash_router.gr.dart';
import 'package:fakensplash/ui/page/photo/photo_statistics.dart';
import 'package:fakensplash/ui/page/user/user_profile.dart';
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
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          NestedScrollView(
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
                      GestureDetector(
                        onTap: () => ExtendedNavigator.of(context).pushNamed(
                          Routes.photoPreviewPage,
                          arguments: PhotoPreviewPageArguments(
                            url: photo.urls.full,
                          ),
                        ),
                        child: AspectRatio(
                          aspectRatio: photo.width / photo.height,
                          child: CachedNetworkImage(
                            imageUrl: '${photo.urls.regular}',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      BlocBuilder<PhotoDetailBloc, PhotoDetailState>(
                        builder:
                            (BuildContext context, PhotoDetailState state) {
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
                                Tuple2(Icons.favorite,
                                    '${photoDetail.likes} Likes'),
                                Tuple2(Icons.file_download,
                                    '${photoDetail.downloads} Downloads'),
                                Tuple2(Icons.palette, photoDetail.color)
                              ];
                              return Column(
                                children: [
                                  Container(
                                    height: 50.0,
                                    width: MediaQuery.of(context).size.width,
                                    color: Color(0xfff5f6fa),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () =>
                                              _toUserProfile(photoDetail.user),
                                          child: Container(
                                            width: 30.0,
                                            height: 30.0,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image:
                                                        CachedNetworkImageProvider(
                                                  photoDetail
                                                      .user.profileImage.medium,
                                                ))),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Expanded(
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: GestureDetector(
                                                  onTap: () => _toUserProfile(
                                                      photoDetail.user),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Text(
                                                      'By ${photoDetail.user.name}',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.clip,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Visibility(
                                          visible:
                                              (photoDetail.description ?? '')
                                                  .isNotEmpty,
                                          child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 6.0),
                                            child: Text(
                                                '${photoDetail.description ?? ''}'),
                                          ),
                                        ),
                                        ...data.asMap().entries.map((entry) {
                                          var isLast =
                                              entry.key == data.length - 1;
                                          var tuple = entry.value;
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
          Visibility(
            visible: actionVisible,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                print('蒙层点击');
                setState(() {
                  actionVisible = false;
                });
              },
              child: BackdropFilter(
                filter: ui.ImageFilter.blur(
                  sigmaX: 1.0,
                  sigmaY: 1.0,
                ),
                child: Text('123'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: BlocBuilder<PhotoDetailBloc, PhotoDetailState>(
          builder: (context, state) {
        if (state is PhotoDetailSuccess) return actionButton();
        return Container();
      }),
    );
  }

  void _toUserProfile(User user) {
    ExtendedNavigator.of(context).push(MaterialPageRoute(
      builder: (_) {
        return MultiProvider(
          providers: [
            Provider(
              create: (_) => user,
            ),
            BlocProvider(
              create: (_) => UserProfileBloc(),
            )
          ],
          child: UserProfilePage(),
        );
      },
    ));
  }

  Widget actionButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Visibility(
          visible: actionVisible,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              ...<Tuple3<String, IconData, VoidCallback>>[
                Tuple3('Stats', Icons.timeline, _showStatisticsDialog),
                Tuple3('Info', Icons.info_outline, _showInfoDialog),
                Tuple3('Set as wallpaper', Icons.wallpaper, () {
                  var photo = context.read<Photo>();
                  setWallpaper(
                      '${photo.urls.full}.unsplash-${photo.id}-${photo.user.name}.jpg');
                }),
                Tuple3('Download', Icons.file_download, () {
                  var photo = context.read<Photo>();
                  context.bloc<PhotoDetailBloc>().download(
                      '${photo.urls.full}.unsplash-${photo.id}-${photo.user.name}.jpg',
                      photo.id);
                })
              ]
                  .map(
                    (e) => GestureDetector(
                      onTap: e.item3,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
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
                              e.item1,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: FloatingActionButton(
                              mini: true,
                              heroTag: e.item1,
                              onPressed: () {
                                setState(() {
                                  actionVisible = false;
                                });
                                e.item3?.call();
                              },
                              child: Icon(e.item2),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  .toList(),
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
    );
  }

  void _showStatisticsDialog() {
    String id = context.read<Photo>().id;
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: BlocProvider<PhotoStatisticsBloc>(
              create: (context) => PhotoStatisticsBloc(),
              child: PhotoStatisticsPage(
                id: id,
              ),
            ),
          );
        });
  }

  void _showInfoDialog() {
    var photo =
        (context.bloc<PhotoDetailBloc>().state as PhotoDetailSuccess).photo;
    var photoExif = photo.exif;
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          String _checkNull(dynamic checkStr, String prefix,
              {String defaultStr = '-----'}) {
            if (checkStr == null || checkStr.toString().trim().isEmpty) {
              return defaultStr;
            }
            return '$prefix$checkStr';
          }

          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Tuple2<IconData, String>>[
                  Tuple2(Icons.straighten,
                      'Dimensions:${photo.width} x ${photo.height}'),
                  Tuple2(Icons.image, _checkNull(photoExif.make, 'Make: ')),
                  Tuple2(
                      Icons.camera_alt, _checkNull(photoExif.model, 'Model: ')),
                  Tuple2(Icons.timelapse,
                      _checkNull(photoExif.exposureTime, 'Exposure time: ')),
                  Tuple2(Icons.camera,
                      _checkNull(photoExif.aperture, 'Aperture: ')),
                  Tuple2(Icons.iso, _checkNull(photoExif.iso, 'ISO: ')),
                  Tuple2(Icons.all_out,
                      _checkNull(photoExif.focalLength, 'Focal length: ')),
                ].map((e) {
                  return Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Icon(e.item1),
                          SizedBox(
                            width: 20,
                          ),
                          Text(e.item2),
                        ],
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          );
        });
  }
}
