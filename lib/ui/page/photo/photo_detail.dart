import 'package:date_format/date_format.dart';
import 'package:fakensplash/bloc/photo_detail/photo_detail_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/widget/load_error_widget.dart';
import 'package:fakensplash/ui/widget/loading_widget.dart';
import 'package:fakensplash/util/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class PhotoDetailPage extends StatefulWidget {
  @override
  _PhotoDetailPageState createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  @override
  Widget build(BuildContext context) {
    var photo = context.watch<Photo>();
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.public),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {},
                )
              ],
            )
          ];
        },
        body: CustomScrollView(
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: AspectRatio(
                aspectRatio: photo.width / photo.height,
                child: Image.network(
                  '${photo.urls.regular}',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<PhotoDetailBloc, PhotoDetailState>(
                builder: (BuildContext context, PhotoDetailState state) {
                  return state.when(
                    initial: () {
                      context.bloc<PhotoDetailBloc>().add(
                          PhotoDetailEvent.loadData(context.watch<Photo>().id));
                      return Container();
                    },
                    loading: () => LoadingWidget(
                      center: false,
                    ),
                    error: (error) => LoadErrorWidget(error: error),
                    success: (Photo photo) {
                      List<Tuple2<IconData, String>> data = [
                        if (photo.location != null &&
                            photo.location.city != null)
                          Tuple2(Icons.location_on,
                              '${photo.location.city},${photo.location.country}'),
                        Tuple2(
                            Icons.date_range,
                            formatDate(photo.updatedAt,
                                ['yyyy', '-', 'MM', '-', 'dd'])),
                        Tuple2(Icons.favorite, '${photo.likes} Likes'),
                        Tuple2(Icons.file_download,
                            '${photo.downloads} Downloads'),
                        Tuple2(Icons.palette, '${photo.color}')
                      ];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 40.0,
                            width: double.infinity,
                            color: Colors.grey[300],
                            padding: EdgeInsets.only(left: 20.0, right: 10.0),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 12.0,
                                  backgroundImage: NetworkImage(
                                      photo.user.profileImage.large),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Text(
                                  'By ${photo.user.name}',
                                  style: TextStyle(fontSize: 13.0),
                                ),
                                Spacer(),
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
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: photo.description != null,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Text('${photo.description}'),
                                  ),
                                ),
                                ...data.asMap().keys.map((index) {
                                  var tuple = data[index];
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0),
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
                                        if (index == data.length - 1)
                                          Container(
                                            width: 14.0,
                                            height: 14.0,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color:
                                                  HexColor.fromHex(photo.color),
                                            ),
                                          ),
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
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: context.bloc<PhotoDetailBloc>().state is PhotoDetailSuccess,
        child: FloatingActionButton(
          child: Icon(
            Icons.keyboard_arrow_up,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
