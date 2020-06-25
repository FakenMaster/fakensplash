import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:fakensplash/bloc/user_profile/user_profile_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/page/collection/user_collection_page.dart';
import 'package:fakensplash/ui/page/photo/user_photo_page.dart';
import 'package:fakensplash/ui/widget/loading_widget.dart';
import 'package:fakensplash/ui/widget/persistent_title_tab_bar.dart';
import 'package:fakensplash/util/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with TickerProviderStateMixin {
  var _tabs = ['PHOTOS', 'LIKES', 'COLLECTIONS'];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('用户数据:${context.watch<User>().toJson().toString()}');
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<UserProfileBloc, UserProfileState>(
          builder: (context, state) {
            User user;
            if (state is UserProfileInitial) {
              context.bloc<UserProfileBloc>().add(
                  UserProfileEvent.loadData(context.watch<User>().username));
            } else if (state is UserProfileSuccess) {
              user = state.userDetail;
              _tabs = [
                '${user.totalPhotos} PHOTOS',
                '${user.totalLikes} LIKES',
                '${user.totalCollections} COLLECTIONS'
              ];
            }
            return extended.NestedScrollView(
              pinnedHeaderSliverHeightBuilder: () => kTextTabBarHeight,
              innerScrollPositionKeyBuilder: () {
                return Key(_tabs[_tabController.index]);
              },
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  appBar(),
                  userDetail(user),
                  tabTitle(user),
                ];
              },
              body: user == null ? Container() : tabBarContent(user.username),
            );
          },
        ),
      ),
    );
  }

  Widget appBar() {
    return SliverAppBar(
      elevation: 0.0,
//      floating: true,
      title: Text(context.read<User>().name),
      actions: [
        IconButton(
          icon: Icon(
            Icons.public,
          ),
          onPressed: () {
            launchUrl(context.read<User>().links.html);
          },
        ),
      ],
    );
  }

  Widget userDetail(User user) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        //var user = context.watch<User>();
        //print('用户信息:${user.toJson().toString()}');
        return SliverPadding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            sliver: SliverToBoxAdapter(
              child: Column(children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 60.0,
                      height: 60.0,
                      margin: const EdgeInsets.only(right: 20.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                              user?.profileImage?.large ??
                                  context.watch<User>()?.profileImage?.large ??
                                  ''),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ConstrainedBox(
                        // height: 60.0,
                        constraints: BoxConstraints(
                          minHeight: 60.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: user == null
                              ? [
                                  LoadingWidget(
                                    center: false,
                                  ),
                                ]
                              : <Tuple2<IconData, String>>[
                                  if (user.location != null)
                                    Tuple2(Icons.location_on, user.location),
                                  if (user.portfolioUrl != null)
                                    Tuple2(Icons.public, user.portfolioUrl),
                                ].map((e) {
                                  bool isUrl = e.item1 == Icons.public;
                                  return GestureDetector(
                                    onTap:
                                        isUrl ? () => launchUrl(e.item2) : null,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      child: Row(
                                        children: <Widget>[
                                          Icon(
                                            e.item1,
                                            size: 18.0,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Expanded(
                                            child: Text(
                                              e.item2,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                decoration: isUrl
                                                    ? TextDecoration.underline
                                                    : TextDecoration.none,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    user?.bio ?? '',
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
            ));
      },
    );
  }

  Widget tabTitle(User user) {
    return user == null
        ? SliverPadding(
            padding: EdgeInsets.all(0.0),
          )
        : SliverPersistentHeader(
            pinned: true,
            delegate: TitleTabHeader(
              TabBar(
                controller: _tabController,
                labelStyle: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                unselectedLabelStyle: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                indicatorColor: Colors.black,
                tabs: _tabs.map((e) => Tab(text: e)).toList(),
              ),
            ),
          );
  }

  Widget tabBarContent(String username) {
    return TabBarView(
      controller: _tabController,
      children: [
        extended.NestedScrollViewInnerScrollPositionKeyWidget(
          Key(_tabs[0]),
          UserPhotoPage(
            username: username,
            like: false,
          ),
        ),
        extended.NestedScrollViewInnerScrollPositionKeyWidget(
          Key(_tabs[1]),
          UserPhotoPage(
            username: username,
            like: true,
          ),
        ),
        extended.NestedScrollViewInnerScrollPositionKeyWidget(
          Key(_tabs[1]),
          UserCollectionPage(
            username: username,
          ),
        ),
      ],
    );
  }
}
