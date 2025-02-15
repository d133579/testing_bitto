import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:testing/data/data_sources/currency_api_client.dart';

void main() {
  group('CurrencyApiClient', () {
    test('status code == 200', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode([
            {'id': '1', 'from': 'TWD', 'to': 'USD', 'rate': '0.033'}
          ]),
          200,
        );
      });

      final client = CurrencyApiClient(client: mockClient);
      final response = await client.getCurrencyPairs();
      expect(response.statusCode, 200);
      final body = jsonDecode(response.body);
      expect(body, isA<List>());
    });

    test('status code != 200',() async {
      final mockClient = MockClient((request) async {
        return http.Response('Error',404);
      });

      final client = CurrencyApiClient(client: mockClient);
      final response = await client.getCurrencyPairs();
      expect(response.statusCode, isNot(200));
    });
  });
}