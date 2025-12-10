import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  static const _apiKey = '9564aad4ffc941bd956d0144321a7e0e';
  static const _base = 'https://newsapi.org/v2';

  Future<List<dynamic>> fetchNews() async {
    final url = Uri.parse(
        '$_base/everything?q=india&sortBy=publishedAt&apiKey=$_apiKey');

    final response = await http.get(url);
    print("NEWS RESPONSE: ${response.body}");

    if (response.statusCode != 200) {
      throw Exception("Failed to load news (${response.statusCode})");
    }

    final data = jsonDecode(response.body);

    if (data['status'] != "ok") {
      throw Exception("News API error: ${data['message']}");
    }

    return data['articles'] ?? [];
  }
}
