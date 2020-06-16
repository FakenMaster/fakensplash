import 'package:fakensplash/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'photo.g.dart';

@JsonSerializable()
class Photo {
  Photo({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.width,
    this.height,
    this.color,
    this.downloads,
    this.likes,
    this.likedByUser,
    this.description,
    this.exif,
    this.location,
    this.tags,
    this.currentUserCollections,
    this.urls,
    this.links,
    this.user,
  });

  String id;
  @JsonKey(name:'created_at')
  DateTime createdAt;
  @JsonKey(name:'updated_at')
  DateTime updatedAt;
  int width;
  int height;
  String color;
  int downloads;
  int likes;
  @JsonKey(name:'liked_by_user')
  bool likedByUser;
  String description;
  PhotoExif exif;
  Location location;
  List<Tag> tags;
  @JsonKey(name: 'current_user_collections')
  List<Collection> currentUserCollections;
  PhotoUrl urls;
  PhotoLink links;
  User user;

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);
  

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
  
}
