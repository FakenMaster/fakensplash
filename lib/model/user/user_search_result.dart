import 'package:freezed_annotation/freezed_annotation.dart';

import '../model.dart';

part 'user_search_result.g.dart';

@JsonSerializable(explicitToJson: true)
class UserSearchResult {
  int total;
  @JsonKey(name: 'total_pages')
  int totalPages;
  List<User> results;

  UserSearchResult({
    this.total,
    this.totalPages,
    this.results,
  });

  factory UserSearchResult.fromJson(Map<String, dynamic> json) =>
      _$UserSearchResultFromJson(json);

  Map<String, dynamic> toJson() => _$UserSearchResultToJson(this);
}
