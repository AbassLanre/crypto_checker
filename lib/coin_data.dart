import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];
const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'LOL';

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  Future<Map> getCoinData(String selectedCurrency) async {
    http.Response response;
    var lastPrice = Map();
    for (int i=0; i<cryptoList.length; i++) {
      String requestURL = '$coinAPIURL/${cryptoList[i]}/$selectedCurrency?apikey=$apiKey';
      response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        lastPrice[cryptoList[i]] = decodedData['rate'];
        // print(response.body);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    print(lastPrice);
    return lastPrice;
  }
}
