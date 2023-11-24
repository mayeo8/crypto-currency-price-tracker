import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../cryptocurrency_helper.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String currency = 'USD';
  String? coinType;

  List<double> amount = List.generate(cryptoList.length, (index) => 0.0);

  DropdownButton androidDropdown() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String singleCurrency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: singleCurrency,
        child: Text(
          singleCurrency,
          style: const TextStyle(
            fontSize: 18.0,
          ),
        ),
      );
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: currency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          currency = value!;
          updateUI();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerList = [];
    for (String singleCurrency in currenciesList) {
      pickerList.add(Text(singleCurrency));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 40.0,
      scrollController: FixedExtentScrollController(initialItem: 19),
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          currency = pickerList[selectedIndex].data!;
          updateUI();
        });
      },
      children: pickerList,
    );
  }

  void updateUI() async {
    Crypto coinList = Crypto(currency, context);
    var list = await coinList.updateUI();
    amount.clear();
    amount.addAll(list);
    setState(() {
      amount;
    });
  }

  //remaining code after i reformatted my code
  // void updateUI() async {
  //   amount.clear();
  //   for (String coin in cryptoList) {
  //     Price price = Price(coin: coin, currency: currency);
  //     var data = await price.getPrice();
  //     if (data == null) {
  //       print(amount);
  //       throw 'this returned null';
  //     } else {
  //       round = data['rate'];
  //       coinPrice = round!.roundToDouble();
  //       amount.add(coinPrice!);
  //     }
  //   }
  //   setState(() {
  //     amount;
  //     print(coinPrice);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        children: [
          Flexible(
            child: Container(
              padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
              child: ListView.builder(
                itemCount: cryptoList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '${cryptoList[index]} = ${amount[index]} $currency',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropdown(),
          ),
        ],
      ),
    );
  }
}
