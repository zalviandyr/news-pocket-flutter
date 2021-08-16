import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_pocket/models/models.dart';

class Service {
  static final String _topHeadline =
      'https://newsapi.org/v2/top-headlines?apiKey=ecfc41dcceeb40038a7c2dad7b34d715';
  static final String _everything =
      'https://newsapi.org/v2/everything?apiKey=ecfc41dcceeb40038a7c2dad7b34d715';

  static Future<List<News>> getNews(String category) async {
    Uri url = Uri.parse('$_topHeadline&country=id&category=$category');
    var response = await http.get(url);

    var json = jsonDecode(response.body);
    return News.fromJson(json['articles']);
  }

  static Future<List<News>> searchNews(String keyword) async {
    Uri url = Uri.parse('$_everything&q=$keyword');
    var response = await http.get(url);

    var json = jsonDecode(response.body);
    return News.fromJson(json['articles']);
  }
}
