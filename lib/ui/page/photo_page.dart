import 'package:fakensplash/bloc/photo/photo_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/widget/loading_widget.dart';
import 'package:fakensplash/ui/widget/phot_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PhotoPage extends StatefulWidget {
  PhotoPage({Key key}) : super(key: key);
  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.bloc<PhotoBloc>().add(PhotoEvent.refresh());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.bloc<PhotoBloc>().add(PhotoEvent.refresh());
      },
      child: BlocBuilder<PhotoBloc, PhotoState>(
        builder: (context, state) {
          return state.when(
            initial: () => Container(),
            loading: () => LoadingWidget(),
            loadMore: () {
              return PhotoListWidget(
                photos: context.bloc<PhotoBloc>().photoSuccess.photos,
                hasLoadMore: true,
              );
            },
            error: (error) => ErrorWidget(error),
            success: (int page, List<Photo> photos) =>
                PhotoListWidget(photos: photos),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
