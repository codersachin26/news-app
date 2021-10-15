import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/api_key.dart';

class NewsAPI {
  Future<dynamic> getData() async {
    final String url =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=${API_KEY}';
    final response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    return jsonData;
  }
}
