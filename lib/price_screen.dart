import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'package:kripto_cryptocoin_tracker/services/coin_exchange.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({
    super.key,
  });

  @override
  PriceScreenState createState() => PriceScreenState();
}

class PriceScreenState extends State<PriceScreen> {
  getPrices() {
    getBitcoinPrice();
    getETHPrice();
    getLTCPrice();
  }

  void getBitcoinPrice() async {
    BitcoinExchange bitcoinExchange = BitcoinExchange();
    var bitcoinData =
        await bitcoinExchange.getBitcoinData('BTC', selectedCurrency);
    setState(() {
      bitcoinPrice = bitcoinData['rate'].toInt();
    });
  }

  void getETHPrice() async {
    BitcoinExchange bitcoinExchange = BitcoinExchange();
    var bitcoinData =
        await bitcoinExchange.getBitcoinData('ETH', selectedCurrency);
    setState(() {
      ethPrice = bitcoinData['rate'].toInt();
    });
  }

  void getLTCPrice() async {
    BitcoinExchange bitcoinExchange = BitcoinExchange();
    var bitcoinData =
        await bitcoinExchange.getBitcoinData('LTC', selectedCurrency);
    setState(() {
      ltcPrice = bitcoinData['rate'].toInt();
    });
  }

  int ltcPrice = 0;
  int ethPrice = 0;
  int bitcoinPrice = 0;
  @override
  void initState() {
    super.initState();
    getPrices();
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      style: TextStyle(color: Colors.white, fontSize: 50.0),
      iconSize: 100.0,
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        debugPrint(value);
        setState(
          () {
            selectedCurrency = value!;
            getPrices();
          },
        );
      },
    );
  }

  CupertinoPicker IOSPicker() {
    List<Widget> getPickerItems() {
      List<Text> pickerItems = [];
      for (String currency in currenciesList) {
        pickerItems.add(Text(currency));
      }
      return pickerItems;
    }

    //Cupertino Picker for IOS
    return CupertinoPicker(
      backgroundColor: Colors.grey[900],
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        debugPrint(selectedIndex.toString());
      },
      children: getPickerItems(),
    );
  }

  Widget getPlatform() {
    if (Platform.isIOS == true) {
      return IOSPicker();
    } else if (Platform.isAndroid == true) {
      return androidDropdown();
    } else {
      return androidDropdown();
    }
  }

  String selectedCurrency = 'USD';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('KRİPTO'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ExchangeCardBTC(
              bitcoinPrice: bitcoinPrice, selectedCurrency: selectedCurrency),
          ExchangeCardETH(
              ethPrice: ethPrice, selectedCurrency: selectedCurrency),
          ExchangeCartLTC(
              ltcPrice: ltcPrice, selectedCurrency: selectedCurrency),
          SizedBox(height: 377.0),
          Container(
              height: 125.0,
              alignment: Alignment.center,
              color: Colors.grey[900],
              child: getPlatform()),
        ],
      ),
    );
  }
}

class ExchangeCardBTC extends StatelessWidget {
  const ExchangeCardBTC({
    super.key,
    required this.bitcoinPrice,
    required this.selectedCurrency,
  });

  final int bitcoinPrice;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.grey[900],
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 BTC = $bitcoinPrice $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ExchangeCartLTC extends StatelessWidget {
  const ExchangeCartLTC({
    super.key,
    required this.ltcPrice,
    required this.selectedCurrency,
  });

  final int ltcPrice;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
      child: Card(
        color: Colors.grey[900],
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 LTC = $ltcPrice $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ExchangeCardETH extends StatelessWidget {
  const ExchangeCardETH({
    super.key,
    required this.ethPrice,
    required this.selectedCurrency,
  });

  final int ethPrice;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 0, 18.0, 0),
      child: Card(
        color: Colors.grey[900],
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 ETH = $ethPrice $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
