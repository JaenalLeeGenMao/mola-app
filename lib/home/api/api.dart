import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/playlist.dart';
import '../models/video.dart';

import '../../config.dart';

final Map<String, dynamic> data = config();
final String baseUrl = data['api'];

getHomePlaylist() async {
  final url = '$baseUrl/videos/playlists/mola-home';

  print('url nya home API: $url');

  var response = await http.get(url).timeout(const Duration(seconds: 5));
  print("timeout nih");
  print(response.toString());
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
  // var baseUrl = stagingMode == '1' ? baseUrlStaging : baseUrlProd;
  final url = '$baseUrl/videos/playlists/$id';
  var response = await http.get(url);

  if (response.statusCode == 200) {
    List<Video> result = [];
    var resultMap = json.decode(response.body);
    var data = resultMap["data"].length > 0
        ? resultMap["data"][0]["attributes"]["videos"]
        : [];

    for (var index = 0; index < data.length; index++) {
      var eachVideo = data[index];
      var primaryQuotes = eachVideo["attributes"]["quotes"];

      List<Quotes> quotes = [];

      for (var primaryQuote in primaryQuotes) {
        var quote = new Quotes.fromJson(primaryQuote);
        quotes.add(quote);
      }

      var video = new Video.fromJson(eachVideo, quotes);
      result.add(video);
    }

    return result;
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
