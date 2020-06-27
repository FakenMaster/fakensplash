import 'package:dio/dio.dart';
import 'package:fakensplash/model/collection/collection_search_result.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/model/user/user_search_result.dart';
import 'package:fakensplash/repository/remote/auth_client.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

import 'remote/rest_client.dart';

class Repository {
  Repository() {
    GetIt.I.registerLazySingleton<RestClient>(() {
      print('执行RestClient初始化');
      Dio dio = Dio(BaseOptions(headers: {
        'Authorization':
            ' Client-ID QLB2RqZRZ6T0P6B4NF3OfjR8x5Fd8uW9U6qV-ra2uKY'
      }));

      return RestClient(dio);
    });

    GetIt.I.registerLazySingleton<AuthClient>(() {
      Dio dio = Dio();
      return AuthClient(dio);
    });
  }

  Future<List<Photo>> photos({int page = 1, String orderBy}) async {
    return GetIt.I<RestClient>()
        .photos(page: page ?? 1, orderBy: orderBy ?? 'latest');
  }

  Future<Photo> photoDetail(String id) async {
    return GetIt.I<RestClient>().photoDetail(id);
  }

  Future<PhotoStatistics> photoStatistics(String id) async {
    return GetIt.I<RestClient>().photoStatistics(id);
  }

  Future trackDownload(String id) async {
    GetIt.I<RestClient>().trackDownload(id);
  }

  Future<List<Collection>> collections(
      {int page = 1, bool featured = false}) async {
    if (featured) {
      return GetIt.I<RestClient>().featuredCollections(page: page);
    }
    return GetIt.I<RestClient>().collections(page: page);
  }

  Future<User> userProfile(String username) async {
    return GetIt.I<RestClient>().userProfile(username);
  }

  Future<List<Photo>> userPhotosWithLike(String username,
      {bool like = true, int page = 1}) async {
    return (like ?? true)
        ? likedPhotos(username, page: page ?? 1)
        : userPhotos(username, page: page ?? 1);
  }

  Future<List<Photo>> userPhotos(String username, {int page = 1}) async {
    return GetIt.I<RestClient>().userPhotos(username, page: page ?? 1);
  }

  Future<List<Photo>> likedPhotos(String username, {int page = 1}) async {
    return GetIt.I<RestClient>().likedPhotos(username, page: page ?? 1);
  }

  Future<List<Collection>> userCollections(String username,
      {int page = 1}) async {
    return GetIt.I<RestClient>().userCollections(username, page: page ?? 1);
  }

  Future<List<Photo>> collectionPhotos(int id, {int page = 1}) async {
    return getRestClient().collectionPhotos(id, page: page ?? 1);
  }

  Future<PhotoSearchResult> searchPhoto(
      {@required String query,
      @required int page,
      @required String orientation}) async {
    return getRestClient().searchPhoto(
      query,
      page: page ?? 1,
      orientation: orientation?.toLowerCase(),
    );
  }

  Future<CollectionSearchResult> searchCollection(
      {@required String query, @required int page}) {
    return getRestClient().searchCollection(query, page: page ?? 1);
  }

  Future<UserSearchResult> searchUser(
      {@required String query, @required int page}) {
    return getRestClient().searchUser(query, page: page ?? 1);
  }

  RestClient getRestClient() {
    return GetIt.I<RestClient>();
  }

  Future userAuthenticate() async {
    var data = await GetIt.I<AuthClient>().userAuth();
    print('认证数据：$data');
  }
}
