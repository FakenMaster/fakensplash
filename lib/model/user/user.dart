import 'package:freezed_annotation/freezed_annotation.dart';

import '../model.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  String id;
  String username;
  String name;
  @JsonKey(name: 'portfolio_url')
  String portfolioUrl;
  String bio;
  String location;
  @JsonKey(name: 'total_likes')
  int totalLikes;
  @JsonKey(name: 'total_photos')
  int totalPhotos;
  @JsonKey(name: 'total_collections')
  int totalCollections;
  @JsonKey(name: 'instagram_username')
  String instagramUsername;
  @JsonKey(name: 'twitter_username')
  String twitterUsername;
  @JsonKey(name: 'profile_image')
  PhotoProfile profileImage;
  UserLink links;

  User({
    this.id,
    this.username,
    this.name,
    this.portfolioUrl,
    this.bio,
    this.location,
    this.totalLikes,
    this.totalPhotos,
    this.totalCollections,
    this.instagramUsername,
    this.twitterUsername,
    this.profileImage,
    this.links,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
