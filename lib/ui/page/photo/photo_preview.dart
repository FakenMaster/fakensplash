import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_view/photo_view.dart';

class PhotoPreviewPage extends StatefulWidget {
  final String url;

  PhotoPreviewPage({Key key, this.url}) : super(key: key);

  @override
  _PhotoPreviewPageState createState() => _PhotoPreviewPageState();
}

class _PhotoPreviewPageState extends State<PhotoPreviewPage> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: PhotoView(
        backgroundDecoration: BoxDecoration(
          color: Colors.grey[800],
        ),
        imageProvider: CachedNetworkImageProvider(widget.url),
        minScale: PhotoViewComputedScale.contained,
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}
