import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_profile.g.dart';

@JsonSerializable()
class PhotoProfile {
  String small;
  String medium;
  String large;

  PhotoProfile({
    this.small,
    this.medium,
    this.large,
  });

  factory PhotoProfile.fromJson(Map<String, dynamic> json) =>
      _$PhotoProfileFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoProfileToJson(this);
}
