
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl:'https://api.unsplash.com')
abstract class RestClient {
  factory RestClient(Dio dio,{String baseUrl}) = _RestClient;
}

