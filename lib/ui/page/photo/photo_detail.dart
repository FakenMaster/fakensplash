import 'package:fakensplash/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PhotoDetailPage extends StatefulWidget {
  @override
  _PhotoDetailPageState createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              actions: <Widget>[
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.globe),
                  onPressed: () {},
                ),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.share),
                  onPressed: () {},
                )
              ],
            )
          ];
        },
        body: Column(
          children: <Widget>[
            Hero(
              tag: context.watch<Photo>().id,
              child: Image.network(
                '${context.watch<Photo>().urls.regular}',
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.keyboard_arrow_up,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    );
  }
}
