import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_client.g.dart';

@RestApi(baseUrl: 'https://unsplash.com')
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _AuthClient;

  @GET('/oauth/authorize')
  Future userAuth({
    @Query('client_id')
        String clientId = 'QLB2RqZRZ6T0P6B4NF3OfjR8x5Fd8uW9U6qV-ra2uKY',
    @Query('redirect_url') String redirectUrl = 'https://www.baidu.com',
    @Query('response_type') String responseType = 'code',
    @Query('scope') String scope,
  });
}
