import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_link.g.dart';

@JsonSerializable()
class UserLink {
  String self;
  String html;
  String photos;
  String likes;
  String portfolio;

  UserLink({
    this.self,
    this.html,
    this.photos,
    this.likes,
    this.portfolio,
  });

  factory UserLink.fromJson(Map<String, dynamic> json) => _$UserLinkFromJson(json);

  Map<String, dynamic> toJson() => _$UserLinkToJson(this);
}
