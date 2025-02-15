import 'dart:convert';
import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:testing/core/error/ApiFailure.dart';
import 'package:testing/data/data_sources/currency_api_client.dart';
import 'package:testing/data/repositories/currency_repository_impl.dart';
import 'package:testing/domain/entities/currency.dart';

void main() {
  group('CurrencyRepositoryImpl', () {
    test('success',() async {
        final mockResponse = jsonEncode([
          {
          "currency": "OMR",
          "currency_icon": "https://loremflickr.com/640/480/food",
          "twd_price": 51387.29,
          "amount_decimal": "4",
          "id": "1"
          },
          {
          "currency": "NZD",
          "currency_icon": "https://loremflickr.com/640/480/food",
          "twd_price": 29856.83,
          "amount_decimal": "6",
          "id": "2"
          },
        ]);

        final mockClient = MockClient((request) async {
          return http.Response(mockResponse,200);
        });

        final client = CurrencyApiClient(client: mockClient);
        final respository = CurrencyRepositoryImpl(client: client);
        final response = await respository.getCurrency();

        expect(response.isRight(), true);
        response.fold(
              (failure) => fail('$failure'),
              (currencies) {
            expect(currencies, isA<List<Currency>>());
            expect(currencies.length, 2);
            expect(currencies[0].id, '1');
          },
        );
    });

    test('failed',() async {
      final mockClient = MockClient((request) async {
        return http.Response('Error',404);
      });

      final client = CurrencyApiClient(client: mockClient);
      final repository = CurrencyRepositoryImpl(client: client);
      final response = await repository.getCurrency();
      expect(response.isLeft(), true);
      response.fold(
            (failure) {
          expect(failure, isA<ApiFailure>());
          expect(failure.statusCode, 404);
          expect(failure.responseBody, 'Error');
        },
            (currencies) => fail('$currencies'),
      );
    });
  });
}