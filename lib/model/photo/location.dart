import 'package:fakensplash/model/model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'location.g.dart';

@JsonSerializable(explicitToJson: true)
class Location {
  Location({
    this.city,
    this.country,
    this.position,
  });

  String city;
  String country;
  Position position;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
