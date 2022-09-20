// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({Key? key}) : super(key: key);

  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String dropdownvalue = 'BTC';
  String highlightedCrypto = 'BTC';
  var items = [
    'BTC',
    'ETH',
    'LTC',
    'BNB',
  ];
  String selectedCurrency = 'USD';

  androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );

      dropdownItems.add(newItem);
    }
    //return dropdownItems;
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value!;
          },
        );
      },
    );
  }

  iOSPicker() {
    List<Text> pickedItems = [];
    for (String currency in currenciesList) {
      pickedItems.add(Text(currency));
    }

    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          print(selectedIndex);
        },
        children: pickedItems);
  }

  String cryptoValueInUSD = '?';
  String cryptoValueInEUR = '?';
  String cryptoValueInCNY = '?';
  String cryptoValueInGBP = '?';

//TODO: Create a method here called getData() to get the coin data from coin_data.dart
  void setCryptoData(String value){
    setState(() {
      highlightedCrypto = value;
    });
  }
  void getData() async {
    try {
      var data = await CoinData().getCoinData(dropdownvalue);
      print(data);

      setState(() {
        cryptoValueInUSD = data.toStringAsFixed(0);
        var cny = int.parse(cryptoValueInUSD) * 7.01;
        var gbp = int.parse(cryptoValueInUSD) * 0.87;

        cryptoValueInEUR = cryptoValueInUSD;

        cryptoValueInCNY = cny.toStringAsFixed(0);
        cryptoValueInGBP = gbp.toStringAsFixed(0);


        //cryptoValueInUSD = data.toStringAsFixed(0);
      });
    } catch (e) {
      log(e.toString());
    }
    CoinData coinx = CoinData();
    await coinx.getCoinData(dropdownvalue);
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('🤑 Coin Ticker'),
        actions: [

          PopupMenuButton(
            // add icon, by default "3 dot" icon
            // icon: Icon(Icons.book)
              itemBuilder: (context){
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text("BTC"),
                  ),

                  PopupMenuItem<int>(
                    value: 1,
                    child: Text("LTC"),
                  ),

                  PopupMenuItem<int>(
                    value: 2,
                    child: Text("Logout"),
                  ),
                ];
              },
              onSelected:(value){
                if(value == 0){
                  print("My account menu is selected.");
                }else if(value == 1){
                  print("Settings menu is selected.");
                }else if(value == 2){
                  print("Logout menu is selected.");
                }
              }
          ),


        ],

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
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
                  '1 BTC = \$ $cryptoValueInUSD',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          CurrencyCard(
              selectedCrypto: dropdownvalue,
              currencySymbol: currencySymbol[1],
              currencyValue: cryptoValueInEUR),
          SizedBox(height: 50),
          CurrencyCard(
              selectedCrypto: dropdownvalue,
              currencySymbol: currencySymbol[2],
              currencyValue: cryptoValueInCNY),
          SizedBox(height: 50),
          CurrencyCard(
              selectedCrypto: dropdownvalue,
              currencySymbol: currencySymbol[3],
              currencyValue: cryptoValueInGBP),
          Container(
            height: 150,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.blue,
            child: DropdownButton(
                alignment: Alignment.center,
                dropdownColor: Colors.blue,
                value: dropdownvalue,
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                }),
          )
        ],
      ),
    );
  }
}

// Container(
//     height: 150.0,
//     alignment: Alignment.center,
//     padding: EdgeInsets.only(bottom: 30.0),
//     color: Colors.lightBlue,
//     child: Platform.isIOS ? iOSPicker() : androidDropdown()),
