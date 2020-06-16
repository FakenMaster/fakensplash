import 'package:fakensplash/bloc/photo_detail/photo_detail_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/widget/load_error_widget.dart';
import 'package:fakensplash/ui/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        body: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: photo.width / photo.height,
              child: Image.network(
                '${photo.urls.regular}',
                fit: BoxFit.contain,
              ),
            ),
            Expanded(child: BlocBuilder<PhotoDetailBloc, PhotoDetailState>(
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
                      Tuple2(
                          Icons.date_range, photo.updatedAt.toIso8601String()),
                      Tuple2(Icons.favorite, '${photo.likes} Likes'),
                      Tuple2(
                          Icons.file_download, '${photo.downloads} Downloads'),
                      Tuple2(Icons.palette, '${photo.color}')
                    ];
                    return Column(
                      children: [
                        Container(
                          height: 50.0,
                          width: double.infinity,
                          color: Colors.grey,
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(photo.user.profileImage.small),
                              ),
                              SizedBox(
                                width: 40.0,
                              ),
                              Text('By ${photo.user.name}'),
                              Spacer(),
                              IconButton(
                                  onPressed: () {}, icon: Icon(Icons.favorite)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.bookmark_border)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text('${photo.description}'),
                              ...data.map((tuple) {
                                return Row(
                                  children: [
                                    Icon(tuple.item1),
                                    SizedBox(
                                      width: 40.0,
                                    ),
                                    Text(tuple.item2),
                                  ],
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
            )),
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
