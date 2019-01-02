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

  Video.fromJson(Map<String, dynamic> json)
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
        quotes = json["attributes"]["quotes"][0]["attributes"],
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

  Quotes(this.author, this.role, this.text);
}
