import 'package:fakensplash/bloc/photo_detail/photo_detail_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/widget/load_error_widget.dart';
import 'package:fakensplash/ui/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                  icon: FaIcon(FontAwesomeIcons.globe),
                  onPressed: () {},
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.share),
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
                  loading: () => LoadingWidget(center: false,),
                  error: (error) => LoadErrorWidget(error: error),
                  success: (Photo photo) => Text('有数据了'),
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
