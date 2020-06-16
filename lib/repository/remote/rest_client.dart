import 'package:dio/dio.dart';
import 'package:fakensplash/model/model.dart';
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: 'https://api.unsplash.com')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/photos')
  Future<List<Photo>> photos({
    @Query('page') int page = 1,
    @Query('per_page') int perPage = 10,
    @Query('order_by') String orderBy = 'latest',
  });
  @GET('/photos/{id}')
  Future<Photo> photoDetail(@Path('id') String id);

  @GET('/phtos/{id}/statistics')
  Future<Photo> photoStatistics(
    @Path('id') String id, {
    @Query('resolution') String resolution = 'days',
    @Query('quantity') int quantity = 30,
  });

  @GET('/photos/{id}/download')
  Future<Photo> trackDownload(@Path('id') String id);

  @GET('/search/photos')
  Future<PhotoSearchResult> searchPhoto(
    @Query('query') String query, {
    @Query('page') int page,
    @Query('per_page') int perPage,
    @Query('order_by') String orderBy,
    @Query('collections') String collectionIds,
    @Query('content_filter') String contentFilter = 'high',
    // black_and_white, black, white, yellow, orange, red, purple, magenta, green, teal, blue
    @Query('color') String color,
    // landscape,portrait,squarish
    @Query('orientation') String orientation,
  });

  @GET('/collections')
  Future<List<Collection>> collections({
    @Query('page') int page = 1,
    @Query('per_page') int perPage = 10,
  });

  @GET('/collections/{id}')
  Future<Collection> collectionDetail(@Path('id') String id);

  @GET('/collections/featured')
  Future<List<Collection>> featuredCollections({
    @Query('page') int page = 1,
    @Query('per_page') int perPage = 10,
  });
}
