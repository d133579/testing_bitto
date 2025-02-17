import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing/domain/entities/currency.dart';
import 'package:testing/presentation/cubit/currency_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/presentation/screens/rate_conversion_screen.dart';

class CurrencyExchangeRateScreen extends StatefulWidget {
  const CurrencyExchangeRateScreen({super.key});

  @override
  State<CurrencyExchangeRateScreen> createState() =>
      _CurrencyExchangeRateScreenState();
}

class _CurrencyExchangeRateScreenState
    extends State<CurrencyExchangeRateScreen> {
  @override
  void initState() {
    super.initState();
    // 取得 Cubit 後觸發載入
    context.read<CurrencyCubit>().getCurrencyPairs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rate Table(TWD)')),
      body: BlocBuilder<CurrencyCubit, CurrencyState>(
        builder: (context, state) {
          if (state is CurrencyLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CurrencyLoaded) {
            final List<Currency> currencies = state.currencies;
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          'Currency',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Price',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: currencies.length,
                    itemBuilder: (context, index) {
                      final currency = currencies[index];
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: currency.icon,
                                    width: 30,
                                    height: 30,
                                    placeholder:
                                        (context, url) =>
                                            CircularProgressIndicator(),
                                    errorWidget:
                                        (context, url, error) =>
                                            Icon(Icons.error),
                                  ),
                                  SizedBox(width: 8),
                                  Text('${currency.currency} / TWD'),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(currency.formatedPrice()),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey)),
                  ),
                  child: Column(
                    children: [
                      Container(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/rate_conversion');
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // 設置圓角
                          ),
                          foregroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 16,
                          ), // 內距
                          textStyle: TextStyle(fontSize: 18), // 字體大小
                        ),
                        child: Text('Rate Conversion'),
                      ),
                      Container(height: 20),
                    ],
                  ),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
