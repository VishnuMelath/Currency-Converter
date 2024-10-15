import 'dart:developer';

import 'package:currencyconverter/repository/convertion_api.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CurrencyConverter extends StatefulWidget {
  const CurrencyConverter({super.key});

  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController _amountController =
      TextEditingController(text: '0');
  late Size size;
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _convertedRate = 0;
  late List<String> _currencies;
  bool loading = true;
  // late List<String> _currencies;
  @override
  void initState() {
    _loadCountries(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildAmountField(),
                    20.verticalSpace,
                    10.horizontalSpace,
                    _buildCurrencyDropdown("From", _fromCurrency, (newValue) {
                      setState(() {
                        _fromCurrency = newValue!;
                      });
                    }),
                    20.verticalSpace,
                    10.horizontalSpace,
                    _buildCurrencyDropdown("To", _toCurrency, (newValue) {
                      setState(() {
                        _toCurrency = newValue!;
                      });
                    }),
                    40.verticalSpace,
                    Text(
                        '${_amountController.text} $_fromCurrency =${_convertedRate.toStringAsFixed(2)} $_toCurrency',
                        style: TextStyle(fontSize: 16.sp)),
                    40.verticalSpace,
                    ElevatedButton(
                      onPressed: _convert,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 15.h),
                        textStyle: TextStyle(fontSize: 18.sp),
                      ),
                      child: const Text('Convert'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Future<void> _loadCountries(BuildContext context) async {
    loading = true;
    _currencies = (await ConvertionApi().getCurrencies()).toSet().toList();
    loading = false;
    setState(() {});
  }

  Future<void> _convert() async {
    try {
      _convertedRate = await ConvertionApi().convertCurrency(
          _fromCurrency, _toCurrency, double.parse(_amountController.text));
      log(_convertedRate.toString());
      setState(() {});
    } catch (e) {}
  }

  Widget _buildAmountField() {
    return TextFormField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Amount',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }

  Widget _buildCurrencyDropdown(
      String label, String selectedCurrency, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16.sp),
        ),
        SizedBox(height: 10.h),
        DropdownButtonFormField2(
          value: selectedCurrency,
          decoration: InputDecoration(
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.r)),
            contentPadding: EdgeInsets.all(12.w),
          ),
          items: _currencies.map((currency) {
            return DropdownMenuItem(
              value: currency.toUpperCase(),
              child: Text(currency.toUpperCase()),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}
