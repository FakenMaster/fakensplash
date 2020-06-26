import 'package:freezed_annotation/freezed_annotation.dart';

import '../model.dart';

part 'collection_search_result.g.dart';

@JsonSerializable(explicitToJson: true)
class CollectionSearchResult {
  int total;
  @JsonKey(name: 'total_pages')
  int totalPages;
  List<Collection> results;

  CollectionSearchResult({
    this.total,
    this.totalPages,
    this.results,
  });

  factory CollectionSearchResult.fromJson(Map<String, dynamic> json) =>
      _$CollectionSearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionSearchResultToJson(this);
}
