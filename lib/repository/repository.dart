import 'package:dio/dio.dart';
import 'package:fakensplash/model/model.dart';
import 'package:fakensplash/model/photo.dart';
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
  }

  Future<List<Photo>> photos({int page = 1}) async {
    return GetIt.I<RestClient>().photos(page: page);
  }

  Future<List<Collection>> collections({int page = 1}) async {
    return GetIt.I<RestClient>().collections(page: page);
  }
}
