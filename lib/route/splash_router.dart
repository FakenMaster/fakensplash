import 'package:auto_route/auto_route_annotations.dart';
import 'package:fakensplash/ui/page/collection/collection_detail.dart';
import 'package:fakensplash/ui/page/main_page.dart';
import 'package:fakensplash/ui/page/photo/photo_detail.dart';

@MaterialAutoRouter(generateNavigationHelperExtension: true)
class $SplashRouter {
  @initial
  MainPage mainPage;

  CollectionDetailPage collectionDetailPage;
  PhotoDetailPage photoDetailPage;
}
