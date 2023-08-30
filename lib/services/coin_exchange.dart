import 'networking.dart';
import 'package:flutter/material.dart';

class BitcoinExchange {
  String apiKey = 'You API Key';
  Future<dynamic> getBitcoinData(String coin, String currency) async {
    NetworkHelper networkHelper = NetworkHelper();
    var bitcoinData = await networkHelper.getData(
        'https://rest.coinapi.io/v1/exchangerate/$coin/$currency?apiKey=$apiKey');
    debugPrint(bitcoinData.toString());
    return bitcoinData;
  }
}
