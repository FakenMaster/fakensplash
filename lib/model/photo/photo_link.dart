import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_link.g.dart';

@JsonSerializable()
class PhotoLink {
  String self;
  String html;
  String download;
  @JsonKey(name:'download_location')
  String downloadLocation;

  PhotoLink({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  factory PhotoLink.fromJson(Map<String, dynamic> json) =>
      _$PhotoLinkFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoLinkToJson(this);
}
