import 'package:fakensplash/model/profile.dart';
import 'package:fakensplash/model/user_link.dart';

class User {
  String id;
  String username;
  String name;
  String portfolioUrl;
  String bio;
  String location;
  int totalLikes;
  int totalPhotos;
  int totalCollections;
  String instagramUsername;
  String twitterUsername;
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

  factory User.fromJson(Map<String, dynamic> json) => new User(
    id: json["id"],
    username: json["username"],
    name: json["name"],
    portfolioUrl: json["portfolio_url"],
    bio: json["bio"],
    location: json["location"],
    totalLikes: json["total_likes"],
    totalPhotos: json["total_photos"],
    totalCollections: json["total_collections"],
    instagramUsername: json["instagram_username"],
    twitterUsername: json["twitter_username"],
    profileImage: PhotoProfile.fromJson(json["profile_image"]),
    links: UserLink.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "name": name,
    "portfolio_url": portfolioUrl,
    "bio": bio,
    "location": location,
    "total_likes": totalLikes,
    "total_photos": totalPhotos,
    "total_collections": totalCollections,
    "instagram_username": instagramUsername,
    "twitter_username": twitterUsername,
    "profile_image": profileImage.toJson(),
    "links": links.toJson(),
  };
}
