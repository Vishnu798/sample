import 'package:http/http.dart' as http;

class ApiService {
  Future<http.Response> fetchData() async {
    String url = "https://ixifly.in/flutter/task1";
    try {
      return await http.get(Uri.parse(url));
    } catch (error) {
      throw Exception('Failed to load data : $error');
    }
  }
}
