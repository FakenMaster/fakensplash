import 'package:fakensplash/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'collection.g.dart';

@JsonSerializable(explicitToJson: true)
class Collection {
  int id;
  String title;
  String description;
  @JsonKey(name: 'published_at')
  DateTime publishedAt;
  @JsonKey(name: 'last_collected_at')
  DateTime lastCollectedAt;
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;
  bool featured;
  @JsonKey(name: 'total_photos')
  int totalPhotos;
  bool private;
  @JsonKey(name: 'share_key')
  String shareKey;
  @JsonKey(name: 'cover_photo')
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
    this.featured,
    this.totalPhotos,
    this.private,
    this.shareKey,
    this.coverPhoto,
    this.user,
    this.links,
  });

  factory Collection.fromJson(Map<String, dynamic> json) =>
      _$CollectionFromJson(json);

  Map<String, dynamic> toJson() => _$CollectionToJson(this);
  @override
  String toString() {
    return toJson().toString();
  }
}
