import 'package:http/http.dart' as http;

class CurrencyApiClient {
  final http.Client client;
  final String baseUrl;

  CurrencyApiClient({
    required this.client,
    this.baseUrl = 'https://65efcc68ead08fa78a50f929.mockapi.io/api/v1'
  });
   Future<http.Response> getCurrencyPairs() async {
     final url = Uri.parse('$baseUrl/pairs');
     final response = await client.get(url);
     return response;
  }
}