import 'package:freezed_annotation/freezed_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {
  Tag({
    this.title,
  });

  String title;

  factory Tag.fromJson(Map<String, dynamic> json) => _$TagFromJson(json);

  Map<String, dynamic> toJson() => _$TagToJson(this);
}
