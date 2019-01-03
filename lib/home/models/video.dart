class Video {
  final String id;
  final String title;
  final int displayOrder;
  final String description;
  final String shortDescription;
  final String iconUrl;
  final String background;
  final String details;
  final int isDark;
  final List<Quotes> quotes;
  final String type;

  Video(
      {this.id,
      this.title,
      this.displayOrder,
      this.description,
      this.shortDescription,
      this.iconUrl,
      this.background,
      this.details,
      this.isDark,
      this.quotes,
      this.type});

  Video.fromJson(Map<String, dynamic> json, List<Quotes> quotes)
      : id = json["id"],
        title = json["attributes"]["title"],
        displayOrder = json["attributes"]["displayOrder"],
        description = json["attributes"]["description"],
        shortDescription = json["attributes"]["shortDescription"],
        iconUrl = json["attributes"]["iconUrl"],
        background = json["attributes"]["images"]["cover"]["background"]
            ["mobile"]["portrait"],
        details = json["attributes"]["images"]["cover"]["details"]["mobile"]
            ["portrait"],
        isDark = json["attributes"]["isDark"],
        quotes = quotes,
        type = json["type"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "displayOrder": displayOrder,
        "description": description,
        "shortDescription": shortDescription,
        "iconUrl": iconUrl,
        "background": background,
        "details": details,
        "isDark": isDark,
        "quotes": quotes,
        "type": type
      };
}

class Quotes {
  final String author;
  final String role;
  final String text;

  Quotes.fromJson(Map<String, dynamic> json)
      : author = json["attributes"]["author"],
        role = json["attributes"]["role"],
        text = json["attributes"]["text"];

  Map<String, dynamic> toJson() =>
      {"author": author, "role": role, "text": text};
}
