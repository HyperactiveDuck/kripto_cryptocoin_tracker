import 'package:flutter/material.dart';
import 'package:kripto_cryptocoin_tracker/widgets/exchange_card.dart';
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
  String selectedCurrency = 'USD';
  String ltcPrice = '';
  String ethPrice = '';
  String bitcoinPrice = '';
  String usdtPrice = '';
  String bnbPrice = '';
  String xrpPrice = '';
  String solPrice = '';
  String dotPrice = '';

  Future<List<double>> getCryptoPrices() async {
    List<double> prices = [];
    for (String crypto in cryptoList) {
      BitcoinExchange bitcoinExchange = BitcoinExchange();
      var bitcoinData =
          await bitcoinExchange.getBitcoinData(crypto, selectedCurrency);
      prices.add(bitcoinData['rate'].toDouble());
    }
    return prices;
  }

  void getCryptoPrices2() async {
    Future<List<double>> prices = getCryptoPrices();
    prices.then((prices) {
      setState(() {
        bitcoinPrice = prices[0].toStringAsFixed(2);
        ethPrice = prices[1].toStringAsFixed(2);
        ltcPrice = prices[2].toStringAsFixed(2);
        usdtPrice = prices[3].toStringAsFixed(2);
        bnbPrice = prices[4].toStringAsFixed(2);
        xrpPrice = prices[5].toStringAsFixed(2);
        solPrice = prices[6].toStringAsFixed(2);
        dotPrice = prices[7].toStringAsFixed(2);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getCryptoPrices2();
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
      style: const TextStyle(color: Colors.white, fontSize: 50.0),
      iconSize: 100.0,
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        debugPrint(value);
        setState(
          () {
            selectedCurrency = value!;
            getCryptoPrices2();
          },
        );
      },
    );
  }

  CupertinoPicker iOSPicker() {
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
      return iOSPicker();
    } else if (Platform.isAndroid == true) {
      return androidDropdown();
    } else {
      return androidDropdown();
    }
  }

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
          ExchangeCard(
              crypto: cryptoList[0],
              price: bitcoinPrice,
              selectedCurrency: selectedCurrency),
          ExchangeCard(
              crypto: cryptoList[1],
              price: ethPrice,
              selectedCurrency: selectedCurrency),
          ExchangeCard(
              crypto: cryptoList[2],
              price: ltcPrice,
              selectedCurrency: selectedCurrency),
          ExchangeCard(
              crypto: cryptoList[3],
              price: usdtPrice,
              selectedCurrency: selectedCurrency),
          ExchangeCard(
              crypto: cryptoList[4],
              price: bnbPrice,
              selectedCurrency: selectedCurrency),
          ExchangeCard(
            crypto: cryptoList[5],
            price: xrpPrice,
            selectedCurrency: selectedCurrency,
          ),
          ExchangeCard(
            crypto: cryptoList[6],
            price: solPrice,
            selectedCurrency: selectedCurrency,
          ),
          ExchangeCard(
            crypto: cryptoList[7],
            price: dotPrice,
            selectedCurrency: selectedCurrency,
          ),
          const SizedBox(
            height: 50.0,
          ),
          Expanded(
            flex: 3,
            child: Container(
                alignment: Alignment.center,
                color: Colors.grey[900],
                child: getPlatform()),
          ),
        ],
      ),
    );
  }
}
