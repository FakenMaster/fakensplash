import 'package:fakensplash/bloc/collection/collection_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/widget/collection_list.dart';
import 'package:fakensplash/ui/widget/load_error_widget.dart';
import 'package:fakensplash/ui/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionPage extends StatefulWidget {
  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage>
    with AutomaticKeepAliveClientMixin {
  CollectionBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.bloc<CollectionBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CollectionBloc, CollectionState>(
      builder: (context, state) {
        return state.when(
          initial: () {
            bloc.add(CollectionEvent.refresh());
            return Container();
          },
          loading: () => LoadingWidget(),
          loadMore: () {
            return CollectionListWidget(
              collections: bloc.collectionSuccess.collections,
              hasLoadMore: true,
            );
          },
          error: (error) => LoadErrorWidget(
            error: error,
            clickCallback: () => bloc.add(CollectionRefreshEvent()),
          ),
          success: (int pageNo, List<Collection> collections) =>
              CollectionListWidget(collections: collections),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
