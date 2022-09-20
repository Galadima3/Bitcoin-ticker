//TODO: Add your imports here.
import 'dart:convert';
import 'package:http/http.dart';

const List<String> currenciesList = [

  'USD',
  'EUR',
  'CNY',
  'GBP',
];

var cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'BNB',
];
const List currencySymbol = [
  '\$',
  '€',
  '¥',
  '£'
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'F1D528DE-1FAA-48EE-AB0C-28C1C23E2D43';

class CoinData {
  // final String? apiEndPoint;

  // CoinData(this.apiEndPoint);

  //TODO: Create your getCoinData() method here.
  Future getCoinData(String crypto) async {
    String apiEndPoint = '$coinAPIURL/$crypto/USD/?apikey=$apiKey';

    final Uri url = Uri.parse(apiEndPoint);

    Response response = await get(url);
    if (response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      var lastPrice = decodedData['rate'];

      return lastPrice;


      //return lastPrice;
    } else {
      print(response.statusCode);
      throw 'Problem with GET request';
    }
  }
}
