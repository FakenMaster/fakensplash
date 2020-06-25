import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_statistics.g.dart';

@JsonSerializable(explicitToJson: true)
class PhotoStatistics {
  String id;
  Data downloads;
  Data views;
  Data likes;

  PhotoStatistics({
    this.id,
    this.downloads,
    this.views,
    this.likes,
  });

  factory PhotoStatistics.fromJson(Map<String, dynamic> json) =>
      _$PhotoStatisticsFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoStatisticsToJson(this);
}

@JsonSerializable()
class Data {
  int total;
  History historical;

  Data({
    this.total,
    this.historical,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}

@JsonSerializable()
class History {
  int change;
  String resolution;
  int quantity;
  List<DateAndValue> values;

  History({
    this.change,
    this.resolution,
    this.quantity,
    this.values,
  });

  factory History.fromJson(Map<String, dynamic> json) =>
      _$HistoryFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryToJson(this);
}

@JsonSerializable()
class DateAndValue {
  String date;
  int value;

  DateAndValue({
    this.date,
    this.value,
  });

  factory DateAndValue.fromJson(Map<String, dynamic> json) =>
      _$DateAndValueFromJson(json);

  Map<String, dynamic> toJson() => _$DateAndValueToJson(this);
}
