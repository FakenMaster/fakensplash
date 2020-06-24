import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper_manager/wallpaper_manager.dart';

launchUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
    );
  } else {
    throw 'Could not launch $url';
  }
}

toast(String message) {
  showToastWidget(
    Container(
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.grey[700],
      ),
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
      child: Text(message),
    ),
    position: ToastPosition.bottom,
  );
}

setWallpaper(String url) async {
  toast('Setting wallpaper...');
  int location = WallpaperManager
      .HOME_SCREEN; // or location = WallpaperManager.LOCK_SCREEN;
  var file = await DefaultCacheManager().getSingleFile(url);
  final String result =
      await WallpaperManager.setWallpaperFromFile(file.path, location);
  toast(result);
}
