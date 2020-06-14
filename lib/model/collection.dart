
import 'package:fakensplash/model/model.dart';

class Collection {
  int id;
  String title;
  String description;
  String publishedAt;
  String lastCollectedAt;
  String updatedAt;
  int totalPhotos;
  bool private;
  String shareKey;
  Photo coverPhoto;
  User user;
  UserLink links;

  Collection({
    this.id,
    this.title,
    this.description,
    this.publishedAt,
    this.lastCollectedAt,
    this.updatedAt,
    this.totalPhotos,
    this.private,
    this.shareKey,
    this.coverPhoto,
    this.user,
    this.links,
  });

  factory Collection.fromJson(Map<String, dynamic> json) => new Collection(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    publishedAt: json["published_at"],
    lastCollectedAt: json["last_collected_at"],
    updatedAt: json["updated_at"],
    totalPhotos: json["total_photos"],
    private: json["private"],
    shareKey: json["share_key"],
    coverPhoto: Photo.fromJson(json["cover_photo"]),
    user: User.fromJson(json["user"]),
    links: UserLink.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "published_at": publishedAt,
    "last_collected_at": lastCollectedAt,
    "updated_at": updatedAt,
    "total_photos": totalPhotos,
    "private": private,
    "share_key": shareKey,
    "cover_photo": coverPhoto.toJson(),
    "user": user.toJson(),
    "links": links.toJson(),
  };

  @override
  String toString() {
      return toJson().toString();
  }
}


