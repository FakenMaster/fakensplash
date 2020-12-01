import 'package:fakensplash/bloc/collection_photo/collection_photo_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/widget/collection_photo_list.dart';
import 'package:fakensplash/ui/widget/load_error_widget.dart';
import 'package:fakensplash/ui/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionPhotoPage extends StatelessWidget {
  final int collectionId;

  CollectionPhotoPage({Key key, this.collectionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CollectionPhotoBloc>(
      create: (_) => CollectionPhotoBloc(collectionId: collectionId),
      child: _CollectionPhotoPage(),
    );
  }
}

class _CollectionPhotoPage extends StatefulWidget {
  @override
  _CollectionPhotoPageState createState() => _CollectionPhotoPageState();
}

class _CollectionPhotoPageState extends State<_CollectionPhotoPage>
    with AutomaticKeepAliveClientMixin {
  CollectionPhotoBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<CollectionPhotoBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionPhotoBloc, CollectionPhotoState>(
      builder: (context, state) {
        return state.when(
          initial: () {
            bloc.add(CollectionPhotoEvent.refresh());
            return Container();
          },
          loading: () => LoadingWidget(),
          loadMore: () {
            return CollectionPhotoListWidget(
              photos: bloc.photoSuccess.photos,
              hasLoadMore: true,
            );
          },
          error: (error) => LoadErrorWidget(
              error: error,
              clickCallback: () => bloc.add(
                    CollectionPhotoRefreshEvent(),
                  )),
          success: (int page, List<Photo> photos) => CollectionPhotoListWidget(
            photos: photos,
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
