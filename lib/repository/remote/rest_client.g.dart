// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rest_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestClient implements RestClient {
  _RestClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    this.baseUrl ??= 'https://api.unsplash.com';
  }

  final Dio _dio;

  String baseUrl;

  @override
  photos({page = 1, perPage = 10, orderBy = 'latest'}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'per_page': perPage,
      r'order_by': orderBy
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/photos',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Photo.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  photoDetail(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/photos/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Photo.fromJson(_result.data);
    return value;
  }

  @override
  photoStatistics(id, {resolution = 'days', quantity = 30}) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'resolution': resolution,
      r'quantity': quantity
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/photos/$id/statistics',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = PhotoStatistics.fromJson(_result.data);
    return value;
  }

  @override
  trackDownload(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/photos/$id/download',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Photo.fromJson(_result.data);
    return value;
  }

  @override
  searchPhoto(query,
      {page,
      perPage,
      orderBy,
      collectionIds,
      contentFilter = 'high',
      color,
      orientation}) async {
    ArgumentError.checkNotNull(query, 'query');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'query': query,
      r'page': page,
      r'per_page': perPage,
      r'order_by': orderBy,
      r'collections': collectionIds,
      r'content_filter': contentFilter,
      r'color': color,
      r'orientation': orientation
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/search/photos',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = PhotoSearchResult.fromJson(_result.data);
    return value;
  }

  @override
  collections({page = 1, perPage = 10}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'per_page': perPage
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request('/collections',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Collection.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  collectionDetail(id) async {
    ArgumentError.checkNotNull(id, 'id');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        '/collections/$id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = Collection.fromJson(_result.data);
    return value;
  }

  @override
  featuredCollections({page = 1, perPage = 10}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'per_page': perPage
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request(
        '/collections/featured',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Collection.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  userPhotos(
      {username,
      page = 1,
      perPage = 30,
      orderBy = 'latest',
      stats = false,
      resolution = 'days',
      quantity = 30,
      orientation = ''}) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'page': page,
      r'per_page': perPage,
      r'order_by': orderBy,
      r'stats': stats,
      r'resolution': resolution,
      r'quantity': quantity,
      r'orientation': orientation
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final Response<List<dynamic>> _result = await _dio.request(
        '/users/$username/photos',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Photo.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
