import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:testing/data/models/currency_model.dart';

void main() {
  group('CurrencyModel', (){
    final jsonData = {
      "currency": "NZD",
      "currency_icon": "https://loremflickr.com/640/480/food",
      "twd_price": 29856.83,
      "amount_decimal": "6",
      "id": "2"
    };

    test('decode json success',() {
      final model = CurrencyModel.fromJson(jsonData);
      expect(model.id, '2');
      expect(model.currency, 'NZD');
      expect(model.icon, 'https://loremflickr.com/640/480/food');
      expect(model.twPrice, 29856.83);
      expect(model.amountDecimal, 6);
    });
  });
}