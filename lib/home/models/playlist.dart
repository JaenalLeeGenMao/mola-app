class Playlist {
  final String id;
  final String title;
  final int sortOrder;
  final String description;
  final String shortDescription;
  final String iconUrl;
  final String background;
  final String details;
  final int isDark;
  final String type;

  Playlist.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["attributes"]["title"],
        sortOrder = json["attributes"]["sortOrder"],
        description = json["attributes"]["description"],
        shortDescription = json["attributes"]["shortDescription"],
        iconUrl = json["attributes"]["iconUrl"],
        background = json["attributes"]["images"]["cover"]["background"]
            ["mobile"]["portrait"],
        details = json["attributes"]["images"]["cover"]["details"]["mobile"]
            ["portrait"],
        isDark = json["attributes"]["isDark"],
        type = json["type"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "sortOrder": sortOrder,
        "description": description,
        "shortDescription": shortDescription,
        "iconUrl": iconUrl,
        "background": background,
        "details": details,
        "isDark": isDark,
        "type": type
      };
}
