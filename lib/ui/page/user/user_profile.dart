import 'package:fakensplash/bloc/user_profile/user_profile_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/widget/persistent_title_tab_bar.dart';
import 'package:fakensplash/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
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
      body: extended.NestedScrollView(
        pinnedHeaderSliverHeightBuilder: () => kTextTabBarHeight,
        innerScrollPositionKeyBuilder: () {
          return Key(_tabs[_tabController.index]);
        },
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            appBar(),
            userDetail(),
            tabTitle(),
          ];
        },
        body: tabBarContent(),
      ),
    );
  }

  Widget appBar() {
    return SliverAppBar(
      elevation: 0.0,
      floating: true,
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

  Widget userDetail() {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        var user = context.watch<User>();
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
                            image: NetworkImage(
                              context.select(
                                  (User user) => user.profileImage.large),
                            ),
                          )),
                    ),
                    Expanded(
                      child: Container(
                        height: 60.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Tuple2<IconData, String>>[
                            if (user.location != null)
                              Tuple2(Icons.location_on, user.location),
                            if (user.portfolioUrl != null)
                              Tuple2(Icons.public, user.portfolioUrl),
                          ].map((e) {
                            return GestureDetector(
                              onTap: () {
                                launchUrl(e.item2);
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
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
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
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
              ]),
            ));
      },
    );
  }

  Widget tabTitle() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: TitleTabHeader(
        TabBar(
          controller: _tabController,
          labelStyle: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          indicatorColor: Colors.black,
          tabs: _tabs.map((e) => Tab(text: e)).toList(),
        ),
      ),
    );
  }

  Widget tabBarContent() {
    return TabBarView(
      controller: _tabController,
      children: [
        extended.NestedScrollViewInnerScrollPositionKeyWidget(
          Key(_tabs[0]),
          extended.NestedScrollViewRefreshIndicator(
            onRefresh: () async {
              //context.bloc<PhotoBloc>().add(PhotoRefreshEvent());
            },
            child: Text('test'),
          ),
        ),
        extended.NestedScrollViewInnerScrollPositionKeyWidget(
          Key(_tabs[1]),
          extended.NestedScrollViewRefreshIndicator(
            onRefresh: () async {
              //context.bloc<CollectionBloc>().add(CollectionRefreshEvent());
            },
            child: Text('test2'),
          ),
        ),
        extended.NestedScrollViewInnerScrollPositionKeyWidget(
          Key(_tabs[1]),
          extended.NestedScrollViewRefreshIndicator(
            onRefresh: () async {
              //context.bloc<CollectionBloc>().add(CollectionRefreshEvent());
            },
            child: Text('test3'),
          ),
        ),
      ],
    );
  }
}
