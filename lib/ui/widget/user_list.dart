import 'package:cached_network_image/cached_network_image.dart';
import 'package:fakensplash/bloc/search/user/search_user_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/page/user/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListWidget extends StatelessWidget {
  final List<User> users;
  final bool hasLoadMore;

  UserListWidget({Key key, @required this.users, this.hasLoadMore = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification.metrics.pixels ==
            notification.metrics.maxScrollExtent) {
          context.bloc<SearchUserBloc>().loadMore();
          return true;
        }
        return false;
      },
      child: ListView.builder(
        key: PageStorageKey('Users'),
        itemBuilder: (context, index) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              toUserProfile(context, users[index]);
            },
            child: itemWidget(index, context),
          );
        },
        itemCount: users.length + 1,
      ),
    );
  }

  Widget itemWidget(int index, BuildContext context) {
    if (index == users.length) {
      if (hasLoadMore) {
        return Center(
          child: Container(
            width: 50,
            height: 50,
            padding: EdgeInsets.all(10),
            child: CircularProgressIndicator(),
          ),
        );
      }
      return SizedBox();
    }
    var user = users[index];
    return ListTile(
      leading: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: CachedNetworkImageProvider(
              user.profileImage.medium,
            ))),
      ),
      title: Text(user.name),
      subtitle: Text('@${user.username}'),
    );
  }
}
