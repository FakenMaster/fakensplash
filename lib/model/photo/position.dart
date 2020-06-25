import 'package:freezed_annotation/freezed_annotation.dart';

part 'position.g.dart';

@JsonSerializable(explicitToJson: true)
class Position {
  Position({
    this.latitude,
    this.longitude,
  });

  double latitude;
  double longitude;

  factory Position.fromJson(Map<String, dynamic> json) =>
      _$PositionFromJson(json);

  Map<String, dynamic> toJson() => _$PositionToJson(this);
}
