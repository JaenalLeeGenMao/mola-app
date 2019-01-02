import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

import './models/playlist.dart';
// import './models/video.dart';

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

    return data.length == 0
        ? []
        : data.map((eachPlaylist) {
            var playlist = new Playlist.fromJson(eachPlaylist);
            return playlist;
          }).toList()
      ..sort((a, b) {
        return a.sortOrder.toString().compareTo(b.sortOrder.toString());
      });
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

    data = data.map((video) {
      var primaryQuote = video["attributes"]["quotes"][0]["attributes"];
      return {
        "id": video["id"],
        "title": video["attributes"]["title"],
        "displayOrder": video["attributes"]["displayOrder"],
        "description": video["attributes"]["description"],
        "shortDescription": video["attributes"]["shortDescription"],
        "iconUrl": video["attributes"]["iconUrl"],
        "background": video["attributes"]["images"]["cover"]["background"]
            ["mobile"]["portrait"],
        "details": video["attributes"]["images"]["cover"]["details"]["mobile"]
            ["portrait"],
        "isDark": video["attributes"]["isDark"],
        "type": video["type"],
        "quotes": {
          "author": primaryQuote["author"],
          "role": primaryQuote["role"],
          "text": primaryQuote["text"]
        }
      };
    }).toList()
      ..sort((a, b) {
        return a["displayOrder"]
            .toString()
            .compareTo(b["displayOrder"].toString());
      });
    return data;
  } else {
    return [];
  }
}

getHomeDetails() async {
  var playlists = await getHomePlaylist();
  var videos = [];

  for (var playlist in playlists) {
    // var playlistId = playlist["id"].replaceAll(new RegExp(r'f-'), '');
    var result = await getHomeVideos(playlist.id);

    videos.add(result);
  }

  return [playlists, videos];
}
