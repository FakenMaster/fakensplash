import 'package:freezed_annotation/freezed_annotation.dart';

import '../model.dart';
part 'photo_search_result.g.dart';

@JsonSerializable()
class PhotoSearchResult {
  int total;
  @JsonKey(name:'total_pages')
  int totalPages;
  List<Photo> results;

  PhotoSearchResult({
    this.total,
    this.totalPages,
    this.results,
  });

  factory PhotoSearchResult.fromJson(Map<String, dynamic> json) =>
      _$PhotoSearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoSearchResultToJson(this);
}
