import 'dart:developer';

import 'package:dio/dio.dart';

class ConvertionApi {
  Future<List<String>> getCurrencies() async {
    try {
      final dio = Dio();
      final response = await dio.get(
          'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies.json');

      if (response.statusCode == 200) {
        final data = response.data;
        final currencies = data.keys.toList();
        return List<String>.from(currencies);
      } else {
        throw Exception('Failed to load currencies');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Error fetching currencies');
    }
  }

  Future<double> convertCurrency(
      String fromCurrency, String toCurrency, double amount) async {
    try {
      final dio = Dio();
      final url =
          'https://cdn.jsdelivr.net/npm/@fawazahmed0/currency-api@latest/v1/currencies/${fromCurrency.toLowerCase()}.json';

      final response = await dio.get(url);

      if (response.statusCode == 200) {
        final data =
            response.data[fromCurrency.toLowerCase()][toCurrency.toLowerCase()];

        if (data != null) {
          return amount * data;
        } else {
          throw Exception('Currency conversion rate not available');
        }
      } else {
        throw Exception('Failed to convert currency');
      }
    } catch (e) {
      log('Error: $e');
      throw Exception('Error converting currency please try again!');
    }
  }
}
