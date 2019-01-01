import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

import '../config.dart';

final Map<String, dynamic> data = config();
final String baseUrl = data["api"];

getHomePlaylist() async {
  final url = '$baseUrl/videos/playlists/mola-home';

  var response = await http.get(url);
  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    var data = result["data"].length > 0
        ? result["data"][0]["attributes"]["playlists"]
        : [];
    data = data.map((playlist) {
      return {
        "id": playlist["id"],
        "title": playlist["attributes"]["title"],
        "sortOrder": playlist["attributes"]["sortOrder"],
        "description": playlist["attributes"]["description"],
        "shortDescription": playlist["attributes"]["shortDescription"],
        "iconUrl": playlist["attributes"]["iconUrl"],
        "background": playlist["attributes"]["images"]["cover"]["background"]
            ["mobile"]["portrait"],
        "details": playlist["attributes"]["images"]["cover"]["details"]
            ["mobile"]["portrait"],
        "isDark": playlist["attributes"]["isDark"],
        "type": playlist["type"],
      };
    }).toList()
      ..sort((a, b) {
        return a["sortOrder"].toString().compareTo(b["sortOrder"].toString());
      });

    return data;
  } else {
    return [];
  }
}

getHomeVideos(id) async {
  final url = '$baseUrl/videos/playlists/$id';
  var response = await http.get(url);

  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    var data = result["data"].length > 0
        ? result["data"][0]["attributes"]["videos"]
        : [];

    data = data.map((playlist) {
      return {
        "id": playlist["id"],
        "title": playlist["attributes"]["title"],
        "displayOrder": playlist["attributes"]["displayOrder"],
        "description": playlist["attributes"]["description"],
        "shortDescription": playlist["attributes"]["shortDescription"],
        "iconUrl": playlist["attributes"]["iconUrl"],
        "background": playlist["attributes"]["images"]["cover"]["background"]
            ["mobile"]["portrait"],
        "details": playlist["attributes"]["images"]["cover"]["details"]
            ["mobile"]["portrait"],
        "isDark": playlist["attributes"]["isDark"],
        "type": playlist["type"],
      };
    }).toList()
      ..sort((a, b) {
        return a["displayOrder"]
            .toString()
            .compareTo(b["displayOrder"].toString());
      });
    return data;
  } else {
    return [
      {"id": id}
    ];
  }
}

getHomeDetails() async {
  var playlists = await getHomePlaylist();
  var videos = [];

  for (var playlist in playlists) {
    // var playlistId = playlist["id"].replaceAll(new RegExp(r'f-'), '');
    var result = await getHomeVideos(playlist["id"]);

    videos.add(result);
  }

  return [playlists, videos];
}
