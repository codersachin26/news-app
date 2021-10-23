import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../models/api_key.dart';

class NewsAPI {
  static dynamic jsonData;
  static Future<dynamic> getData() async {
    if (jsonData != null) {
      print(jsonData);
      return jsonData;
    } else {
      final String url =
          'https://newsapi.org/v2/top-headlines?country=in&apiKey=${API_KEY}';
      final response = await http.get(Uri.parse(url));
      jsonData = jsonDecode(response.body);
      return jsonData;
    }
  }
}

class MyHttpoverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
