import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/gold_price.dart';
import '../providers/gold_purchase_notifier.dart';
import '../utils/api.dart';
import '../widgets/gold_price_card.dart';
import 'topup_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';
  late List<GoldPrice> _goldPrices;
  late List<GoldPrice> _filteredList;

  @override
  void initState() {
    super.initState();
    _goldPrices = [];
    _filteredList = [];
    _fetchGoldPrices();
  }

  Future<void> _fetchGoldPrices() async {
    try {
      List<GoldPrice> goldPrices = await fetchGoldPricesFromAPI();
      setState(() {
        _goldPrices = goldPrices;
        _filteredList = goldPrices;
      });
    } catch (error) {
      print('Error fetching gold prices: $error');
    }
  }

  void _filterGoldPrices(String query) {
    setState(() {
      _searchQuery = query;
      _filteredList = _goldPrices.where((price) {
        return price.currency.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GoldPurchaseNotifier>(
      builder: (context, goldPurchaseNotifier, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Gold Purchase App'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    onChanged: _filterGoldPrices,
                    decoration: InputDecoration(
                      labelText: 'Search by currency',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Text('Total Grams: ${goldPurchaseNotifier.grams}'),
                Column(
                  children: _filteredList.map((goldPrice) {
                    return GoldPriceCard(goldPrice);
                  }).toList(),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TopUpScreen(
                          goldPrices: _goldPrices,
                        )),
              );
            },
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }
}
