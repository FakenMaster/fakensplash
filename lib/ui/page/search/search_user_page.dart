import 'package:fakensplash/bloc/search/user/search_user_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/widget/load_error_widget.dart';
import 'package:fakensplash/ui/widget/loading_widget.dart';
import 'package:fakensplash/ui/widget/user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchUserPage extends StatefulWidget {
  @override
  _SearchUserPageState createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage>
    with AutomaticKeepAliveClientMixin {
  SearchUserBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<SearchUserBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchUserBloc, SearchUserState>(
      builder: (context, state) {
        return state.when(
          initial: () {
            return Container();
          },
          loading: () => LoadingWidget(),
          loadMore: () {
            return UserListWidget(
              users: bloc.userSuccess.users,
              hasLoadMore: true,
            );
          },
          error: (error) => LoadErrorWidget(
            error: error,
            clickCallback: () => bloc.add(SearchUserRefreshEvent()),
          ),
          success: (int pageNo, List<User> users) =>
              UserListWidget(users: users),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
