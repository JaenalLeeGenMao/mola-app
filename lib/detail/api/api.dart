import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/video.dart';

import '../../config.dart';

final Map<String, dynamic> data = config();
final String baseUrlProd = data["api"];
final String baseUrlStaging = data['apiStaging'];
final String stagingMode = data['staging'];
final String baseUrl = stagingMode == '1' ? baseUrlStaging : baseUrlProd;

getVideoDetail(videoId) async {
  final url = '$baseUrl/videos/$videoId';

  var response = await http.get(url);

  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    var data = result["data"].length > 0 ? result["data"][0] : [];

    var primaryQuotes = data["attributes"]["quotes"];

    List<Quotes> quotes = [];

    for (var primaryQuote in primaryQuotes) {
      var quote = new Quotes.fromJson(primaryQuote);
      quotes.add(quote);
    }

    var video = new Video.fromJson(data, quotes);

    return video;
  }
  return null;
}
