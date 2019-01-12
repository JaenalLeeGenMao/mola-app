import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/genre.dart';
import '../models/video.dart';

import '../../config.dart';

final Map<String, dynamic> data = config();
final String baseUrl = data["api"];

getLibraryGenre() async {
  final url = '$baseUrl/videos/playlists/genre';

  var response = await http.get(url);

  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    var data = result["data"].length > 0
        ? result["data"][0]["attributes"]["playlists"]
        : [];

    if (data == null) {
      return [];
    }

    return data.length == 0
        ? []
        : data.map((eachGenre) {
            var playlist = new Genre.fromJson(eachGenre);
            return playlist;
          }).toList()
      ..sort((a, b) {
        return a.sortOrder.toString().compareTo(b.sortOrder.toString());
      });
  } else {
    return [];
  }
}

getLibrary(id) async {
  final url = '$baseUrl/videos/playlists/$id';

  var response = await http.get(url);

  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    var data = result["data"].length > 0
        ? result["data"][0]["attributes"]["videos"]
        : [];
    var title = result["data"][0]["attributes"]["title"];

    if (data == null) {
      return [id, []];
    }

    return data.length == 0
        ? []
        : [
            title,
            data.map((eachVideo) {
              var video = new Video.fromJson(eachVideo);
              return video;
            }).toList()
          ];
  } else {
    return [];
  }
}
