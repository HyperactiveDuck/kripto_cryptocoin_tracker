import 'package:flutter/material.dart';

class ExchangeCard extends StatelessWidget {
  const ExchangeCard({
    super.key,
    required this.crypto,
    required this.price,
    required this.selectedCurrency,
  });

  final String crypto;
  final String price;
  final String selectedCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 9.0, 18.0, 0),
      child: Card(
        color: Colors.grey[900],
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $crypto = $price $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
