import 'package:fakensplash/bloc/user_collection/user_collection_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/widget/load_error_widget.dart';
import 'package:fakensplash/ui/widget/loading_widget.dart';
import 'package:fakensplash/ui/widget/user_collection_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCollectionPage extends StatelessWidget {
  final String username;
  UserCollectionPage({@required this.username});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCollectionBloc>(
      create: (_) => UserCollectionBloc(username: username),
      child: _UserCollectionPage(),
    );
  }
}

class _UserCollectionPage extends StatefulWidget {
  @override
  _UserCollectionPageState createState() => _UserCollectionPageState();
}

class _UserCollectionPageState extends State<_UserCollectionPage>
    with AutomaticKeepAliveClientMixin {
  UserCollectionBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.bloc<UserCollectionBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCollectionBloc, UserCollectionState>(
      builder: (context, state) {
        return state.when(
          initial: () {
            bloc.add(UserCollectionEvent.refresh());
            return Container();
          },
          loading: () => LoadingWidget(),
          loadMore: () {
            return UserCollectionListWidget(
              collections: bloc.collectionSuccess.collections,
              hasLoadMore: true,
            );
          },
          error: (error) => LoadErrorWidget(
            error: error,
            clickCallback: () => bloc.add(UserCollectionRefreshEvent()),
          ),
          success: (int pageNo, List<Collection> collections) =>
              UserCollectionListWidget(collections: collections),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
