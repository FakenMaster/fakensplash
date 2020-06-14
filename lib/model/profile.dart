class PhotoProfile {
  String small;
  String medium;
  String large;

  PhotoProfile({
    this.small,
    this.medium,
    this.large,
  });

  factory PhotoProfile.fromJson(Map<String, dynamic> json) => new PhotoProfile(
    small: json["small"],
    medium: json["medium"],
    large: json["large"],
  );

  Map<String, dynamic> toJson() => {
    "small": small,
    "medium": medium,
    "large": large,
  };
}