import 'package:flutter/material.dart';
import 'screens/price_screen.dart';

void main() => runApp(const CryptoTracker());

class CryptoTracker extends StatelessWidget {
  const CryptoTracker({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
          primaryColor: Colors.lightBlue,
          scaffoldBackgroundColor: Colors.white),
      home: const PriceScreen(),
    );
  }
}
