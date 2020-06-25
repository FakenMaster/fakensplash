import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_url.g.dart';

@JsonSerializable(explicitToJson: true)
class PhotoUrl {
  String raw;
  String full;
  String regular;
  String small;
  String thumb;

  PhotoUrl({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
  });

  factory PhotoUrl.fromJson(Map<String, dynamic> json) =>
      _$PhotoUrlFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoUrlToJson(this);
}
