import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/gold_price.dart';

Future<List<GoldPrice>> fetchGoldPricesFromAPI() async {
  final response =
      await http.get(Uri.parse('https://api.qmdev.xyz/api/metals/rates'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);

    final rates = data['data']['rates'] as Map<String, dynamic>;
    final goldPrices = <GoldPrice>[];

    for (var currency in rates.keys) {
      goldPrices.add(
          GoldPrice(currency, rates[currency].toDouble())); // Convert to double
    }

    return goldPrices;
  } else {
    throw Exception('Failed to fetch gold prices');
  }
}
