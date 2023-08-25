import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/gold_price.dart';
import '../providers/gold_purchase_notifier.dart';

class TopUpScreen extends StatefulWidget {
  final List<GoldPrice> goldPrices;

  TopUpScreen({required this.goldPrices});

  @override
  _TopUpScreenState createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  double _gramsToPurchase = 0;
  GoldPrice? _selectedGoldPrice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topup Gold'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  _gramsToPurchase = double.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Grams to Purchase',
              ),
            ),
          ),
          DropdownButton<GoldPrice>(
            value: _selectedGoldPrice,
            onChanged: (newValue) {
              setState(() {
                _selectedGoldPrice = newValue;
              });
            },
            items:
                widget.goldPrices.map<DropdownMenuItem<GoldPrice>>((goldPrice) {
              return DropdownMenuItem<GoldPrice>(
                value: goldPrice,
                child: Text(goldPrice.currency),
              );
            }).toList(),
          ),
          Consumer<GoldPurchaseNotifier>(
            builder: (context, goldPurchaseNotifier, _) {
              return ElevatedButton(
                onPressed: () {
                  if (_selectedGoldPrice != null) {
                    double usdPrice =
                        _gramsToPurchase * _selectedGoldPrice!.pricePerGram;

                    goldPurchaseNotifier.updateGrams(
                      goldPurchaseNotifier.grams + _gramsToPurchase,
                    );
                    Navigator.pop(context);
                    _showTransactionSuccessfulDialog(usdPrice);
                  } else {}
                },
                child: Text('Confirm Topup'),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showTransactionSuccessfulDialog(double usdPrice) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Transaction Successful'),
          content: Text(
              'You have successfully topped up $_gramsToPurchase grams of gold for $usdPrice USD.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
