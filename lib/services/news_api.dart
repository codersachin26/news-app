import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import '../models/api_key.dart';

class NewsAPI {
  static Future<dynamic> getData() async {
    if (kDebugMode) {
      final news = await rootBundle.loadString('assets/news_data.json');
      final jsonData = jsonDecode(news);
      return jsonData;
    } else {
      final String url =
          'https://newsapi.org/v2/top-headlines?country=in&apiKey=${API_KEY}';
      final response = await http.get(Uri.parse(url));
      final jsonData = jsonDecode(response.body);
      return jsonData;
    }
  }
}
