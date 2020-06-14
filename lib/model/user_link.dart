class UserLink {
  String self;
  String html;
  String photos;
  String likes;
  String portfolio;

  UserLink({
    this.self,
    this.html,
    this.photos,
    this.likes,
    this.portfolio,
  });

  factory UserLink.fromJson(Map<String, dynamic> json) => new UserLink(
    self: json["self"],
    html: json["html"],
    photos: json["photos"],
    likes: json["likes"],
    portfolio: json["portfolio"],
  );

  Map<String, dynamic> toJson() => {
    "self": self,
    "html": html,
    "photos": photos,
    "likes": likes,
    "portfolio": portfolio,
  };
}