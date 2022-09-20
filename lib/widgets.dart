// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CurrencyCard extends StatefulWidget {
  final String selectedCrypto;
  final String currencySymbol;
  final String currencyValue;
  const CurrencyCard({
    Key? key,
    required this.selectedCrypto,
    required this.currencySymbol,
    required this.currencyValue,
  }) : super(key: key);

  @override
  State<CurrencyCard> createState() => _CurrencyCardState();
}

class _CurrencyCardState extends State<CurrencyCard> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            //TODO: Update the Text Widget with the live bitcoin data here.
            '1 ${widget.selectedCrypto} = ${widget.currencySymbol} ${widget.currencyValue}',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
