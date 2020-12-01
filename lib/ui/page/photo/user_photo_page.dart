import 'package:fakensplash/bloc/user_photo/user_photo_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/widget/load_error_widget.dart';
import 'package:fakensplash/ui/widget/loading_widget.dart';
import 'package:fakensplash/ui/widget/user_photo_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPhotoPage extends StatelessWidget {
  final String username;
  final bool like;

  UserPhotoPage({Key key, this.username, this.like}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserPhotoBloc>(
      create: (_) => UserPhotoBloc(username: username, like: like),
      child: _UserPhotoPage(),
    );
  }
}

class _UserPhotoPage extends StatefulWidget {
  @override
  _UserPhotoPageState createState() => _UserPhotoPageState();
}

class _UserPhotoPageState extends State<_UserPhotoPage>
    with AutomaticKeepAliveClientMixin {
  UserPhotoBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<UserPhotoBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserPhotoBloc, UserPhotoState>(
      builder: (context, state) {
        return state.when(
          initial: () {
            bloc.add(UserPhotoEvent.refresh());
            return Container();
          },
          loading: () => LoadingWidget(),
          loadMore: () {
            return UserPhotoListWidget(
              photos: bloc.photoSuccess.photos,
              hasLoadMore: true,
            );
          },
          error: (error) => LoadErrorWidget(
              error: error,
              clickCallback: () => bloc.add(
                    UserPhotoRefreshEvent(),
                  )),
          success: (int page, List<Photo> photos) => UserPhotoListWidget(
            photos: photos,
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
