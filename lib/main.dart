import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/gold_purchase_notifier.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoldPurchaseNotifier(),
      child: MaterialApp(
        title: 'Gold Purchase App',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
