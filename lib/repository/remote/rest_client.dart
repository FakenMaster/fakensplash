import 'package:dio/dio.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/model/photo.dart';
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

  @GET('/collections')
  Future<List<Collection>> collections({
    @Query('page') int page = 1,
    @Query('per_page') int perPage = 10,
  });
}
