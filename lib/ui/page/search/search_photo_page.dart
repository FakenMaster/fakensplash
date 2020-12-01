import 'package:fakensplash/bloc/search/photo/search_photo_bloc.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/ui/widget/load_error_widget.dart';
import 'package:fakensplash/ui/widget/loading_widget.dart';
import 'package:fakensplash/ui/widget/search_photo_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPhotoPage extends StatefulWidget {
  @override
  _SearchPhotoPageState createState() => _SearchPhotoPageState();
}

class _SearchPhotoPageState extends State<SearchPhotoPage>
    with AutomaticKeepAliveClientMixin {
  SearchPhotoBloc bloc;
  int _orientationIndex;
  List<String> _menuTitles = ['All', 'Landscape', 'Portrait', 'Squarish'];

  @override
  void initState() {
    super.initState();
    _orientationIndex = 0;
    bloc = context.read<SearchPhotoBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
          elevation: 2.0,
          color: Colors.white,
          child: PopupMenuButton<int>(
            tooltip: 'orientation',
            child: Container(
              height: kTextTabBarHeight,
              padding: EdgeInsets.only(left: 30.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _menuTitles[_orientationIndex],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
            onSelected: (int value) {
              setState(() {
                _orientationIndex = value;
                bloc.add(SearchPhotoEvent.refresh(
                    orientation:
                        value == 0 ? null : _menuTitles[_orientationIndex]));
              });
            },
            itemBuilder: (_) => _menuTitles
                .asMap()
                .keys
                .map((index) => PopupMenuItem(
                      child: Container(
                        width: double.infinity,
                        child: Text(_menuTitles[index]),
                      ),
                      value: index,
                    ))
                .toList(),
          ),
        ),
        Expanded(
          child: BlocBuilder<SearchPhotoBloc, SearchPhotoState>(
            builder: (context, state) {
              return state.when(
                initial: () {
                  return Container();
                },
                loading: () => LoadingWidget(),
                loadMore: () {
                  return SearchPhotoListWidget(
                    photos: bloc.photoSuccess.photos,
                    hasLoadMore: true,
                  );
                },
                error: (error) => LoadErrorWidget(
                  error: error,
                  clickCallback: () => bloc.add(SearchPhotoRefreshEvent()),
                ),
                success: (int pageNo, List<Photo> photos) =>
                    SearchPhotoListWidget(
                  photos: photos,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
