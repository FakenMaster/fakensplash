import 'package:fakensplash/bloc/collection/bloc/collection_bloc.dart';
import 'package:fakensplash/bloc/photo/photo_bloc.dart';
import 'package:fakensplash/ui/page/collection_page.dart';
import 'package:fakensplash/ui/page/photo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/subjects.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/repository.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  BehaviorSubject<bool> rotateSubject;

  @override
  void initState() {
    super.initState();
    GetIt.I.registerLazySingleton<Repository>(() => Repository());
    rotateSubject = BehaviorSubject.seeded(true);
  }

  @override
  void dispose() {
    rotateSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PhotoBloc(),
        ),
        BlocProvider(
          create: (_) => CollectionBloc(),
        )
      ],
      child: Scaffold(
        body: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
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
      ),
    );
  }

  Widget customScroll() {
    return CustomScrollView(
      slivers: [
        appBar(),
        tabTitle(),
        tabBarContent(),
      ],
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
        IconButton(
          icon: FaIcon(FontAwesomeIcons.alignLeft),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget tabTitle() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: HomeTitleTabHeader(
        TabBar(
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
    return TabBarView(children: [
      PhotoPage(
        key: PageStorageKey('home'),
      ),
      CollectionPage(
        key: PageStorageKey('collections'),
      ),
    ]);
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
