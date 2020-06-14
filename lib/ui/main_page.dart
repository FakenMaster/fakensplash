import 'package:fakensplash/ui/collection_page.dart';
import 'package:fakensplash/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rxdart/subjects.dart';
import 'package:time/time.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  BehaviorSubject<bool> rotateSubject;

  @override
  void initState() {
    super.initState();
    rotateSubject = BehaviorSubject.seeded(true);
  }

  @override
  void dispose() {
    rotateSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: CustomScrollView(
            slivers: [
              appBar(),
              tabTitle(),
              tabBarContent(),
            ],
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
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          indicatorColor: Colors.black,
          tabs: [
            Tab(text: 'Home'),
            Tab(text: 'Collection'),
          ],
        ),
      ),
    );
  }

  Widget tabBarContent() {
    return SliverFillRemaining(
      child: TabBarView(children: [
        HomePage(),
        CollectionPage(),
      ]),
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
