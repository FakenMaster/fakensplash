// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fakensplash/ui/page/main_page.dart';
import 'package:fakensplash/ui/page/collection/collection_detail.dart';
import 'package:fakensplash/model/collection/collection.dart';
import 'package:fakensplash/ui/page/photo/photo_detail.dart';
import 'package:fakensplash/ui/page/photo/photo_preview.dart';
import 'package:fakensplash/ui/page/user/user_profile.dart';
import 'package:fakensplash/ui/page/search/search_page.dart';

abstract class Routes {
  static const mainPage = '/';
  static const collectionDetailPage = '/collection-detail-page';
  static const photoDetailPage = '/photo-detail-page';
  static const photoPreviewPage = '/photo-preview-page';
  static const userProfilePage = '/user-profile-page';
  static const searchPage = '/search-page';
  static const all = {
    mainPage,
    collectionDetailPage,
    photoDetailPage,
    photoPreviewPage,
    userProfilePage,
    searchPage,
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
        if (hasInvalidArgs<CollectionDetailPageArguments>(args)) {
          return misTypedArgsRoute<CollectionDetailPageArguments>(args);
        }
        final typedArgs = args as CollectionDetailPageArguments ??
            CollectionDetailPageArguments();
        return MaterialPageRoute<dynamic>(
          builder: (context) => CollectionDetailPage(
              key: typedArgs.key, collection: typedArgs.collection),
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
      case Routes.searchPage:
        return MaterialPageRoute<dynamic>(
          builder: (context) => SearchPage(),
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

//CollectionDetailPage arguments holder class
class CollectionDetailPageArguments {
  final Key key;
  final Collection collection;
  CollectionDetailPageArguments({this.key, this.collection});
}

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

  Future pushCollectionDetailPage({
    Key key,
    Collection collection,
  }) =>
      pushNamed(
        Routes.collectionDetailPage,
        arguments:
            CollectionDetailPageArguments(key: key, collection: collection),
      );

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

  Future pushSearchPage() => pushNamed(Routes.searchPage);
}
