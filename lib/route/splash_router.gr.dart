// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fakensplash/ui/page/main_page.dart';
import 'package:fakensplash/ui/page/collection/collection_detail.dart';
import 'package:fakensplash/ui/page/photo/photo_detail.dart';
import 'package:fakensplash/ui/page/photo/photo_preview.dart';
import 'package:fakensplash/ui/page/user/user_profile.dart';

abstract class Routes {
  static const mainPage = '/';
  static const collectionDetailPage = '/collection-detail-page';
  static const photoDetailPage = '/photo-detail-page';
  static const photoPreviewPage = '/photo-preview-page';
  static const userProfilePage = '/user-profile-page';
  static const all = {
    mainPage,
    collectionDetailPage,
    photoDetailPage,
    photoPreviewPage,
    userProfilePage,
  };
}

class SplashRouter extends RouterBase {
  @override
  Set<String> get allRoutes => Routes.all;

  @Deprecated('call ExtendedNavigator.ofRouter<Router>() directly')
  static ExtendedNavigatorState get navigator =>
      ExtendedNavigator.ofRouter<SplashRouter>();

  @override
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.mainPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => MainPage(),
          settings: settings,
        );
      case Routes.collectionDetailPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => CollectionDetailPage(),
          settings: settings,
        );
      case Routes.photoDetailPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => PhotoDetailPage(),
          settings: settings,
        );
      case Routes.photoPreviewPage:
        if (hasInvalidArgs<PhotoPreviewPageArguments>(args)) {
          return misTypedArgsRoute<PhotoPreviewPageArguments>(args);
        }
        final typedArgs =
            args as PhotoPreviewPageArguments ?? PhotoPreviewPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) =>
              PhotoPreviewPage(key: typedArgs.key, url: typedArgs.url),
          settings: settings,
        );
      case Routes.userProfilePage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => UserProfilePage(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// *************************************************************************
// Arguments holder classes
// **************************************************************************

//PhotoPreviewPage arguments holder class
class PhotoPreviewPageArguments {
  final Key key;
  final String url;
  PhotoPreviewPageArguments({this.key, this.url});
}

// *************************************************************************
// Navigation helper methods extension
// **************************************************************************

extension SplashRouterNavigationHelperMethods on ExtendedNavigatorState {
  Future pushMainPage() => pushNamed(Routes.mainPage);

  Future pushCollectionDetailPage() => pushNamed(Routes.collectionDetailPage);

  Future pushPhotoDetailPage() => pushNamed(Routes.photoDetailPage);

  Future pushPhotoPreviewPage({
    Key key,
    String url,
  }) =>
      pushNamed(
        Routes.photoPreviewPage,
        arguments: PhotoPreviewPageArguments(key: key, url: url),
      );

  Future pushUserProfilePage() => pushNamed(Routes.userProfilePage);
}
