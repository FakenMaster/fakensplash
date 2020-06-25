import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_exif.g.dart';

@JsonSerializable(explicitToJson: true)
class PhotoExif {
  PhotoExif({
    this.make,
    this.model,
    this.exposureTime,
    this.aperture,
    this.focalLength,
    this.iso,
  });

  String make;
  String model;
  @JsonKey(name: 'exposure_time')
  String exposureTime;
  String aperture;
  @JsonKey(name: 'focal_length')
  String focalLength;
  int iso;

  factory PhotoExif.fromJson(Map<String, dynamic> json) =>
      _$PhotoExifFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoExifToJson(this);
}
