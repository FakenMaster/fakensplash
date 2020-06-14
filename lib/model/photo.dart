import 'package:fakensplash/model/model.dart';

class Photo {
  String id;
  String createdAt;
  String updatedAt;
  int width;
  int height;
  String color;
  int likes;
  bool likedByUser;
  String description;
  User user;
  List<Collection> currentUserCollections;
  PhotoUrl urls;
  PhotoLink links;

  Photo({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.width,
    this.height,
    this.color,
    this.likes,
    this.likedByUser,
    this.description,
    this.user,
    this.currentUserCollections,
    this.urls,
    this.links,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => new Photo(
    id: json["id"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    width: json["width"],
    height: json["height"],
    color: json["color"],
    likes: json["likes"],
    likedByUser: json["liked_by_user"],
    description: json["description"],
    user: User.fromJson(json["user"]),
    currentUserCollections: new List<Collection>.from(json["current_user_collections"].map((x) => Collection.fromJson(x))),
    urls: PhotoUrl.fromJson(json["urls"]),
    links: PhotoLink.fromJson(json["links"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "width": width,
    "height": height,
    "color": color,
    "likes": likes,
    "liked_by_user": likedByUser,
    "description": description,
    "user": user.toJson(),
    "current_user_collections": List<dynamic>.from(currentUserCollections.map((x) => x.toJson())),
    "urls": urls.toJson(),
    "links": links.toJson(),
  };
}









