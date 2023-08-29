import 'networking.dart';
import 'package:flutter/material.dart';

class BitcoinExchange {
  Future<dynamic> getBitcoinData(String coin, String currency) async {
    NetworkHelper networkHelper = NetworkHelper();
    var bitcoinData = await networkHelper.getData(
        'https://rest.coinapi.io/v1/exchangerate/$coin/$currency?apiKey=CD86A55D-963C-4243-884B-4CB32B4CDDBD');
    debugPrint(bitcoinData.toString());
    return bitcoinData;
  }
}
