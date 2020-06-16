import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;
import 'package:fakensplash/bloc/collection/collection_bloc.dart';
import 'package:fakensplash/bloc/photo/photo_bloc.dart';
import 'package:fakensplash/ui/page/collection/collection_page.dart';
import 'package:fakensplash/ui/page/photo/photo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/subjects.dart';
import 'package:tuple/tuple.dart';

import '../../repository/repository.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  BehaviorSubject<bool> rotateSubject;

  TabController tabController;
  var _tabs = ['Home', 'Collections'];
  final photoMenuData = [
    Tuple2<IconData, String>(FontAwesomeIcons.chartLine, 'Latest'),
    Tuple2<IconData, String>(FontAwesomeIcons.history, 'Oldest'),
    Tuple2<IconData, String>(FontAwesomeIcons.fireAlt, 'Popular'),
  ];

  final collectionMenuData = [
    Tuple2<IconData, String>(FontAwesomeIcons.feather, 'All'),
    Tuple2<IconData, String>(FontAwesomeIcons.medal, 'Featureed'),
  ];
  @override
  void initState() {
    super.initState();
    GetIt.I.registerLazySingleton<Repository>(() => Repository());
    tabController = TabController(length: 2, vsync: this);
    rotateSubject = BehaviorSubject.seeded(true);
  }

  @override
  void dispose() {
    rotateSubject.close();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: extended.NestedScrollView(
            pinnedHeaderSliverHeightBuilder: () => kTextTabBarHeight,
            innerScrollPositionKeyBuilder: () {
              return Key(_tabs[tabController.index]);
            },
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                appBar(),
                tabTitle(),
              ];
            },
            body: tabBarContent(),
          ),
        ),
      ),
      drawer: drawer(),
    );
  }

  Widget appBar() {
    return SliverAppBar(
      elevation: 0.0,
      floating: true,
      title: Text('FaKenSplash'),
      actions: [
        IconButton(
          icon: Icon(
            Icons.search,
          ),
          onPressed: () {},
        ),
        popupMenu(),
      ],
    );
  }

  Widget popupMenu() {
    return PopupMenuButton(
      onSelected: (int index) {
        tabController.index == 0
            ? context.bloc<PhotoBloc>().add(PhotoEvent.refresh(
                orderBy: photoMenuData[index].item2.toLowerCase()))
            : context
                .bloc<CollectionBloc>()
                .add(CollectionEvent.refresh(featured: index == 1));
      },
      icon: Icon(Icons.format_align_left),
      itemBuilder: (context) =>
          (tabController.index == 0 ? photoMenuData : collectionMenuData)
              .asMap()
              .entries
              .map((MapEntry entry) {
        int key = entry.key;
        Tuple2 item = entry.value;
        return PopupMenuItem<int>(
          value: key,
          child: Row(
            children: <Widget>[
              Container(
                width: 20.0,
                margin: EdgeInsets.only(right: 16.0),
                alignment: Alignment.center,
                child: FaIcon(
                  item.item1,
                  size: 20.0,
                ),
              ),
              SizedBox(
                width: 16.0,
              ),
              Text(item.item2),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget tabTitle() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: HomeTitleTabHeader(
        TabBar(
          controller: tabController,
          labelStyle: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Raleway',
            fontSize: 17,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          indicatorColor: Colors.black,
          tabs: [
            Tab(text: 'Home'),
            Tab(text: 'Collections'),
          ],
        ),
      ),
    );
  }

  Widget tabBarContent() {
    return TabBarView(
      controller: tabController,
      children: [
        extended.NestedScrollViewInnerScrollPositionKeyWidget(
          Key(_tabs[0]),
          extended.NestedScrollViewRefreshIndicator(
            onRefresh: () async {
              context.bloc<PhotoBloc>().add(PhotoRefreshEvent());
            },
            child: PhotoPage(),
          ),
        ),
        extended.NestedScrollViewInnerScrollPositionKeyWidget(
          Key(_tabs[1]),
          extended.NestedScrollViewRefreshIndicator(
            onRefresh: () async {
              context.bloc<CollectionBloc>().add(CollectionRefreshEvent());
            },
            child: CollectionPage(),
          ),
        ),
      ],
    );
  }

  Widget drawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                rotateSubject.add(!(rotateSubject.value ?? true));
              },
              child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.userCircle,
                        size: 50.0,
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        'FaKenSplash',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(
                        height: 2.0,
                      ),
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Free high-resolution photos'),
                            StreamBuilder<Object>(
                                stream: rotateSubject,
                                builder: (context, snapshot) {
                                  print('数据:${snapshot.data}');
                                  return Icon(snapshot.data ?? true
                                      ? Icons.arrow_drop_down
                                      : Icons.arrow_drop_up);
                                }),
                          ],
                        ),
                      )
                    ],
                  )),
            ),
            Divider(
              height: 1.0,
              thickness: 1.0,
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTitleTabHeader extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  HomeTitleTabHeader(this.tabBar);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.white, child: tabBar);
  }

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
