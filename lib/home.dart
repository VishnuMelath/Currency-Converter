import 'dart:developer';

import 'package:flutter/material.dart';

import 'repository/convertion_api.dart';
import 'widgets/column_layout.dart';
import 'widgets/conver_button.dart';
import 'widgets/row_layout.dart';

class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _amountController =
      TextEditingController(text: '0');
  final TextEditingController _fromController = TextEditingController(text: '');
  final TextEditingController _toController = TextEditingController(text: '');
  late Size size;
  String resultString = '';
  late List<String> _currencies;
  bool loading = true;
  bool resultVisible = false;
  @override
  void initState() {
    _loadCountries(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Currency Converter',
          style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                  color: Color.fromARGB(166, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      if (constraints.maxWidth > 600) {
                        return RowLayout(
                          currencies: _currencies,
                          controller: _amountController,
                          fromcontroller: _fromController,
                          tocontroller: _toController,
                        );
                      } else {
                        return ColumnLayout(
                          currencies: _currencies,
                          controller: _amountController,
                          fromcontroller: _fromController,
                          tocontroller: _toController,
                        );
                      }
                    },
                  ),
                  Visibility(
                    visible: resultVisible,
                    child: Text(
                      resultString,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ConvertButton(
                    callback: _convert,
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _loadCountries(BuildContext context) async {
    loading = true;
    _currencies = (await ConvertionApi().getCurrencies()).toSet().toList();
    loading = false;
    print(_currencies);
    setState(() {});
  }

  Future<void> _convert() async {
    try {
      if (_fromController.text == '' || _toController.text == '') {
        resultString = 'Please select Currency';
      } else if (double.tryParse(_amountController.text) == null) {
        resultString = 'Please Enter a valid amount';
      } else {
        var convertedRate = await ConvertionApi().convertCurrency(
            _fromController.text,
            _toController.text,
            double.parse(_amountController.text));
        resultString =
            '${_amountController.text} ${_fromController.text.toUpperCase()} =${convertedRate.toStringAsFixed(2)} ${_toController.text.toUpperCase()}';
      }
      resultVisible = true;
      setState(() {});
    } catch (e) {}
  }
}
