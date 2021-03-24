import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BTC',
  'ETH',
  'LTC',
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
const apiKey = 'F76EFFCD-9234-4089-B769-1B4F08ECF405';

class CoinData {
  Future getCoinData(from, to) async {
    String rate;
    String requestURL =
        coinAPIURL + '/' + from + '/' + to + '?apiKey=' + apiKey;
    http.Response response = await http.get(requestURL);
    print(requestURL);
    if (response.statusCode == 200) {
      rate = '1 ' +
          from +
          ' = ' +
          jsonDecode(response.body)['rate'].toStringAsFixed(3) +
          ' ' +
          to;
      print(rate);
      return rate;
    } else {
      print(response.statusCode);
      return 'Problem with the get request';
    }
  }
}
