import 'package:fakensplash/bloc/search/collection/search_collection_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/widget/collection_list.dart';
import 'package:fakensplash/ui/widget/load_error_widget.dart';
import 'package:fakensplash/ui/widget/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCollectionPage extends StatefulWidget {
  @override
  _SearchCollectionPageState createState() => _SearchCollectionPageState();
}

class _SearchCollectionPageState extends State<SearchCollectionPage>
    with AutomaticKeepAliveClientMixin {
  SearchCollectionBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<SearchCollectionBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCollectionBloc, SearchCollectionState>(
      builder: (context, state) {
        return state.when(
          initial: () {
            //bloc.add(SearchCollectionEvent.refresh());
            return Container();
          },
          loading: () => LoadingWidget(),
          loadMore: () {
            return CollectionListWidget<SearchCollectionBloc>(
              collections: bloc.collectionSuccess.collections,
              hasLoadMore: true,
            );
          },
          error: (error) => LoadErrorWidget(
            error: error,
            clickCallback: () => bloc.add(SearchCollectionRefreshEvent()),
          ),
          success: (int pageNo, List<Collection> collections) =>
              CollectionListWidget<SearchCollectionBloc>(
                  collections: collections),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
