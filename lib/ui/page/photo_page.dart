import 'package:fakensplash/bloc/photo/photo_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/widget/load_error_widget.dart';
import 'package:fakensplash/ui/widget/loading_widget.dart';
import 'package:fakensplash/ui/widget/phot_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/photo/photo_bloc.dart';

class PhotoPage extends StatefulWidget {
  @override
  _PhotoPageState createState() => _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage>
    with AutomaticKeepAliveClientMixin {
  PhotoBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.bloc<PhotoBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PhotoBloc, PhotoState>(
      builder: (context, state) {
        return state.when(
          initial: () {
            bloc.add(PhotoEvent.refresh());
            return Container();
          },
          loading: () => LoadingWidget(),
          loadMore: () {
            return PhotoListWidget(
              photos: bloc.photoSuccess.photos,
              hasLoadMore: true,
            );
          },
          error: (error) => LoadErrorWidget(
              error: error,
              clickCallback: () => bloc.add(
                    PhotoRefreshEvent(),
                  )),
          success: (int page, List<Photo> photos) =>
              PhotoListWidget(photos: photos),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
