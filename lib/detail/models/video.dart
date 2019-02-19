class Video {
  final String id;
  final String title;
  final int displayOrder;
  final String description;
  final String fullDescription;
  final String iconUrl;
  final String background;
  final String details;
  final int isDark;
  final String streamSourceUrl;
  final List<Quotes> quotes;
  final String type;

  Video(
      {this.id,
      this.title,
      this.displayOrder,
      this.description,
      this.fullDescription,
      this.iconUrl,
      this.background,
      this.details,
      this.isDark,
      this.streamSourceUrl,
      this.quotes,
      this.type});

  Video.fromJson(Map<String, dynamic> json, List<Quotes> quotes)
      : id = json["id"] ?? "",
        title = json["attributes"]["title"] ?? "",
        displayOrder = json["attributes"]["displayOrder"] ?? 0,
        description = json["attributes"]["description"] ?? "",
        fullDescription = json["attributes"]["fullDescription"] ?? "",
        iconUrl = json["attributes"]["iconUrl"] ?? "",
        streamSourceUrl = json["attributes"]["streamSourceUrl"] ?? "",
        background = json["attributes"]["images"]["cover"]["background"]
                ["desktop"]["landscape"] ??
            "",
        details = json["attributes"]["images"]["cover"]["details"]["mobile"]
                ["portrait"] ??
            "",
        isDark = json["attributes"]["isDark"] ?? 0,
        quotes = quotes,
        type = json["type"] ?? "";

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "displayOrder": displayOrder,
        "description": description,
        "fullDescription": fullDescription,
        "iconUrl": iconUrl,
        "background": background,
        "details": details,
        "isDark": isDark,
        "streamSourceUrl": streamSourceUrl,
        "quotes": quotes,
        "type": type
      };
}

class Quotes {
  final String author;
  final String role;
  final String text;
  final String imageUrl;

  Quotes.fromJson(Map<String, dynamic> json)
      : author = json["attributes"]["author"] ?? "",
        role = json["attributes"]["role"] ?? "",
        text = json["attributes"]["text"] ?? "",
        imageUrl = json["attributes"]["imageUrl"] ?? "";

  Map<String, dynamic> toJson() =>
      {"author": author, "role": role, "text": text, "imageUrl": imageUrl};
}
