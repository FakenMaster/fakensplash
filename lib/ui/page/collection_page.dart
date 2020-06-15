import 'package:fakensplash/bloc/collection/bloc/collection_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/widget/collection_list.dart';
import 'package:fakensplash/ui/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CollectionPage extends StatefulWidget {
  CollectionPage({Key key}) : super(key: key);
  @override
  _CollectionPageState createState() => _CollectionPageState();
}

class _CollectionPageState extends State<CollectionPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.bloc<CollectionBloc>().add(CollectionEvent.refresh());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.bloc<CollectionBloc>().add(CollectionEvent.refresh());
      },
      child: BlocBuilder<CollectionBloc, CollectionState>(
        builder: (context, state) {
          return state.when(
            initial: () => Container(),
            loading: () => LoadingWidget(),
            loadMore: () {
              return CollectionListWidget(
                collections: context.bloc<CollectionBloc>().collectionSuccess.collections,
                hasLoadMore: true,
              );
            },
            error: (error) => ErrorWidget(error),
            success: (int pageNo, List<Collection> collections) =>
                CollectionListWidget(collections: collections),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
