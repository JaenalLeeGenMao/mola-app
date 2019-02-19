class Video {
  final String id;
  final String title;
  final String imageUrl;

  Video.fromJson(Map<String, dynamic> json)
      : id = json["id"] ?? "",
        title = json["attributes"]["title"] ?? "",
        imageUrl = json["attributes"]["images"]["cover"]["library"]["desktop"]
                ["portrait"] ??
            "";

  Map<String, dynamic> toJson() =>
      {"id": id, "title": title, "imageUrl": imageUrl};
}
