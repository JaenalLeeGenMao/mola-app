class Genre {
  final String id;
  final String title;
  final String description;
  final String countryCode;
  final int sortOrder;

  Genre.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        title = json["attributes"]["title"],
        description = json["attributes"]["description"],
        countryCode = json["attributes"]["countryCode"],
        sortOrder = json["attributes"]["sortOrder"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "countryCode": countryCode,
        "sortOrder": sortOrder,
      };
}
