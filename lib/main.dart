import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing/domain/use_cases/get_currency_pairs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/presentation/cubit/currency_cubit.dart';
import 'package:testing/presentation/screens/currency_exchange_rate_screen.dart';

import 'data/data_sources/currency_api_client.dart';
import 'data/repositories/currency_repository_impl.dart';

void main() {
  final apiClient = CurrencyApiClient(client: http.Client());
  final currencyRepositoryImpl =
  CurrencyRepositoryImpl(client: apiClient);
  final getCurrencyPairs = GetCurrencyPairs(currencyRepositoryImpl);

  runApp(MyApp(getCurrencyPairs: getCurrencyPairs));
}

class MyApp extends StatelessWidget {
  final GetCurrencyPairs getCurrencyPairs;

  const MyApp({super.key, required this.getCurrencyPairs});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider(
        create:
            (context) =>
                CurrencyCubit(getCurrencyPairsUseCase: getCurrencyPairs),
        child: CurrencyExchangeRateScreen(),
      ),
      routes: {

      },
    );
  }
}
