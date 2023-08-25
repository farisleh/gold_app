import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchGoldPrices() async {
  final response =
      await http.get(Uri.parse('https://api.qmdev.xyz/metals/rates'));
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to fetch gold prices');
  }
}
