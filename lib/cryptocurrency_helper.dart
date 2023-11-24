import 'package:flutter/material.dart';

import 'coin_data.dart';
import 'price.dart';

double? coinPrice;
double? round;
List<double> amount = [];

class Crypto {
  String? currency;
  Crypto(this.currency, this.context);
  BuildContext? context;

  Future<List<double>> updateUI() async {
    amount.clear();
    for (String coin in cryptoList) {
      Price price = Price(coin: coin, currency: currency);
      var data = await price.getPrice();
      if (data == null) {
        amount = List.generate(cryptoList.length, (index) => 0.0);
        final snackBar = SnackBar(content: Text('Something went wrong'));
        ScaffoldMessenger.of(context!).showSnackBar(snackBar);
        return amount;
      } else {
        round = data['rate'];
        coinPrice = round!.roundToDouble();
        amount.add(coinPrice!);
      }
    }
    return amount;
  }
}
