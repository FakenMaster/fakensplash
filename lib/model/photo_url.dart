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

  factory PhotoUrl.fromJson(Map<String, dynamic> json) => PhotoUrl(
    raw: json["raw"],
    full: json["full"],
    regular: json["regular"],
    small: json["small"],
    thumb: json["thumb"],
  );

  Map<String, dynamic> toJson() => {
    "raw": raw,
    "full": full,
    "regular": regular,
    "small": small,
    "thumb": thumb,
  };
}