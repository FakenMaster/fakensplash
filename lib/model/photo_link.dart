class PhotoLink {
  String self;
  String html;
  String download;
  String downloadLocation;

  PhotoLink({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  factory PhotoLink.fromJson(Map<String, dynamic> json) => new PhotoLink(
    self: json["self"],
    html: json["html"],
    download: json["download"],
    downloadLocation: json["download_location"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "html": html,
    "download": download,
    "download_location": downloadLocation,
  };
}