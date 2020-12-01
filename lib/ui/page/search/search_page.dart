import 'package:fakensplash/bloc/search/collection/search_collection_bloc.dart';
import 'package:fakensplash/bloc/search/photo/search_photo_bloc.dart';
import 'package:fakensplash/bloc/search/user/search_user_bloc.dart';
import 'package:fakensplash/ui/page/search/search_collection_page.dart';
import 'package:fakensplash/ui/page/search/search_photo_page.dart';
import 'package:fakensplash/ui/page/search/search_user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => SearchPhotoBloc(),
        ),
        BlocProvider(
          create: (_) => SearchCollectionBloc(),
        ),
        BlocProvider(
          create: (_) => SearchUserBloc(),
        ),
      ],
      child: _SearchPage(),
    );
  }
}

class _SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<_SearchPage> {
  TextEditingController _editingController;
  PublishSubject<String> _subject;
  var _tabTitles = ['PHOTOS', 'COLLECTIONS', 'USERS'];

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController()
      ..addListener(() {
        _subject.add(_editingController.text);
      });
    _subject = PublishSubject<String>();
  }

  @override
  void dispose() {
    _editingController.dispose();
    _subject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _searchBar(),
      body: DefaultTabController(
        length: _tabTitles.length,
        child: Column(
          children: <Widget>[
            TabBar(
                labelPadding: EdgeInsets.all(0.0),
                tabs: _tabTitles.map((e) => Tab(text: e)).toList()),
            Expanded(
              child: TabBarView(children: [
                SearchPhotoPage(),
                SearchCollectionPage(),
                SearchUserPage(),
              ]),
            )
          ],
        ),
      ),
    );
  }

  AppBar _searchBar() {
    return AppBar(
      elevation: 0.0,
      titleSpacing: 0.0,
      title: TextField(
        controller: _editingController,
        autofocus: true,
        cursorColor: Colors.black,
        onSubmitted: query,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 20.0),
            hintText: 'Search',
            border: InputBorder.none,
            suffixIcon: StreamBuilder<Object>(
                stream: _subject,
                builder: (context, snapshot) {
                  return Visibility(
                    visible: _editingController.text.isNotEmpty,
                    child: GestureDetector(
                      onTap: () => _editingController.clear(),
                      child: Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                    ),
                  );
                })),
      ),
    );
  }

  void query(String query) {
    context.read<SearchPhotoBloc>().add(SearchPhotoEvent.refresh(query: query));
    context
        .read<SearchCollectionBloc>()
        .add(SearchCollectionEvent.refresh(query: query));

    context.read<SearchUserBloc>().add(SearchUserEvent.refresh(query: query));
  }
}
